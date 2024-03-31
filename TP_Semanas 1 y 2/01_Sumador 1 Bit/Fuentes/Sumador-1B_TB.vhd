library IEEE;
use IEEE.std_logic_1164.all;

entity Sumador_1B_TB is

end;

architecture Sumador_1B_TB_Architecture of Sumador_1B_TB is
    -- Parte declarativa

    component Sumador_1B is
		port
		(
			a_input: in std_logic; -- First bit	
			b_input: in std_logic; -- Second bit
			ci_input: in std_logic; -- Carry input
			co_output: out std_logic; -- Carry output
			s_output: out std_logic -- Result
		);
    end component;
	
	signal a_tb: std_logic 		:= '1';
    signal b_tb: std_logic 		:= '0';
	signal ci_tb: std_logic		:= '1';
	signal co_tb: std_logic;
	signal s_tb: std_logic;
	
begin
	
	-- Parte descriptiva
	
	a_tb 	<= not a_tb after 10ns;
	b_tb 	<= not b_tb after 20ns;
	ci_tb 	<= not ci_tb after 40ns;

    DUT: Sumador_1B
        port map
    	(
            a_input  	=> a_tb, 
            b_input 	=> b_tb,
			ci_input 	=> ci_tb,
			co_output 	=> co_tb,
			s_output 	=> s_tb
        );
end;
