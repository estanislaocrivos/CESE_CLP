library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Contador de N Bits Estructural utilizando Flip Flops D

entity Contador_NB is

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
end;

architecture Contador_NB_Architecture of Contador_NB is

	signal counter_value : unsigned(N-1 downto 0) := (others => '0');
	
begin

	process(clock, reset) begin
		if reset = '1' then
		
			counter_value <= (others => '0');
			
		elsif rising_edge(clock) then
		
			if enable = '1' then
			
				counter_value <= counter_value + 1;
				
			end if;
			
		end if;
		
	end process;

	counter <= std_logic_vector(counter_value);
		
end;
