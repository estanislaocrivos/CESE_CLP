library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Contador de 4 Bits Estructural utilizando Flip Flops D

entity Contador_4B is
    port
    (
		enable  : in  std_logic;
		reset   : in std_logic;
		clock   : in  std_logic;
		counter : out std_logic_vector(3 downto 0)
    );
end;

architecture Contador_4B_Architecture of Contador_4B is
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
	
	signal d_auxiliary: std_logic_vector(3 downto 0);
	signal q_auxiliary: std_logic_vector(3 downto 0);
	signal interconnect_auxiliary: std_logic_vector(2 downto 0);

begin
	-- Parte descriptiva
		
	interconnect_auxiliary(0) <= enable and q_auxiliary(0);
	interconnect_auxiliary(1) <= interconnect_auxiliary(0) and q_auxiliary(1);
	interconnect_auxiliary(2) <= interconnect_auxiliary(1) and q_auxiliary(2);
	
	d_auxiliary(0) <= enable xor q_auxiliary(0);
	d_auxiliary(1) <= interconnect_auxiliary(0) xor q_auxiliary(1);
	d_auxiliary(2) <= interconnect_auxiliary(1) xor q_auxiliary(2);
	d_auxiliary(3) <= interconnect_auxiliary(2) xor q_auxiliary(3);
	
	counter(0) <= q_auxiliary(0);
	counter(1) <= q_auxiliary(1);
	counter(2) <= q_auxiliary(2);
	counter(3) <= q_auxiliary(3);
	
	Contador_1B_00: Flip_Flop_D
		port map
		(
			clk_input => clock,
			en_input  => enable,
			rst_input => reset,
			d_input => d_auxiliary(0), 		
			q_output => q_auxiliary(0)
		);
	
	Contador_1B_01: Flip_Flop_D
		port map
		(
			clk_input => clock,
			en_input  => enable,
			rst_input => reset,
			d_input => d_auxiliary(1), 		
			q_output => q_auxiliary(1)
		);
		
	Contador_1B_02: Flip_Flop_D
		port map
		(
			clk_input => clock,
			en_input  => enable,
			rst_input => reset,
			d_input => d_auxiliary(2), 		
			q_output => q_auxiliary(2)
		);
		
	Contador_1B_03: Flip_Flop_D
		port map
		(
			clk_input => clock,
			en_input  => enable,
			rst_input => reset,
			d_input => d_auxiliary(3), 		
			q_output => q_auxiliary(3)
		);
	
end;
