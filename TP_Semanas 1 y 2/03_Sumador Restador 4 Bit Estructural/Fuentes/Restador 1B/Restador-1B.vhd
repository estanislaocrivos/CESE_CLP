library IEEE;
use IEEE.std_logic_1164.all;

-- Implementation of full substractor with borrow in and borrow out

entity Restador_1B is
    port
    (
        a_input: in std_logic; -- First bit	
        b_input: in std_logic; -- Second bit
		bi_input: in std_logic; -- Borrow input
		bo_output: out std_logic; -- Borrow output
		s_output: out std_logic -- Result
    );
	
	signal auxiliary: std_logic;
end;

architecture Restador_1B_Architecture of Restador_1B is
    -- Parte declarativa
	
begin
    -- Parte descriptiva
	
	auxiliary <= a_input xor b_input;

    s_output <= (a_input xor b_input) xor bi_input; -- Resta 
	
	bo_output <= ((not a_input) and b_input) or (not auxiliary and bi_input); -- Borrow out
end;
