--library declarations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
-- use std.env.stop;
 
--entity for testbenches are always empty
entity Signal_Generator_TB is
end Signal_Generator_TB;
 
architecture behavior of Signal_Generator_TB is 
 
--declare the component which we are going to test. Here that is "sine_wave"
component sine_wave is
generic(NUM_POINTS : integer := 32;
        MAX_AMPLITUDE : integer := 255
       );
port(clk :in  std_logic;
    dataout : out integer range 0 to MAX_AMPLITUDE
    );
end component;
    
--generic constants
constant NUM_POINTS : integer := 32;
constant MAX_AMPLITUDE : integer := 255;
    
--Inputs
signal clk : std_logic := '0';
--Outputs
signal dataout : integer range 0 to MAX_AMPLITUDE;
-- Clock period definitions
constant clk_period : time := 10 ns; 
--temporary signals
signal data_out_unsigned : unsigned(31 downto 0);
    
begin
 
-- Instantiate the Unit Under Test (UUT)
uut: sine_wave generic map(NUM_POINTS, MAX_AMPLITUDE)
	port map(clk => clk,
            dataout => dataout
            );

data_out_unsigned <= to_unsigned(dataout, 32);
	
-- Clock process definitions
clk_generate_process :process
begin
    wait for clk_period/2;
    clk <= not clk;
end process;
 
-- Stimulus process
stim_proc: process
begin		
    wait for clk_period*NUM_POINTS*2;
end process;

end;