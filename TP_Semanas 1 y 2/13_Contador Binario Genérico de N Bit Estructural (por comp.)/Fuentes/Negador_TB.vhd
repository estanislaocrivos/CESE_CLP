library IEEE;
use IEEE.std_logic_1164.all;

entity Negador_TB is

end;

architecture Negador_TB_architecture of Negador_TB is
    -- Parte declarativa

    component Negador is
        port
        (
            a_input: in std_logic;
            b_output: out std_logic
        );
    end component;

    signal a_tb: std_logic := '1';
    signal b_tb: std_logic;
        
begin
    -- Parte descriptiva

    a_tb <= '0' after 100ns, '1' after 250ns;

    DUT: Negador
        port map
    	(
            a_input => a_tb, 
            b_output => b_tb 
        );

end;
