--library declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  --try to use this library as much as possible.

entity Signal_Generator is
generic(NUM_POINTS : integer := 32;
	MAX_AMPLITUDE : integer := 255
        );
port (clk :in  std_logic;
      dataout : out integer range 0 to MAX_AMPLITUDE
      );
end Signal_Generator;

architecture Behavioral of Signal_Generator is

signal i : integer range 0 to NUM_POINTS := 0;
type memory_type is array (0 to NUM_POINTS-1) of integer range 0 to MAX_AMPLITUDE;
--ROM for storing the sine values generated by MATLAB.
signal sine : memory_type :=
    (128,152,176,198,218,234,245,253,  --sine wave amplitudes in the 1st quarter.
    255,253,245,234,218,198,176,152,    --sine wave amplitudes in the 2nd quarter.
    128,103,79,57,37,21,10,2,    --sine wave amplitudes in the 3rd quarter.
    0,2,10,21,37,57,79,103);    --sine wave amplitudes in the 4th quarter.

begin

process(clk)
begin
--to check the rising edge of the clock signal
if(rising_edge(clk)) then    
--one by one output the sine amplitudes in each clock cycle.
dataout <= sine(i);
i <= i+ 1; --increment the index.
if(i = NUM_POINTS-1) then  
    --reset the index to zero, once we have output all values in ROM
    i <= 0;
end if;
end if;
end process;

end Behavioral;