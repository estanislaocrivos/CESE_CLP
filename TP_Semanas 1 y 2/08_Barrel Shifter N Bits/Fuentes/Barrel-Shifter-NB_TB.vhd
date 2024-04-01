library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real."log2";

-- N Bits Barrel Shifter

entity Barrel_Shifter_NB_TB is

end;

architecture Barrel_Shifter_NB_TB_Architecture of Barrel_Shifter_NB_TB is
	-- Parte declarativa
	
	component Barrel_Shifter_NB is
		generic 
		(
			N : integer := 8 
		);
		
		port
		(
			shift       : in  std_logic_vector(integer(log2(real(N)))-1 downto 0);
			word_input  : in  std_logic_vector(N-1 downto 0);
			word_output : out std_logic_vector(N-1 downto 0)
		);
	end component;
	
    signal word_input_tb   : std_logic_vector(7 downto 0) := "10111001"; 
	signal word_output_tb  : std_logic_vector(7 downto 0);
    signal shift_tb        : std_logic_vector(2 downto 0) := "000";
	
	-- With this values output should be 10011011

begin
	-- Parte descriptiva
	
    DUT: Barrel_Shifter_NB
		port map
		(
			shift => shift_tb,
			word_input => word_input_tb,
			word_output => word_output_tb
		);
	
end;
