library IEEE;
use IEEE.std_logic_1164.all;

-- Registro de Desplazamiento de 4 Bits tipo SISO (Serial In Serial Out) (TB)

entity Shift_Register_4B_TB is
    
end;

architecture Shift_Register_4B_TB_Architecture of Shift_Register_4B_TB is
    -- Parte declarativa
	
	component Shift_Register_4B is
		port
		(
			data_input: in std_logic;
			clock_input: in std_logic;
			data_output: out std_logic
		);
	end component;
	
	signal clock_tb:    std_logic := '0';
	signal data_in_tb:  std_logic := '1';
	signal data_out_tb: std_logic := '0';
	
begin
	-- Parte descriptiva
	
	clock_tb   <= not clock_tb   after 10 ns;
	data_in_tb <= not data_in_tb after 20 ns;
	
	DUT: Shift_Register_4B
		port map
		(
			data_input  => data_in_tb, 
			clock_input => clock_tb,
			data_output => data_out_tb
		);
	
end;
