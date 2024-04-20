library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Implementación de un filtro FIR en VHDL para la placa de desarrollo Arty Z7-10
-- Autor: Estanislao Crivos
-- Fecha: April 2024
-- Materia: Circuitos Lógicos Programables - CESE CO20 - FI UBA

-- FIR filter entity
entity FIR_Filter_02 is
    port 
    (
        clock : in  STD_LOGIC;                      -- Input clock signal
        reset : in  STD_LOGIC;                      -- Input reset signal
        filter_input    : in  unsigned (9 downto 0); -- Input data serial port
        filter_output   : out unsigned (35 downto 0)  -- Output data serial port
    );
end FIR_Filter_02;

-- FIR filter architecture
architecture behavioural of FIR_Filter_02 is

    -- Filter coefficients array
    type coefficients_array is array (0 to 12) of unsigned (15 downto 0); 

    -- Shift register array, where shifted samples are stored
    type shift_array is array (0 to 12) of unsigned (9 downto 0); 
    
    -- Signals declaration
    signal coefficients : coefficients_array;                -- Filter coefficients
    signal shift : shift_array;                              -- Shift register
    signal mac_accumulator : unsigned (35 downto 0); -- Accumulator for MAC operation
    signal count : unsigned(6 downto 0);                     -- Counter for shift register

begin

    process(clock)
        variable i, j : integer;
    begin
        if rising_edge(clock) then
            if reset = '1' then
                -- Initialize filter coefficients values
                coefficients(0)  <= to_unsigned(0, 16);
                coefficients(1)  <= to_unsigned(0, 16);
                coefficients(2)  <= to_unsigned(75, 16);
                coefficients(3)  <= to_unsigned(430, 16);
                coefficients(4)  <= to_unsigned(1200, 16);
                coefficients(5)  <= to_unsigned(2100, 16);
                coefficients(6)  <= to_unsigned(2500, 16);
                coefficients(7)  <= to_unsigned(2100, 16);
                coefficients(8)  <= to_unsigned(1200, 16);
                coefficients(9)  <= to_unsigned(430, 16);
                coefficients(10) <= to_unsigned(75, 16);
                coefficients(11) <= to_unsigned(0, 16);
                coefficients(12) <= to_unsigned(0, 16);
                count <= (others => '0'); -- Reset counter
            else 
                if count < 13 then 
                    -- Shift samples in the shift register until it is full
                    shift(to_integer(count)) <= filter_input;
                    count <= count + 1;
                else 
                    for i in 12 downto 1 loop
                        shift(i-1) <= shift(i); -- Shift one sample at a time
                    end loop;
                    shift(12) <= filter_input; -- Fill last position with new sample
                end if;
            end if;
        end if;
    end process;

    process(clock)
        variable i, j : integer;
    begin
        if rising_edge(clock) then
            if count > 12 then
                mac_accumulator <= (others => '0'); -- Reset accumulator
                for j in 0 to 12 loop
                    -- Multiply and accumulate operation
                    -- mac_accumulator <= unsigned(mac_accumulator) + to_unsigned(coefficients(j) * shift(j), 26);
                    -- mac_accumulator <= unsigned(mac_accumulator) + unsigned(to_integer(coefficients(j)) * to_integer(shift(j)));
                    mac_accumulator <= mac_accumulator + to_unsigned(to_integer(coefficients(j)) * to_integer(shift(j)), mac_accumulator'length);
                    end loop;

                filter_output <= mac_accumulator;
                -- for j in 0 to 15 loop
                --     -- Output result
                --     filter_output(j) <= mac_accumulator(20+j);
                -- end loop;
            end if;
        end if;
    end process;

end behavioural;
