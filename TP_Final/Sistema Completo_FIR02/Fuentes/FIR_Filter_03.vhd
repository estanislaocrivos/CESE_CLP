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
    type coef_array is array (0 to 12) of UNSIGNED(15 downto 0);
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
    type delay_line_type is array (0 to 12) of UNSIGNED(9 downto 0);
    signal delay_line : delay_line_type := (others => to_unsigned(0, 10));
    signal acc : UNSIGNED(28 downto 0) := (others => '0');
begin
    process (clk, reset)
        variable temp_acc : UNSIGNED(28 downto 0);
    begin
        if reset = '1' then
            acc <= (others => '0');
            delay_line <= (others => to_unsigned(0, 10));
        elsif rising_edge(clk) then
            for i in 0 to 11 loop
                delay_line(i) <= delay_line(i+1);
            end loop;
            delay_line(12) <= input_data;
            temp_acc := (others => '0');
            for i in 0 to 12 loop
                temp_acc := temp_acc + coeficientes(i) * delay_line(i);
            end loop;
            acc <= temp_acc;
        end if;
    end process;

    output_data <= RESIZE(acc, output_data'LENGTH);

end Behavioral;