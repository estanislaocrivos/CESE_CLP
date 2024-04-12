------------------------------------------------------------------------------
----                                                                      ----
----  NCO (Numerically Controlled Oscilator)                              ----
----                                                                      ----                                                                        ----
------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;   -- se usa para instanciar la ROM

entity nco_VIO_ILA is
	port(
		clk: in std_logic
	);
end;

architecture p of nco_VIO_ILA is
	
	component nco is
		generic(
			DATA_W: natural := 11; 		-- cantidad de bits del dato
			ADDR_W: natural := 12; 		-- cantidad de bits de las direcciones de la LUT
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
	
	COMPONENT vio_0
	  PORT (
	    clk : IN STD_LOGIC;
	    probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
	    probe_out1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	  );
	END COMPONENT;
	
	COMPONENT ila_0
	PORT (
		clk : IN STD_LOGIC;
		probe0 : IN STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
	END COMPONENT;
	
	signal probe_rst: std_logic_vector(0 downto 0);
	signal probe_paso: std_logic_vector(3 downto 0);
	signal probe_senal: std_logic_vector(9 downto 0);
	
begin

	nco_inst: nco
		generic map(
			DATA_W => 11, 		-- cantidad de bits del dato
			ADDR_W => 10, 		-- cantidad de bits de las direcciones de la LUT
			modulo => 1023,	-- cantidad de puntos
			PASO_W => 4		-- cantidad de bits del paso
		)
		port map(
			clk 		=> clk,
			rst 		=> probe_rst(0),
			paso 		=> unsigned(probe_paso),
			salida_cos 	=> open,
			std_logic_vector(salida_sen)	=> probe_senal
		);
		
	vio_inst : vio_0
		  PORT MAP (
		    clk => clk,
		    probe_out0 => probe_rst,
		    probe_out1 => probe_paso
		  );
		  
	ila_inst : ila_0
		  PORT MAP (
		  	clk => clk,
		  	probe0 => probe_senal
		  );
		  
end;