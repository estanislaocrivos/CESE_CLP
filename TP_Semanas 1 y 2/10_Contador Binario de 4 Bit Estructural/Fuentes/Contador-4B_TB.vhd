library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Contador de 4 Bits Estructural (TB)

entity Contador_4B_TB is

end;

architecture Contador_4B_TB_Architecture of Contador_4B_TB is
	-- Parte declarativa
	
	component Contador_4B is
		port
		(
			enable  : in  std_logic;
			reset   : in std_logic;
			clock   : in  std_logic;
			counter : out std_logic_vector(3 downto 0)
		);
	end component;
	
	signal clock_tb : std_logic := '0';
	signal reset_tb : std_logic := '1';
	signal enable_tb: std_logic := '0';
	signal output_tb: std_logic_vector(3 downto 0) := "0000";

begin
	-- Parte descriptiva
	
	reset_tb <= '0' after 40 ns;
	clock_tb <= not clock_tb after 10 ns;
	enable_tb <= '1' after 25 ns;
		
	DUT: Contador_4B
		port map
		(
			enable => enable_tb,
			reset => reset_tb,
			clock  => clock_tb,
			counter => output_tb
		);
	
end;
