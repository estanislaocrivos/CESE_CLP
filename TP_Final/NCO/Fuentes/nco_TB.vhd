------------------------------------------------------------------------------
----                                                                      ----
----  NCO (Numerically Controlled Oscilator)                              ----
----                                                                      ----                                                                        ----
------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;   -- se usa para instanciar la ROM

entity nco_TB is

end;

architecture nco_TB_Architecture of nco_TB is

	component nco is
		generic(
			DATA_W: natural := 11; 		-- cantidad de bits del dato
			ADDR_W: natural := 4; 		-- cantidad de bits de las direcciones de la LUT
			modulo: natural := 32767;	-- cantidad de puntos
			PASO_W: natural	:= 4		-- cantidad de bits del paso
		);
		port(
			clk: in std_logic;
			rst: in std_logic;
			paso: in unsigned(PASO_W-1 downto 0); -- valor de entrada (paso)
			salida_cos: out unsigned(DATA_W-2 downto 0);
			salida_sen: out unsigned(DATA_W-2 downto 0)
		);
	end component;

	signal clock_TB : std_logic := '0';
	signal reset_TB : std_logic := '1';
	signal paso_TB : unsigned(3 downto 0) := "0001";
	signal salida_cos_TB : unsigned(9 downto 0);
	signal salida_sen_TB : unsigned(9 downto 0);

begin
	
	reset_TB <= '0' after 100 ns;
	
	clock_process : process
	begin
		wait for 500 ns; -- 1MHz de clock
		clock_TB <= not clock_TB;
	end process clock_process;

	DUT : nco
		port map 
		(
			clk => clock_TB,
			rst => reset_TB,
			paso => paso_TB,
			salida_cos => salida_cos_TB,
			salida_sen => salida_sen_TB
		);
	
end;