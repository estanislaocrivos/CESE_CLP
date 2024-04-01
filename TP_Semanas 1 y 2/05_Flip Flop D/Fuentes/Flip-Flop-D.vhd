library IEEE;
use IEEE.std_logic_1164.all;

-- D Flip Flop

entity Flip_Flop_D is
    port
    (
        clk_input: 		in std_logic;
		en_input:  		in std_logic;
		rst_input: 		in std_logic;
        d_input: 		in std_logic; 		
		q_output: 		out std_logic
    );
end;

architecture Flip_Flop_D_Architecture of Flip_Flop_D is
    -- Parte declarativa	
	
begin
    -- Parte descriptiva
	
	process(clk_input) begin
	
		if rising_edge(clk_input) then
			
			if rst_input = '1' then
				
				q_output <= '0';
				
			elsif en_input = '1' then
			
				q_output <= d_input;
				
			end if;
			
		end if;
			
	end process;
	
end;
