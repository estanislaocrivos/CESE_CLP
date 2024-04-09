library IEEE;
use IEEE.std_logic_1164.all;

entity Generador_Hab is
    generic
    (
        N: integer := 10
    );
    port
    (
        clock_input:    in std_logic;
        reset_input_input:    in std_logic;
        enable_input:   in std_logic;
        q_output:       out std_logic
    );
end;

architecture Generador_Hab_Architecture of Generador_Hab is
    -- Parte declarativa

    signal counter: integer;

begin
    -- Parte descriptiva

    process(clock_input)

        variable aux: integer;

    begin

        if rising_edge(clock_input) then
            if reset_input = '1' then
                aux := 0;
                q_output <= '0';
            elsif enable_input = '1' then
                aux := aux + 1;
                if aux = N then
                    aux := 0;
                    q_output <= '1';
                else
                    q_output <= '0';
                end if;
            end if;
        end if;

        counter <= aux;
        
    end process;

end;
