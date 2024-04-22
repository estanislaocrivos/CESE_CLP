library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Implementación de un filtro FIR en VHDL 
-- Autor: Estanislao Crivos
-- Fecha: Abril 2024
-- Trabajo Final - Circuitos Lógicos Programables - CESE CO20 - FI UBA

entity FIR_Filter is
    port 
	(
        clk : in STD_LOGIC; 					-- Filter clock input
        reset : in STD_LOGIC; 					-- Filter reset input (0 is operative)
        input_data : in UNSIGNED(9 downto 0); 	-- Filter serial input
        output_data : out UNSIGNED(31 downto 0) -- Filter serial output
    );
end FIR_Filter;

architecture FIR_Filter_Architecture of FIR_Filter is

    -- Filter coefficients array type declaration
    type coef_array is array (0 to 12) of UNSIGNED(15 downto 0);

    -- Filter coefficients array definition
    constant coeficientes : coef_array := (
        to_unsigned(0, 16),
        to_unsigned(0, 16),
        to_unsigned(75, 16),
        to_unsigned(430, 16),
        to_unsigned(1200, 16),
        to_unsigned(2100, 16),
        to_unsigned(2500, 16),
        to_unsigned(2100, 16),
        to_unsigned(1200, 16),
        to_unsigned(430, 16),
        to_unsigned(75, 16),
        to_unsigned(0, 16),
        to_unsigned(0, 16)
    );

    -- Delay line type declaration. This is where delayed samples will be stored
    type delay_line_type is array (0 to 12) of UNSIGNED(9 downto 0);

    -- Delay line signal definition
    signal delay_line : delay_line_type := (others => to_unsigned(0, 10));

    -- Accumulator signal. This is where the sum of the products coeffs*samples will be stored
    signal accumulator : UNSIGNED(28 downto 0) := (others => '0');

begin

    process (clk, reset)
        -- Temporal accumulator for calculating the MAC operations
        variable temp_accumulator : UNSIGNED(28 downto 0);
    begin
        if reset = '1' then
		
			-- Null output
            accumulator <= (others => '0');
            delay_line <= (others => to_unsigned(0, 10));
			
        elsif rising_edge(clk) then
		
            -- Shift the delay line
            for i in 0 to 11 loop
                delay_line(i) <= delay_line(i+1);
            end loop;

            -- Inserts the new sample at the end of the delay line
            delay_line(12) <= input_data;

            -- Calculate the new accumulatorumulator value
            temp_accumulator := (others => '0');
            for i in 0 to 12 loop
                temp_accumulator := temp_accumulator + coeficientes(i) * delay_line(i);
            end loop;

            -- Update the accumulator value
            accumulator <= temp_accumulator;
        end if;
    end process;

	-- Assing accumulator value to filter output
    output_data <= RESIZE(accumulator, output_data'LENGTH);

end FIR_Filter_Architecture;