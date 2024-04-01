library IEEE;
use IEEE.std_logic_1164.all;

entity Sumador_Restador_4B_TB is

end;

architecture Sumador_Restador_4B_TB_Architecture of Sumador_Restador_4B_TB is
    -- Parte declarativa

    component Sumador_4B is
	    port
		(
			m_input: in std_logic; -- Control line
			a_input: in std_logic_vector(3 downto 0); -- First word	
			b_input: in std_logic_vector(3 downto 0); -- Second word
			ci_input: in std_logic; -- Carry input
			co_output: out std_logic; -- Carry output
			s_output: out std_logic_vector(3 downto 0) -- Result
		);
    end component;
	
	signal m_tb: std_logic;
	signal a_tb: std_logic_vector(3 downto 0);
    signal b_tb: std_logic_vector(3 downto 0);
	signal ci_tb: std_logic;
	signal co_tb: std_logic;
	signal s_tb: std_logic_vector(3 downto 0);
	
begin
	
	-- Parte descriptiva
	
	m_tb	<= '0'; -- 1 is substracter, 0 is adder
	a_tb 	<= "0011" after 10 ns;
	b_tb 	<= "0001" after 10 ns;
	ci_tb 	<= '0' after 10 ns;

    DUT: Sumador_4B
        port map
    	(
            m_input		=> m_tb,
			a_input  	=> a_tb, 
            b_input 	=> b_tb,
			ci_input 	=> ci_tb,
			co_output 	=> co_tb,
			s_output 	=> s_tb
        );
end;
