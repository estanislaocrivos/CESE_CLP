library IEEE;
use IEEE.std_logic_1164.all;

entity Sumador_4B is
    port
    (
		m_input: in std_logic; -- Control signal: 1 is adder, 0 is substracter
        a_input: in std_logic_vector(3 downto 0); -- First bit	
        b_input: in std_logic_vector(3 downto 0); -- Second bit
		ci_input: in std_logic; -- Carry input
		co_output: out std_logic; -- Carry output
		s_output: out std_logic_vector(3 downto 0) -- Result
    );
end;

architecture Sumador_4B_Architecture of Sumador_4B is
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
	
	signal auxiliar: std_logic_vector(4 downto 0);
	signal b_input_auxiliar: std_logic_vector(4 downto 0);

begin
    -- Parte descriptiva
	
	auxiliar(0) <= ci_input;
	co_output <= auxiliar(4);
	b_input_auxiliar(0) <= b_input(0) xor m_input;
	b_input_auxiliar(1) <= b_input(1) xor m_input;
	b_input_auxiliar(2) <= b_input(2) xor m_input;
	b_input_auxiliar(3) <= b_input(3) xor m_input;
	
	Sum_1B_0: Sumador_1B
        port map
    	(
            a_input  	=> a_input(0), 
            b_input 	=> b_input_auxiliar(0),
			ci_input 	=> m_input,
			s_output 	=> s_output(0),
			co_output 	=> auxiliar(1)
        );
		
	Sum_1B_1: Sumador_1B
        port map
    	(
            a_input  	=> a_input(1), 
            b_input 	=> b_input_auxiliar(1),
			ci_input 	=> auxiliar(1),
			s_output 	=> s_output(1),
			co_output 	=> auxiliar(2)
        );
		
	Sum_1B_2: Sumador_1B
        port map
    	(
            a_input  	=> a_input(2), 
            b_input 	=> b_input_auxiliar(2),
			ci_input 	=> auxiliar(2),
			s_output 	=> s_output(2),
			co_output 	=> auxiliar(3)
        );
		
	Sum_1B_3: Sumador_1B
        port map
    	(
            a_input  	=> a_input(3), 
            b_input 	=> b_input_auxiliar(3),
			ci_input 	=> auxiliar(3),
			s_output 	=> s_output(3),
			co_output 	=> auxiliar(4)
        );

end;
