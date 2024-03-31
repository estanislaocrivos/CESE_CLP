library IEEE;
use IEEE.std_logic_1164.all;

entity Negador is
    port
    (
        reset_input: in std_logic;
		clock_input: in std_logic;
		enable_input: in std_logic;
        count_output: out std_logic;
		max_output: out std_logic
    );
end;

architecture Negador_architecture of Negador is
    -- Parte declarativa
	signal SalAnd, SalOr, SalSum: std_logic;
	signal SalReg: std_logic_vector(3 downto 0);


begin
    -- Parte descriptiva
	

end;
