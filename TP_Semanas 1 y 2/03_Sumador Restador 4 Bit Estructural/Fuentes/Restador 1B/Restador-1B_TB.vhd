library IEEE;
use IEEE.std_logic_1164.all;

entity Restador_1B_TB is

end;

architecture Restador_1B_TB_Architecture of Restador_1B_TB is
    -- Parte declarativa

    component Restador_1B is
		port
		(
			a_input: in std_logic; -- First bit	
			b_input: in std_logic; -- Second bit
			bi_input: in std_logic; -- Borrow input
			bo_output: out std_logic; -- Borrow output
			s_output: out std_logic -- Result
		);
    end component;
	
	signal a_tb: std_logic 		:= '1';
    signal b_tb: std_logic 		:= '0';
	signal bi_tb: std_logic		:= '1';
	signal bo_tb: std_logic;
	signal s_tb: std_logic;
	
begin
	
	-- Parte descriptiva
	
	a_tb 	<= not a_tb after 10 ns;
	b_tb 	<= not b_tb after 20 ns;
	bi_tb 	<= not bi_tb after 40 ns;

    DUT: Restador_1B
        port map
    	(
            a_input  	=> a_tb, 
            b_input 	=> b_tb,
			bi_input 	=> bi_tb,
			bo_output 	=> bo_tb,
			s_output 	=> s_tb
        );
end;
