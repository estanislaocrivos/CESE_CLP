library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real."log2";

-- N Bits Barrel Shifter

entity Barrel_Shifter_NB is

	generic 
	(
		N : integer := 8  -- Ancho de los datos de entrada en bits (N tiene que ser mult. de 2)
	);
	
    port
    (
		shift       : in  std_logic_vector(integer(log2(real(N)))-1 downto 0); -- Amount of bits to be shifted
		word_input  : in  std_logic_vector(N-1 downto 0); -- Input N bit word
		word_output : out std_logic_vector(N-1 downto 0)  -- Output N bit word
    );
end;

architecture Barrel_Shifter_NB_Architecture of Barrel_Shifter_NB is
	-- Parte declarativa

begin
	-- Parte descriptiva
	
    process(word_input, shift)
	
    begin
		
		-- First assign the part input(shift ... top) to output(0 ... N-1-shift)
		for i in 0 to N - 1 - to_integer(unsigned(shift)) loop
			word_output(i) <= word_input(to_integer(unsigned(shift)) + i);
		end loop;

		-- Then assign the part input(0 ... shift) to output(N-shift ... top)
		for i in N - to_integer(unsigned(shift)) to word_input'HIGH loop
			word_output(i) <= word_input(i - N + to_integer(unsigned(shift)));
		end loop;
		
    end process;
	
end;
