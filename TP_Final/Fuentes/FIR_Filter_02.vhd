library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Implementación de un filtro FIR en VHDL para la placa de desarrollo Arty Z7-10
-- Autor: Estanislao Crivos
-- Fecha: April 2024
-- Materia: Circuitos Lógicos Programables - CESE CO20 - FI UBA

-- FIR filter entity
entity FIR_Filter is
    port 
    (
        clock : in  STD_LOGIC;                      -- Input clock signal
        reset : in  STD_LOGIC;                      -- Input reset signal
        in    : in  STD_LOGIC_VECTOR (15 downto 0); -- Input data serial port
        out   : out STD_LOGIC_VECTOR (15 downto 0)  -- Output data serial port
    );
end FIR_Filter;

-- FIR filter architecture
architecture behavioural of FIR_Filter is

    -- Filter coefficients array
    type coefficients_array is array (0 to 18) of STD_LOGIC_VECTOR (15 downto 0); 

    -- Shift register array, where shifted samples are stored
    type shift_array is array (0 to 18) of STD_LOGIC_VECTOR (15 downto 0); 
    
    -- Signals declaration
    signal coefficients : coefficients_array;                -- Filter coefficients
    signal shift : shift_array;                              -- Shift register
    signal mac_accumulator : STD_LOGIC_VECTOR (35 downto 0); -- Accumulator for MAC operation
    signal count : unsigned(6 downto 0);                     -- Counter for shift register

begin

    process(clock)
        variable i, j : integer;
    begin
        if rising_edge(clock) then
            if reset = '1' then
                -- Initialize filter coefficients values
                coefficients(0)  <= to_unsigned(26, 16);
                coefficients(1)  <= to_unsigned(270, 16);
                coefficients(2)  <= to_unsigned(963, 16);
                coefficients(3)  <= to_unsigned(2424, 16);
                coefficients(4)  <= to_unsigned(4869, 16);
                coefficients(5)  <= to_unsigned(8259, 16);
                coefficients(6)  <= to_unsigned(12194, 16);
                coefficients(7)  <= to_unsigned(15948, 16);
                coefficients(8)  <= to_unsigned(18666, 16);
                coefficients(9)  <= to_unsigned(19660, 16);
                coefficients(10) <= to_unsigned(18666, 16);
                coefficients(11) <= to_unsigned(15948, 16);
                coefficients(12) <= to_unsigned(12194, 16);
                coefficients(13) <= to_unsigned(8259, 16);
                coefficients(14) <= to_unsigned(4869, 16);
                coefficients(15) <= to_unsigned(2424, 16);
                coefficients(16) <= to_unsigned(963, 16);
                coefficients(17) <= to_unsigned(270, 16);
                coefficients(18) <= to_unsigned(26, 16);
                count <= (others => '0'); -- Reset counter
            else 
                if count < 19 then 
                    -- Shift samples in the shift register until it is full
                    shift(count) <= in;
                    count <= count + 1;
                else 
                    for i in 18 downto 1 loop
                        shift(i-1) <= shift(i); -- Shift one sample at a time
                    end loop;
                    shift(18) <= in; -- Fill last position with new sample
                end if;
            end if;
        end if;
    end process;

    process(clock)
        variable i, j : integer;
    begin
        if rising_edge(clock) then
            if count > 18 then
                mac_accumulator <= (others => '0'); -- Reset accumulator
                for j in 0 to 18 loop
                    -- Multiply and accumulate operation
                    mac_accumulator <= std_logic_vector(unsigned(mac_accumulator) + (unsigned(coefficients(j)) * unsigned(shift(j))));
                end loop;
                for j in 0 to 15 loop
                    -- Output result
                    out(j) <= mac_accumulator(20+j);
                end loop;
            end if;
        end if;
    end process;

end behavioural;
