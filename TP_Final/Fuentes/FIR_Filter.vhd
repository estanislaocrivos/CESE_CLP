library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Implementation of a simple FIR filter with defined coefficients
-- The input signal is an 8-bit signal
-- The output signal is a 16-bit signal
-- The filter taps are 16-bit coefficients

entity FIR_Filter is

    generic
    (
        M : integer := 8 -- Number of filter taps (coefficients)
    );
    Port
    ( 
        clock_input   : in  STD_LOGIC; -- Clock input
        reset_input   : in  STD_LOGIC; -- Reset input
        x_input       : in  STD_LOGIC_VECTOR (15 downto 0); -- Filter input
        y_output      : out STD_LOGIC_VECTOR (15 downto 0)  -- Filter output

        -- Filter coefficients
        coeff_0 : in  signed(7 downto 0);
        coeff_1 : in  signed(7 downto 0);
        coeff_2 : in  signed(7 downto 0);
        coeff_3 : in  signed(7 downto 0);
        coeff_4 : in  signed(7 downto 0);
        coeff_5 : in  signed(7 downto 0);
        coeff_6 : in  signed(7 downto 0);
        coeff_7 : in  signed(7 downto 0);
        coeff_8 : in  signed(7 downto 0)
    );

end FIR_Filter;

architecture FIR_Filter_Architecture of FIR_Filter is

    -- Parte Declarativa
    
    -- Buffers for delayed samples
    signal x_0   :signed(7 downto 0) := (others => '0'); 
	signal x_1   :signed(7 downto 0) := (others => '0'); 
	signal x_2   :signed(7 downto 0) := (others => '0'); 
	signal x_3   :signed(7 downto 0) := (others => '0'); 

    -- Buffers for products (delayed samples * coefficients)
	signal p_0   :signed(15 downto 0) := (others => '0'); 
	signal p_1   :signed(15 downto 0) := (others => '0'); 
	signal p_2   :signed(15 downto 0) := (others => '0'); 
	signal p_3   :signed(15 downto 0) := (others => '0');

    -- Buffers for partial sums
	signal s_01   :signed(16 downto 0) := (others => '0'); 
	signal s_23   :signed(16 downto 0) := (others => '0'); 

    -- Auxiliary buffer for total sum
	signal y_aux :signed(17 downto 0) := (others => '0'); 

	--tot out
	signal total_output : std_logic_vector(7 downto 0) := (others => '0'); 

	signal read : std_logic:='1';							-- 1 if we have already read the number, 0 if not

	signal t_count: signed(3 downto 0) := (others => '0');
    
begin   
    -- Parte descriptiva

    reading : process(clock_input)
    begin
        if rising_edge(clock_input) then

            if (reset_input = '0' and read ='0') then
                -- Shift the samples one by one
                x_3 <= x_2;
                x_2 <= x_1;
                x_1 <= x_0;
                x_0 <= signed(data_in); -- Assign latest sample to x_0
                read <= '1';
                y_output <= total_output;
            end if;

            if reset_input = '1' then 
                read <= '0'; 
                y_output <= (others => '0');
            end if;
        
        end if;	

    end process reading;

        
    product : process(clock_input)
    begin
        if rising_edge(clock_input) then
            -- Compute the products of the samples with the filter coefficients
            p_0 <= x_0*(coeff_0);				
            p_1 <= x_1*(coeff_1);				
            p_2 <= x_2*(coeff_2);				
            p_3 <= x_3*(coeff_3);
        end if;	

    end process product;

    partial_summations : process(clock_input)
    begin
        if rising_edge(clock_input) then
            s_01<=resize(p_0, 18)+resize(p_1, 18);
            s_23<=resize(p_2, 18)+resize(p_3, 18);
        end if;	

    end process partial_summations;

    total_summation : process(clock_input)
    begin
        if rising_edge(clock_input) then
            y_aux <= resize(s_01, 19)+resize(s_23, 19);
        end if;	

    end process total_summation;

    output : process(clock_input)
    begin
        if rising_edge(clock_input) then
            total_output <= std_logic_vector(resize(shift_right(y_aux,11),8));		--from 19 to 8 bits and from signed to logic_vector 
        end if;	

    end process output;

end FIR_Filter_Architecture;