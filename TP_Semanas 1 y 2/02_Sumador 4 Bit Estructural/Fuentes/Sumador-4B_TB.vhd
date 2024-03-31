library IEEE;
use IEEE.std_logic_1164.all;

entity Sumador_4B_TB is

end;

architecture Sumador_4B_TB_Architecture of Sumador_4B_TB is
    -- Parte declarativa

    component Sumador_4B is
	    port
		(
			a_input: in std_logic_vector(3 downto 0); -- First word	
			b_input: in std_logic_vector(3 downto 0); -- Second word
			ci_input: in std_logic; -- Carry input
			co_output: out std_logic; -- Carry output
			s_output: out std_logic_vector(3 downto 0) -- Result
		);
    end component;
	
	signal a_tb: std_logic_vector(3 downto 0);
    signal b_tb: std_logic_vector(3 downto 0);
	signal ci_tb: std_logic;
	signal co_tb: std_logic;
	signal s_tb: std_logic_vector(3 downto 0);
	
begin
	
	-- Parte descriptiva
	
	a_tb 	<= "0011" after 50 ns;
	b_tb 	<= "0001" after 100 ns;
	ci_tb 	<= '0' after 150 ns;

    DUT: Sumador_4B
        port map
    	(
            a_input  	=> a_tb, 
            b_input 	=> b_tb,
			ci_input 	=> ci_tb,
			co_output 	=> co_tb,
			s_output 	=> s_tb
        );
end;
