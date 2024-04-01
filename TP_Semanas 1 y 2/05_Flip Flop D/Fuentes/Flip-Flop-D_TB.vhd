library IEEE;
use IEEE.std_logic_1164.all;

-- D Flip Flop Test Bench

entity Flip_Flop_D_TB is

end;

architecture Flip_Flop_D_TB_Architecture of Flip_Flop_D_TB is
    -- Parte declarativa
	
	component Flip_Flop_D is
		port
		(
			clk_input: 		in std_logic;
			en_input:  		in std_logic;
			rst_input: 		in std_logic;
			d_input: 		in std_logic; 		
			q_output: 		out std_logic	
		);
	end component;
	
	signal clk_tb: std_logic := '0';
	signal rst_tb: std_logic := '1';
	signal en_tb:  std_logic := '0';
	signal d_tb:   std_logic := '0';
	signal q_tb:   std_logic := '0';

begin
    
	clk_tb <= not clk_tb after 10 ns;
	rst_tb <= '0' after 20 ns;
	en_tb <= '1' after 62 ns;
	d_tb <= '1' after 20 ns, '0' after 100 ns;
	
	DUT: Flip_Flop_D
		port map
		(
			clk_input 	=> clk_tb, 			
			en_input 	=> en_tb, 		
			rst_input 	=> rst_tb, 	
			d_input 	=> d_tb,
			q_output 	=> q_tb
		);
		
end;
