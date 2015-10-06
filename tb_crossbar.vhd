library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.logpack.all;
use work.routerpack.all;
 
ENTITY tb_crossbar IS
END tb_crossbar;
 
ARCHITECTURE behavior OF tb_crossbar IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    component crossbar
		Port(
			sel	   : in crossbar_sel_type;
			Data_In  : in data_array_type;
			Data_Out : out data_array_type
		);
	end component crossbar;
    
   --Inputs
   signal sel : crossbar_sel_type := (others => (others => '0'));
   signal Data_In, Data_Out :  data_array_type := (others => (others => '0'));
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut : crossbar
   	port map(
   		sel      => sel,
   		Data_In  => Data_In,
   		Data_Out => Data_Out
   	);
 
   -- Stimulus process
   stim_proc: process
   begin		
   	-- hold reset state for 100 ns.
   	  Data_In(LOCAL_ID) <= x"D000"; -- Local ha un pacchetto per X=3 Y=1 
   	  Data_In(NORTH_ID) <= x"9000"; -- North X=2 Y=1
   	  Data_In(EAST_ID)  <= x"5000"; -- East X=1 Y=1 (questo nodo)
   	  Data_In(WEST_ID)  <= x"7000"; -- West X=1 Y=3
   	  Data_In(SOUTH_ID) <= x"F000"; -- South X=3 Y=3
    	  
      wait for 100 ns;	
	  sel(LOCAL_ID) <= CONV_STD_LOGIC_VECTOR(1, 3);
	  sel(NORTH_ID) <= CONV_STD_LOGIC_VECTOR(0, 3);
	  sel(EAST_ID)  <= CONV_STD_LOGIC_VECTOR(3, 3);
	  sel(WEST_ID)  <= CONV_STD_LOGIC_VECTOR(2, 3);
	  sel(SOUTH_ID) <= CONV_STD_LOGIC_VECTOR(4, 3); 

      wait;
   end process;

END;