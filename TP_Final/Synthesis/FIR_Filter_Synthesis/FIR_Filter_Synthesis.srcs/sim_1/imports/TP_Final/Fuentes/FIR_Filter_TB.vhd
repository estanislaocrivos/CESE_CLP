library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

-- Test Bench para el filtro FIR implementado en VHDL 
-- Autor: Estanislao Crivos
-- Fecha: Abril 2024
-- Trabajo Final - Circuitos Lógicos Programables - CESE CO20 - FI UBA

entity FIR_Filter_TB is

end;

architecture FIR_Filter_TB_Architecture of FIR_Filter_TB is

	-- Call NCO component
	component nco is
		generic(
			DATA_W: natural := 11; 		-- cantidad de bits del dato
			ADDR_W: natural := 9; 		-- cantidad de bits de las direcciones de la LUT
			modulo: natural := 32767;	-- cantidad de puntos
			PASO_W: natural	:= 11		-- cantidad de bits del paso
		);
		port(
			clk: in std_logic;
			rst: in std_logic;
			paso: in unsigned(PASO_W-1 downto 0); -- valor de entrada (paso)
			salida_cos: out unsigned(DATA_W-2 downto 0);
			salida_sen: out unsigned(DATA_W-2 downto 0)
		);
	end component;

	-- Call FIR_Filter component
	component FIR_Filter is
		Port (
			clk : in STD_LOGIC;
			reset : in STD_LOGIC;
			input_data : in UNSIGNED(9 downto 0);
			output_data : out UNSIGNED(31 downto 0)
		);
	end component;

	-- Declare Test Bench signals
	signal clock_TB : std_logic := '0';
	signal reset_TB : std_logic := '1';
	signal paso1_TB : unsigned(7 downto 0) := "00011001";
	signal paso2_TB : unsigned(7 downto 0) := "10110011";
	signal paso3_TB : unsigned(7 downto 0) := "10110100";
	signal paso4_TB : unsigned(7 downto 0) := "10110101";
	signal paso5_TB : unsigned(7 downto 0) := "10110110";
	signal paso6_TB : unsigned(7 downto 0) := "10111000";
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
	signal filter_input_TB : unsigned(9 downto 0);
	signal filter_output_TB : unsigned(31 downto 0) := (others => '0');

begin
	
	reset_TB <= '0' after 1 us;
	
	-- Clocking process (1MHz clock)
	clock_process : process
	begin
		wait for 0.5 us;
		clock_TB <= not clock_TB;
	end process clock_process;

	-- Instatiate filter
	FILTER: FIR_Filter
		port map
		(
			clk => clock_TB,
			reset => reset_TB,
			input_data => filter_input_TB,
			output_data => filter_output_TB
		);

	-- Instantiate first oscillator
	OSC1 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 9,
			modulo => 32767,
			PASO_W => 8
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso1_TB,
			salida_cos => salida1_cos_TB,
			salida_sen => salida1_sen_TB
		);

	-- Instantiate second oscillator
	OSC2 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 9,
			modulo => 32767,
			PASO_W => 8
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso2_TB,
			salida_cos => salida2_cos_TB,
			salida_sen => salida2_sen_TB
		);
		
	-- Instantiate third oscillator
	OSC3 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 9,
			modulo => 32767,
			PASO_W => 8
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso3_TB,
			salida_cos => salida3_cos_TB,
			salida_sen => salida3_sen_TB
		);

	-- Instantiate fourth oscillator
	OSC4 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 9,
			modulo => 32767,
			PASO_W => 8
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso4_TB,
			salida_cos => salida4_cos_TB,
			salida_sen => salida4_sen_TB
		);

	-- Instantiate fifth oscillator
	OSC5 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 9,
			modulo => 32767,
			PASO_W => 8
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso5_TB,
			salida_cos => salida5_cos_TB,
			salida_sen => salida5_sen_TB
		);

	-- Instantiate sixth oscillator
	OSC6 : nco
		generic map
		(
			DATA_W => 11,
			ADDR_W => 9,
			modulo => 32767,
			PASO_W => 8
		)
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso6_TB,
			salida_cos => salida6_cos_TB,
			salida_sen => salida6_sen_TB
		);

	-- Output signal (filter's input) is the sum of the six generated signals
	filter_input_TB <= unsigned(resize(unsigned(salida1_cos_TB)/6 + unsigned(salida2_cos_TB)/6 + unsigned(salida3_cos_TB)/6 + unsigned(salida4_cos_TB)/6 + unsigned(salida5_cos_TB)/6 + unsigned(salida6_cos_TB)/6, filter_input_TB'length));
	
end;