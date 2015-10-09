----------------------------------------------------------------------------------
-- Company: 
-- Author: 	Mirko Gagliardi
-- 
-- Create Date:    01/10/2015
-- Design Name: 
-- Module Name:    Network Output Interface - rtl 
-- Project Name:   Router_Mesh	
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 	 
--
-- Revision: v 0.3
-- Additional Comments:
--		Network Output Interface gestisce i dati in uscita dal Router su un dato canale. Ogni dato � bufferizzato in una Fifo circolare. 
--		Quando la Fifo non � vuota tenta di inviare il dato in testa all'Input Interface Network del Router con cui � collegato. L'invio del
--		dato e l'attesa dell'ack sono gestiti con una FSM a due stati.
--
--			Output Interface				Input Interface
--			________________				__________________
--				       valid|-------------->|valid
--					Data_Out|-------------->|Data_In
--						ack	|<--------------|ack
--							|				|
--											
--		Quando il dato � pronto l'unit� di controllo asserisce valid e si pone in attesa dell'ack da parte del Router ricevente. La
--		FSM rester� in attesa dell'ack per un numero di cicli pari a quelli indicati nella verabiale COUNTER_WIDTH nel routerpack.
--
--
--		    Output Interface				Control Unit
--			________________				_________________	
--					    wren|<--------------|wren
--					   sdone|-------------->|sdone
--						full|-------------->|full
--							|				|________________							
--							|					
--							|				Crossbar
--							|				_________________
--					 Data_In|<--------------|Data_Out
--							|				|
--
--		Network Output Interface riceve i dati da inviare dalla Crossbar che collega tutti gli Network Input Interface del router a tutti
--		gli Network Output Interface. Quando il dato in ingresso � valido, la Control Unit asserisce wren. Se la FIFO non � piena, il dato
--		in ingresso � aggiunto in coda e sdone � asserito ad indicare che il salvataggio � stato effettuato correttamente. Se la Fifo � piena
--		full � alto e la Control Unit agir� di conseguenza.
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.logpack.all;
use work.routerpack.all;

entity net_output_interface is
	Generic (
		FIFO_LENGTH : natural := 16;
		DATA_WIDTH : natural := 16
	);
	Port (
		clk : in std_logic;
		reset : in std_logic;
		
		Data_In : in std_logic_vector(DATA_WIDTH-1 downto 0);   -- Data Input
		ack   : in std_logic;									-- Ack 
		wren  : in std_logic;									-- Write Enable
		
		sdone : out std_logic;									-- Store Done
		full  : out std_logic;									-- Fifo Full
		empty : out std_logic;									-- Fifo Empty
		valid : out std_logic;									-- Data Output valid
		Data_Out : out std_logic_vector(DATA_WIDTH-1 downto 0)  -- Data Output
	);
end entity net_output_interface;

architecture RTL of net_output_interface is
	
	constant MAX_VECT : std_logic_vector(f_log2(FIFO_LENGTH) downto 0) := conv_std_logic_vector(FIFO_LENGTH, f_log2(FIFO_LENGTH)+1);
	constant MIN_VECT : std_logic_vector(f_log2(FIFO_LENGTH) downto 0) := (others => '0');
	constant MIN_COUNT : std_logic_vector(f_log2(COUNTER_WIDTH)-1 downto 0) := (others => '0');
	constant MAX_COUNT : std_logic_vector(f_log2(COUNTER_WIDTH)-1 downto 0) := (others => '1');
	
	type fifo_type is array (0 to FIFO_LENGTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
	type state_type is (idle, wait_ack); 
	
	signal current_s : state_type; 
	
	signal fifo_memory : fifo_type := (others => (others => '0'));
	signal head_pt, tail_pt : std_logic_vector(f_log2(FIFO_LENGTH)-1 downto 0) := (others => '0');	
	signal ack_counter : std_logic_vector(f_log2(COUNTER_WIDTH)-1 downto 0) := (others => '0');
	signal fifo_full, fifo_empty : std_logic := '0';
	
begin
	
	fifo_full <= '1' when head_pt = (tail_pt + '1')
						else '0';
	
	fifo_empty <= '1' when head_pt = tail_pt		
						else '0'; 
	
	full <= fifo_full;
	empty <= fifo_empty;
	Data_Out <= fifo_memory(conv_integer(head_pt));
	

	Output_Interface_Control_Unit : process (clk, reset)
	begin
		if reset = '1' then
		  current_s <= idle;
		  valid <= '0';
		  sdone <= '0';
		  head_pt <= (others => '0');
		  tail_pt <= (others => '0');
		  fifo_memory <= (others => (others => '0'));
		
		elsif rising_edge(clk) then		
		  
		  valid <= '0';
		  sdone <= '0';
		  
		  case current_s is
		     when idle =>       
			     if wren = '1' and fifo_full = '0' then		-- Store data input
			      	fifo_memory(conv_integer(tail_pt)) <= Data_In; 
			      	sdone <= '1';
			      	tail_pt <= tail_pt + '1';
			      	current_s <= idle;
			    elsif fifo_empty = '0' then					-- Send Fifo first element
			    	valid <= '1';
					current_s <= wait_ack;
					ack_counter <= MIN_COUNT;				-- Set Ack counter
				 else
					current_s <= idle;
			     end if;   
		
			  when wait_ack =>      
			    if ack = '1' then
			    	valid <= '0';
					head_pt <= head_pt + '1';
					current_s <= idle;
				elsif ack_counter = MAX_COUNT then			-- Stop waiting ack and back idle
					current_s <= idle;
					valid <= '0';
				else
					ack_counter <= ack_counter + '1';
					valid <= '1';
				end if;
			    
			end case;
		
		end if;
	end process;

end architecture RTL;