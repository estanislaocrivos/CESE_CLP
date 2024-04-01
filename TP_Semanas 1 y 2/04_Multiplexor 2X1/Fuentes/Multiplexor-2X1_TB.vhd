library IEEE;
use IEEE.std_logic_1164.all;

-- Multiplexor 2X1: two inputs, one output.

entity MUX_2X1_TB is

end;

architecture MUX_2X1_Architecture of MUX_2X1_TB is
    -- Parte declarativa
	
	component MUX_2X1 is
		port
		(
			a_input: in std_logic; 		-- First  input	
			b_input: in std_logic; 		-- Second input
			sel_input: in std_logic; 	-- Control input: 0 multiplexes first input, 1 multiplexes second input
			c_output: out std_logic 	-- Multiplexed output
		);
	end component;
	
	signal a_tb: std_logic := '0';
	signal b_tb: std_logic := '0';
	signal selector_tb: std_logic := '0';
	signal c_tb: std_logic;

begin
    -- Parte descriptiva
	
	a_tb <= not a_tb after 50 ns;
	b_tb <= not b_tb after 100 ns;
	selector_tb <= not selector_tb after 200 ns;
	
	DUT: MUX_2X1
		port map
		(
			a_input => a_tb,
			b_input => b_tb,
			sel_input => selector_tb,
			c_output => c_tb
		);
end;
