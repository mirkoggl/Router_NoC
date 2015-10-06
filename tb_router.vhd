library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.logpack.all;
use work.routerpack.all;
 
ENTITY tb_router IS
END tb_router;
 
ARCHITECTURE behavior OF tb_router IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    component router_mesh is
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
	end component router_mesh;
    
	constant LOCAL_X : natural := 1;
	constant LOCAL_Y : natural := 1; 
   --Inputs
   signal clk, reset : std_logic := '0';
   
   signal Data_In, Data_Out :  data_array_type := (others => (others => '0'));
   signal Empty_Out, Ack_Out, Valid_Out, Ack_In, Valid_In :  std_logic_vector(CHAN_NUMBER - 1 downto 0) := (others => '0');
	
	-- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
 	
	-- Instantiate the Unit Under Test (UUT)
   uut : router_mesh
   	generic map(
   		LOCAL_X => LOCAL_X,
   		LOCAL_Y => LOCAL_Y
   	)
   	port map(
   		clk       => clk,
   		reset     => reset,
   		Data_In   => Data_In,
   		Ack_Out   => Ack_Out,
   		Valid_In  => Valid_In,
   		Data_Out  => Data_Out,
   		Valid_Out => Valid_Out,
   		Ack_In    => Ack_In
   	);
 
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
   	-- hold reset state for 100 ns.
   	  reset <= '1';
   	  Data_In(LOCAL_ID) <= x"D000"; -- Local ha un pacchetto per X=3 Y=1 
   	  Data_In(NORTH_ID) <= x"9000"; -- North X=2 Y=1
   	  Data_In(EAST_ID)  <= x"5000"; -- East X=1 Y=1 (questo nodo)
   	  Data_In(WEST_ID)  <= x"7000"; -- West X=1 Y=3
   	  Data_In(SOUTH_ID) <= x"F000"; -- South X=3 Y=3
    	  
      wait for 100 ns;	
	  reset <= '0';
	  Valid_In(LOCAL_ID) <= '1';
	  
	  wait until Ack_Out (LOCAL_ID) = '1';
	  Valid_In(LOCAL_ID) <= '0';
	  
--	  wait for clk_period;
--	  Valid_In(NORTH_ID) <= '1';
	  
--	  wait until Ack_Out (NORTH_ID) = '1';
--	  Valid_In(NORTH_ID) <= '0';
	  
--	  wait for clk_period;
--	  Valid_In(EAST_ID) <= '1';
	  
--	  wait until Ack_Out (EAST_ID) = '1';
--	  Valid_In(EAST_ID) <= '0';
	  
--	  wait for clk_period;
--	  Valid_In(WEST_ID) <= '1';
	  
--	  wait until Ack_Out (WEST_ID) = '1';
--	  Valid_In(WEST_ID) <= '0';
	  
--	  wait for clk_period;
--	  Valid_In(SOUTH_ID) <= '1';
	  
--	  wait until Ack_Out (SOUTH_ID) = '1';
--	  Valid_In(SOUTH_ID) <= '0';

      wait;
   end process;

END;