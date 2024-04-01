library IEEE;
use IEEE.std_logic_1164.all;

-- Multiplexor 2X1: two inputs, one output.

entity MUX_2X1 is
    port
    (
        a_input: in std_logic; 		-- First  input	
        b_input: in std_logic; 		-- Second input
		sel_input: in std_logic; 	-- Control input: 0 multiplexes first input, 1 multiplexes second input
		c_output: out std_logic 	-- Multiplexed output
    );
end;

architecture MUX_2X1_Architecture of MUX_2X1 is
    -- Parte declarativa

begin
    -- Parte descriptiva
	
	c_output <= ((not sel_input) and a_input) or (sel_input and b_input);
end;
