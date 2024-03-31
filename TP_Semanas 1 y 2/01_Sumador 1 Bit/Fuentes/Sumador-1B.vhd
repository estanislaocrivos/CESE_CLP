library IEEE;
use IEEE.std_logic_1164.all;

entity Sumador_1B is
    port
    (
        a_input: in std_logic; -- First bit	
        b_input: in std_logic; -- Second bit
		ci_input: in std_logic; -- Carry input
		co_output: out std_logic; -- Carry output
		s_output: out std_logic -- Result
    );
end;

architecture Sumador_1B_Architecture of Sumador_1B is
    -- Parte declarativa

begin
    -- Parte descriptiva

    s_output <= a_input xor b_input xor ci_input; -- Suma
	co_output <= (a_input and ci_input) or (a_input and b_input) or (b_input and ci_input); -- Calcula carry out
end;
