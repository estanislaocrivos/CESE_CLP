library IEEE;
use IEEE.std_logic_1164.all;

entity Negador is
    port
    (
        a_input: in std_logic;
        b_output: out std_logic
    );
end;

architecture Negador_architecture of Negador is
    -- Parte declarativa

begin
    -- Parte descriptiva

    b_output <= not a_input;

end;
