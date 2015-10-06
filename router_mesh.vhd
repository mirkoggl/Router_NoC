library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.logpack.all;
use work.routerpack.all;

entity router_mesh is
	Generic (
		LOCAL_X : natural := 1;
		LOCAL_Y : natural := 1
	);
	Port (
		clk : in std_logic;
		reset : in std_logic;
		
		Data_In   : in data_array_type;
		Ack_Out   : out std_logic_vector(CHAN_NUMBER-1 downto 0);
		Valid_In  : in std_logic_vector(CHAN_NUMBER-1 downto 0);
		
		Data_Out  : out data_array_type;
		Valid_Out : out std_logic_vector(CHAN_NUMBER-1 downto 0);
		Ack_In    : in std_logic_vector(CHAN_NUMBER-1 downto 0)
	);
end entity router_mesh;

architecture RTL of router_mesh is
	
    COMPONENT net_output_interface is
		Generic (
			FIFO_LENGTH : natural := 16;
			DATA_WIDTH : natural := 16
		);
		Port (
			clk : in std_logic;
			reset : in std_logic;
			
			Data_In : in std_logic_vector(DATA_WIDTH-1 downto 0);
			ack   : in std_logic;
			wren  : in std_logic;
			
			sdone : out std_logic;
			full  : out std_logic;
			empty : out std_logic;
			valid : out std_logic;
			Data_Out : out std_logic_vector(DATA_WIDTH-1 downto 0)
		);
    END COMPONENT;
	 
	 COMPONENT net_input_interface is
		Generic (
			FIFO_LENGTH : natural := 16;
			DATA_WIDTH : natural := 16
		);
		Port (
			clk : in std_logic;
			reset : in std_logic;
			
			Data_In : in std_logic_vector(DATA_WIDTH-1 downto 0);
			valid   : in std_logic;
			shft	  : in std_logic;
			
			sdone : out std_logic;
			ack   : out std_logic;
			full  : out std_logic;
			empty : out std_logic;
			Data_Out : out std_logic_vector(DATA_WIDTH-1 downto 0)
		);
	END COMPONENT;
	
	COMPONENT crossbar
		Port(
			sel	   : in crossbar_sel_type;
			Data_In  : in data_array_type;
			Data_Out : out data_array_type
		);
	END COMPONENT;
	
	COMPONENT router_control_unit
		Generic(
			LOCAL_X : natural := 1;
			LOCAL_Y : natural := 1);
		Port(
			clk       : in  std_logic;
			reset     : in  std_logic;
			Data_In   : in  data_array_type;
			Empty_Out : in  std_logic_vector(CHAN_NUMBER - 1 downto 0);
			Full_Out  : in  std_logic_vector(CHAN_NUMBER - 1 downto 0);
			Sdone_In  : in  std_logic_vector(CHAN_NUMBER - 1 downto 0);
			Sdone_Out : in  std_logic_vector(CHAN_NUMBER - 1 downto 0);
			Shft_In   : out std_logic_vector(CHAN_NUMBER - 1 downto 0);
			Wr_En_Out : out std_logic_vector(CHAN_NUMBER - 1 downto 0);
			Cross_Sel : out crossbar_sel_type
		);
	END COMPONENT router_control_unit;
	 
	 -- Input Interface Signals
	 signal ii_shft_vector : std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
	 signal ii_sdone_vector : std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
	 signal ii_full_vector :  std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
	 signal ii_empty_vector :  std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
	 
	 -- Output Interface Signals
	 signal oi_wren_vector : std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
	 signal oi_sdone_vector : std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
     signal oi_full_vector :  std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
	 signal oi_empty_vector :  std_logic_vector(CHAN_NUMBER-1 downto 0) := (others => '0');
	 
	 -- Crossbar Signals
	 signal cb_data_in, cb_data_out : data_array_type := (others => (others => '0'));
	 signal cb_sel : crossbar_sel_type := (others => (others => '0'));
	 
begin
	
  -----------------------------------------------------------------------
  -- Network Input Interfaces
  -----------------------------------------------------------------------	

	Input_Interface_GEN : for i in 0 to CHAN_NUMBER-1 generate 
		InputInterfaceX : net_input_interface
			generic map(
				FIFO_LENGTH => FIFO_LENGTH,
				DATA_WIDTH  => DATA_WIDTH
			)
			port map(
				clk      => clk,
				reset    => reset,
				Data_In  => Data_In(i),
				valid    => Valid_In(i),
				shft     => ii_shft_vector(i),
				sdone    => ii_sdone_vector(i),
				ack      => Ack_Out(i),
				full     => ii_full_vector(i),
				empty    => ii_empty_vector(i),
				Data_Out => cb_data_in(i)
			);
	end generate;
	
  -----------------------------------------------------------------------
  -- Control Unit
  -----------------------------------------------------------------------		
  
	CU_inst : router_control_unit
		generic map(
			LOCAL_X => LOCAL_X,
			LOCAL_Y => LOCAL_Y
		)
		port map(
			clk       => clk,
			reset     => reset,
			Data_In   => cb_data_in,
			Empty_Out => ii_empty_vector,
			Full_Out  => oi_full_vector,
			Sdone_In  => ii_sdone_vector,
			Sdone_Out => oi_sdone_vector,
			Shft_In   => ii_shft_vector,
			Wr_En_Out => oi_wren_vector,
			Cross_Sel => cb_sel
		);
						 
  -----------------------------------------------------------------------
  -- Crossbar
  -----------------------------------------------------------------------	
  
  Crossbar_inst : crossbar
  	Port Map(
  		sel      => cb_sel,
  		Data_In  => cb_data_in,
  		Data_Out => cb_data_out
  	);
					 
  -----------------------------------------------------------------------
  -- Network Output Interfaces
  -----------------------------------------------------------------------	
  
  Output_Interface_GEN : for i in 0 to CHAN_NUMBER-1 generate
  		OutputInterfaceX : net_output_interface
  			generic map(
  				FIFO_LENGTH => FIFO_LENGTH,
  				DATA_WIDTH  => DATA_WIDTH
  			)
  			port map(
  				clk      => clk,
  				reset    => reset,
  				Data_In  => cb_data_out(i),
  				ack      => Ack_In(i),
  				wren     => oi_wren_vector(i),
  				sdone    => oi_sdone_vector(i),
  				full     => oi_full_vector(i),
  				empty    => oi_empty_vector(i),
  				valid    => Valid_Out(i),
  				Data_Out => Data_Out(i)
  			);	 
  end generate;

end architecture RTL;