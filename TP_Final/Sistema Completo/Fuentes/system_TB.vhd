------------------------------------------------------------------------------
----                                                                      ----
----  NCO (Numerically Controlled Oscilator)                              ----
----                                                                      ----                                                                        ----
------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;   -- se usa para instanciar la ROM

entity system_TB is

end;

architecture system_TB_Architecture of system_TB is

	component nco is
		generic(
			DATA_W: natural := 11; 		-- cantidad de bits del dato
			ADDR_W: natural := 12; 		-- cantidad de bits de las direcciones de la LUT
			modulo: natural := 32767;	-- cantidad de puntos
			PASO_W: natural	:= 5		-- cantidad de bits del paso
		);
		port(
			clk: in std_logic;
			rst: in std_logic;
			paso: in unsigned(PASO_W-1 downto 0); -- valor de entrada (paso)
			salida_cos: out unsigned(DATA_W-2 downto 0);
			salida_sen: out unsigned(DATA_W-2 downto 0)
		);
	end component;

	component FIR_Filter_01 is

		Port
		( 
			clock_input   : in  STD_LOGIC; -- Clock input
			reset_input   : in  STD_LOGIC; -- Reset input
			x_input       : in  unsigned (9 downto 0); -- Filter input
			y_output      : out unsigned (20 downto 0); -- Filter output
	
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

	signal coeff_0_TB : signed(7 downto 0) := to_signed(0, 8);
	signal coeff_1_TB : signed(7 downto 0) := to_signed(2, 8);
	signal coeff_2_TB : signed(7 downto 0) := to_signed(10, 8);
	signal coeff_3_TB : signed(7 downto 0) := to_signed(23, 8);
	signal coeff_4_TB : signed(7 downto 0) := to_signed(30, 8);
	signal coeff_5_TB : signed(7 downto 0) := to_signed(23, 8);
	signal coeff_6_TB : signed(7 downto 0) := to_signed(10, 8);
	signal coeff_7_TB : signed(7 downto 0) := to_signed(2, 8);
	signal coeff_8_TB : signed(7 downto 0) := to_signed(0, 8);

	signal clock_TB : std_logic := '0';
	signal reset_TB : std_logic := '1';

	signal paso1_TB : unsigned(4 downto 0) := "00100";
	signal paso2_TB : unsigned(4 downto 0) := "11011";
	signal paso3_TB : unsigned(4 downto 0) := "11100";
	signal paso4_TB : unsigned(4 downto 0) := "11101";
	signal paso5_TB : unsigned(4 downto 0) := "11110";
	signal paso6_TB : unsigned(4 downto 0) := "11111";

	signal salida1_cos_TB : unsigned(9 downto 0);
	signal salida2_cos_TB : unsigned(9 downto 0);
	signal salida3_cos_TB : unsigned(9 downto 0);
	signal salida4_cos_TB : unsigned(9 downto 0);
	signal salida5_cos_TB : unsigned(9 downto 0);
	signal salida6_cos_TB : unsigned(9 downto 0);

	signal salida1_sen_TB : unsigned(9 downto 0);
	signal salida2_sen_TB : unsigned(9 downto 0);
	signal salida3_sen_TB : unsigned(9 downto 0);
	signal salida4_sen_TB : unsigned(9 downto 0);
	signal salida5_sen_TB : unsigned(9 downto 0);
	signal salida6_sen_TB : unsigned(9 downto 0);

	signal salida_suma_TB : unsigned(9 downto 0);

	signal entrada_filtro_TB : unsigned(9 downto 0);
	signal salida_filtro_TB  : unsigned(20 downto 0);

begin
	
	reset_TB <= '0' after 100 ns;
	
	clock_process : process
	begin
		wait for 10 ns; -- 1MHz de clock
		clock_TB <= not clock_TB;
	end process clock_process;

	FILTER: FIR_Filter_01
		port map
		(
			clock_input => clock_TB,
			reset_input => reset_TB,
			x_input => entrada_filtro_TB,
			y_output => salida_filtro_TB,
			coeff_0 => coeff_0_TB,
			coeff_1 => coeff_1_TB,
			coeff_2 => coeff_2_TB,
			coeff_3 => coeff_3_TB,
			coeff_4 => coeff_4_TB,
			coeff_5 => coeff_5_TB,
			coeff_6 => coeff_6_TB,
			coeff_7 => coeff_7_TB,
			coeff_8 => coeff_8_TB
		);

	OSC1 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 12,
			modulo => 32767,
			PASO_W => 5
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso1_TB,
			salida_cos => salida1_cos_TB,
			salida_sen => salida1_sen_TB
		);

	OSC2 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 12,
			modulo => 32767,
			PASO_W => 5
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso2_TB,
			salida_cos => salida2_cos_TB,
			salida_sen => salida2_sen_TB
		);

	OSC3 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 12,
			modulo => 32767,
			PASO_W => 5
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso3_TB,
			salida_cos => salida3_cos_TB,
			salida_sen => salida3_sen_TB
		);

	OSC4 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 12,
			modulo => 32767,
			PASO_W => 5
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso4_TB,
			salida_cos => salida4_cos_TB,
			salida_sen => salida4_sen_TB
		);

	OSC5 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 12,
			modulo => 32767,
			PASO_W => 5
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso5_TB,
			salida_cos => salida5_cos_TB,
			salida_sen => salida5_sen_TB
		);

	OSC6 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 12,
			modulo => 32767,
			PASO_W => 5
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso6_TB,
			salida_cos => salida6_cos_TB,
			salida_sen => salida6_sen_TB
		);

	salida_suma_TB <= unsigned(resize(unsigned(salida1_cos_TB)/6 + unsigned(salida2_cos_TB)/6 + unsigned(salida3_cos_TB)/6 + unsigned(salida4_cos_TB)/6 + unsigned(salida5_cos_TB)/6 + unsigned(salida6_cos_TB)/6, salida_suma_TB'length));
	entrada_filtro_TB <= salida_suma_TB;

	end;