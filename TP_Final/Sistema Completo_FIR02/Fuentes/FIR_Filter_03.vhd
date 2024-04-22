library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIR_Filter is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        input_data : in UNSIGNED(9 downto 0);
        output_data : out UNSIGNED(31 downto 0)
    );
end FIR_Filter;

architecture Behavioral of FIR_Filter is

    -- Filter coefficients array
    type coef_array is array (0 to 12) of UNSIGNED(15 downto 0);

    -- Filter coefficients definition
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

    -- Delay line type definition
    type delay_line_type is array (0 to 12) of UNSIGNED(9 downto 0);

    -- Delay line signal 
    signal delay_line : delay_line_type := (others => to_unsigned(0, 10));

    -- Accumulator signal
    signal acc : UNSIGNED(28 downto 0) := (others => '0');

begin

    process (clk, reset)
        -- Temporal accumulator
        variable temp_acc : UNSIGNED(28 downto 0);
    begin
        if reset = '1' then
            acc <= (others => '0');
            delay_line <= (others => to_unsigned(0, 10));
        elsif rising_edge(clk) then
            -- Shift the delay line
            for i in 0 to 11 loop
                delay_line(i) <= delay_line(i+1);
            end loop;

            -- Insert the new sample at the end of the delay line
            delay_line(12) <= input_data;

            -- Calculate the new accumulator value
            temp_acc := (others => '0');
            for i in 0 to 12 loop
                temp_acc := temp_acc + coeficientes(i) * delay_line(i);
            end loop;

            -- Update the accumulator value
            acc <= temp_acc;
        end if;
    end process;

    output_data <= RESIZE(acc, output_data'LENGTH);

end Behavioral;