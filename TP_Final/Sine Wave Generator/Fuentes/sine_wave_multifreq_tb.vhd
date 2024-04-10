library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.sine_package.all;

entity sine_wave_multifreq_tb is
end;

architecture bench of sine_wave_multifreq_tb is

  component sine_wave
    port( 
			clock, reset, enable: in std_logic;
			wave_out: out sine_vector_type
		);
  end component;

  signal clock, clock1, clock2, clock3, reset, enable: std_logic;
  signal wave_out1, wave_out2, wave_out3: sine_vector_type;
  signal wave_out_sum: std_logic_vector(9 downto 0);

  constant clock_period: time := 10 ns;  -- Frecuencia para la primera sinusoidal
  constant clock_period1: time := 10 ns;  -- Frecuencia para la primera sinusoidal
  constant clock_period2: time := 30 ns;  -- Frecuencia para la primera sinusoidal
  constant clock_period3: time := 60 ns;  -- Frecuencia para la primera sinusoidal

  signal stop_the_clock: boolean;

begin

  uut1: sine_wave port map ( clock1, reset, enable, wave_out1 );
  uut2: sine_wave port map ( clock2, reset, enable, wave_out2 );
  uut3: sine_wave port map ( clock3, reset, enable, wave_out3 );

  wave_out_sum <= std_logic_vector(resize(signed(wave_out1)/10 + signed(wave_out2)/10 + signed(wave_out3)/10, wave_out_sum'length));

  -- wave_out_sum <= std_logic_vector(resize(unsigned(wave_out1) + unsigned(wave_out2) + unsigned(wave_out3), wave_out_sum'length));
  -- wave_out_sum <= std_logic_vector(unsigned(wave_out1) + unsigned(wave_out2) + unsigned(wave_out3));

  stimulus: process
  begin
  
    -- Coloca aquí el código de inicialización

    enable <= '0';
    reset <= '1';
    wait for 5 ns;
    reset <= '0';

    wait for 100 ns;
    enable <= '1';

    -- Coloca aquí el código del banco de pruebas
    wait for 10 ms;

    stop_the_clock <= true;
    wait;
  end process;

  clocking_main: process
  begin
    while not stop_the_clock loop
      clock <= '1', '0' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

  clocking_1: process
  begin
    while not stop_the_clock loop
      clock1 <= '1', '0' after clock_period1 / 2;
      wait for clock_period1;
    end loop;
    wait;
  end process;

  clocking_2: process
  begin
    while not stop_the_clock loop
      clock2 <= '1', '0' after clock_period2 / 2;
      wait for clock_period2;
    end loop;
    wait;
  end process;

  clocking_3: process
  begin
    while not stop_the_clock loop
      clock3 <= '1', '0' after clock_period3 / 2;
      wait for clock_period3;
    end loop;
    wait;
  end process;

end;
