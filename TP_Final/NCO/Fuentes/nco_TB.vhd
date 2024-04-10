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

	constant PASO_W: natural := 4; -- cantidad de bits del paso
	constant DATA_W: natural := 11; -- cantidad de bits del dato

	component nco is
		generic(
			DATA_W: natural := DATA_W; 		-- cantidad de bits del dato
			ADDR_W: natural := 12; 		-- cantidad de bits de las direcciones de la LUT
			modulo: natural := 32767;	-- cantidad de puntos
			PASO_W: natural	:= PASO_W		-- cantidad de bits del paso
		);
		port(
			clk: in std_logic;
			rst: in std_logic;
			paso: in unsigned(PASO_W-1 downto 0); -- valor de entrada (paso)
			salida_cos: out unsigned(DATA_W-2 downto 0);
			salida_sen: out unsigned(DATA_W-2 downto 0)
		);
	end component;

	signal clock_tb: std_logic := '0';
	signal reset_tb: std_logic := '0';
	signal paso_tb: unsigned(PASO_W-1 downto 0) := (others => '0');
	signal salida_cos_tb: unsigned(DATA_W-2 downto 0) := (others => '0');
	signal salida_sen_tb: unsigned(DATA_W-2 downto 0) := (others => '0');
	
begin
	
	-- Instanciacion del NCO
	uut: nco
		generic map(
			DATA_W => 11,
			ADDR_W => 12,
			modulo => 32767,
			PASO_W => 4
		)
		port map(
			clk => clock_tb,
			rst => reset_tb,
			paso => paso_tb,
			salida_cos => salida_cos_tb,
			salida_sen => salida_sen_tb
		);
		
	-- Proceso de clock
	process
	begin
		clock_tb <= '0';
		wait for 10 ns;
		clock_tb <= '1';
		wait for 10 ns;
	end process;
	
	-- Proceso de reset
	process
	begin
		reset_tb <= '1';
		wait for 100 ns;
		reset_tb <= '0';
		wait;
	end process;
	
	-- Proceso de paso
	process
	begin
		paso_tb <= "0000";
		wait for 100 ns;
		paso_tb <= "0001";
		wait for 100 ns;
		paso_tb <= "0010";
		wait for 100 ns;
		paso_tb <= "0011";
		wait for 100 ns;
		paso_tb <= "0100";
		wait for 100 ns;
		paso_tb <= "0101";
		wait for 100 ns;
		paso_tb <= "0110";
		wait for 100 ns;
		paso_tb <= "0111";
		wait for 100 ns;
		paso_tb <= "1000";
		wait for 100 ns;
		paso_tb <= "1001";
		wait for 100 ns;
		paso_tb <= "1010";
		wait for 100 ns;
		paso_tb <= "1011";
		wait for 100 ns;
		paso_tb <= "1100";
		wait for 100 ns;
		paso_tb <= "1101";
		wait for 100 ns;
		paso_tb <= "1110";
		wait for 100 ns;
		paso_tb <= "1111";
		wait for 100 ns;
		paso_tb <= "0000";
		wait;
	end process;
	
end;