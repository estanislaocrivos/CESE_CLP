library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Contador_NB_TB is

end;

architecture Contador_NB_TB_Architecture of Contador_NB_TB is

	component Contador_NB is

		generic 
		(
			N : integer := 4  -- Ancho del contador en bits
		);
		
		port
		(
			enable  : in  std_logic;
			reset   : in std_logic;
			clock   : in  std_logic;
			counter : out std_logic_vector(N-1 downto 0)
		);
		
	end component;

	signal clock_tb : std_logic := '0';
	signal enable_tb : std_logic := '0';
	signal reset_tb : std_logic := '1';
	signal output_tb : std_logic_vector(3 downto 0);
	
begin

	clock_tb <= not clock_tb after 10 ns;
	enable_tb <= '1' after 5 ns;
	reset_tb <= '0' after 10 ns;

	DUT: Contador_NB
		port map
		(
			enable => enable_tb,
			reset => reset_tb,
			clock => clock_tb,
			counter => output_tb
		);
		
end;
