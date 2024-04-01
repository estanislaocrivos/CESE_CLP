library IEEE;
use IEEE.std_logic_1164.all;

-- Registro de Desplazamiento de 4 Bits tipo SISO (Serial In Serial Out)

entity Shift_Register_4B is
    port
    (
		clock_input:  in std_logic;
		data_input:   in std_logic;
		data_output:  out std_logic
    );
end;

architecture Shift_Register_4B_Architecture of Shift_Register_4B is
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
	
	signal auxiliary: std_logic_vector(2 downto 0) := "000";
	
begin
    -- Parte descriptiva

	Flip_Flop_0: Flip_Flop_D
        port map
    	(
            clk_input => clock_input, 
			en_input  => '1',
			rst_input => '0',
            d_input	  => data_input,
			q_output  => auxiliary(0)
        );
	
	Flip_Flop_1: Flip_Flop_D
		port map
		(
			clk_input => clock_input, 
			en_input  => '1',
			rst_input => '0',
			d_input	  => data_input,
			q_output  => auxiliary(1)
		);
		
	Flip_Flop_2: Flip_Flop_D
		port map
		(
			clk_input => clock_input, 
			en_input  => '1',
			rst_input => '0',
			d_input	  => data_input,
			q_output  => auxiliary(2)
		);

	Flip_Flop_3: Flip_Flop_D
		port map
		(
			clk_input => clock_input, 
			en_input  => '1',
			rst_input => '0',
			d_input	  => data_input,
			q_output  => data_output
		);
		
end;
