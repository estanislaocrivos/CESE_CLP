library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_Filter_01 is
    port (
        clock_input   : in  std_logic;
        reset_input   : in  std_logic;
        x_input       : in  unsigned (9 downto 0);
        y_output      : out unsigned (20 downto 0);
        coeff_0       : in  signed(7 downto 0);
        coeff_1       : in  signed(7 downto 0);
        coeff_2       : in  signed(7 downto 0);
        coeff_3       : in  signed(7 downto 0);
        coeff_4       : in  signed(7 downto 0);
        coeff_5       : in  signed(7 downto 0);
        coeff_6       : in  signed(7 downto 0);
        coeff_7       : in  signed(7 downto 0);
        coeff_8       : in  signed(7 downto 0)
    );
end FIR_Filter_01;

architecture FIR_Filter_01_Architecture of FIR_Filter_01 is

    signal x_0, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8 : signed(9 downto 0) := (others => '0');
    signal p_0, p_1, p_2, p_3, p_4, p_5, p_6, p_7, p_8 : signed(17 downto 0) := (others => '0');
    signal s_01, s_23, s_34, s_56, s_78 : signed(19 downto 0) := (others => '0');
    signal y_aux : signed(20 downto 0) := (others => '0');
    signal read : std_logic := '0';
    signal total_coeff : unsigned(7 downto 0) := (others => '0');

begin

    reading : process(clock_input, reset_input)
    begin
        if reset_input = '0' then
            if rising_edge(clock_input) then
                if read = '0' then
                    x_8 <= x_7;
                    x_7 <= x_6;
                    x_6 <= x_5;
                    x_5 <= x_4;
                    x_4 <= x_3;
                    x_3 <= x_2;
                    x_2 <= x_1;
                    x_1 <= x_0;
                    x_0 <= signed(x_input);
                    read <= '1';
                    y_output <= unsigned(y_aux/100);
                    read <= '0';
                end if;
            end if;
        end if;
    end process reading;

    product : process(clock_input)
    begin
        if rising_edge(clock_input) then
            p_0 <= x_0 * coeff_0;
            p_1 <= x_1 * coeff_1;
            p_2 <= x_2 * coeff_2;
            p_3 <= x_3 * coeff_3;
            p_4 <= x_4 * coeff_4;
            p_5 <= x_5 * coeff_5;
            p_6 <= x_6 * coeff_6;
            p_7 <= x_7 * coeff_7;
            p_8 <= x_8 * coeff_8;
        end if;
    end process product;

    partial_summations : process(clock_input)
    begin
        if rising_edge(clock_input) then
            s_01 <= resize(p_0 + p_1, s_01'length);
            s_23 <= resize(p_2 + p_3, s_23'length);
            s_34 <= resize(p_3 + p_4, s_34'length);
            s_56 <= resize(p_5 + p_6, s_56'length);
            s_78 <= resize(p_7 + p_8, s_78'length);
        end if;
    end process partial_summations;

    total_summation : process(clock_input)
    begin
        if rising_edge(clock_input) then
            y_aux <= resize(s_01 + s_23 + s_34 + s_56 + s_78, y_aux'length);
        end if;
    end process total_summation;

end FIR_Filter_01_Architecture;
