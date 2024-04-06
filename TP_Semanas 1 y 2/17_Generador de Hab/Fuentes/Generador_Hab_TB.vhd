library IEEE;
use IEEE.std_logic_1164.all;

entity Generador_Hab_TB is
    
end;

architecture Generador_Hab_TB_Architecture of Generador_Hab_TB is
    -- Parte declarativa

    component Generador_Hab is
        port(
            clock_input:    in std_logic;
            reset_input:    in std_logic;
            enable_input:   in std_logic;
            q_output:       out std_logic;
            N:              integer
        );
    end component;

    signal clock_tb:    std_logic := '0';
    signal reset_tb:    std_logic := '0';
    signal enable_tb:   std_logic := '0';
    signal q_tb:        std_logic;

begin
    -- Parte descriptiva

    clock_tb    <= not clock_tb after 10 ns;
    reset_tb    <= '0' after 100 ns;
    enable_tb   <= '1' after 200 ns;

    DUT: Generador_Hab 
    port map
    (
        clock_input => clock_tb,
        reset_input => reset_tb,
        enable_input => enable_tb,
        q_output => q_tb,
        N => 3
    );

end;
