library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIR_Filter_01_TB is

end FIR_Filter_01_TB;

architecture FIR_Filter_01_TB_Architecture of FIR_Filter_01_TB is

    -- Parte Declarativa

    component FIR_Filter_01 is

        Port
        ( 
            clock_input   : in  STD_LOGIC; -- Clock input
            reset_input   : in  STD_LOGIC; -- Reset input
            x_input       : in  STD_LOGIC_VECTOR (7 downto 0); -- Filter input
            y_output      : out STD_LOGIC_VECTOR (7 downto 0)  -- Filter output
    
            -- Filter coefficients (9 coefficients)
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
    
    end component;

    signal clock_input_TB : STD_LOGIC := '0';
    signal reset_input_TB : STD_LOGIC := '0';
    signal data_in_TB : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal data_out_TB : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    
begin   
    -- Parte descriptiva
    

end FIR_Filter_01_TB_Architecture;
