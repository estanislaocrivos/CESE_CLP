library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.sine_package.all;

entity sine_wave_multifreq_tb is
end;

architecture bench of sine_wave_multifreq_tb is

  component sine_wave
    port( clock, reset, enable: in std_logic;
          wave_out: out sine_vector_type);
  end component;

  signal clock1, clock2, clock3, reset, enable: std_logic;
  signal wave_out1, wave_out2, wave_out3: sine_vector_type;

  constant clock_period1: time := 10 ns;  -- Frecuencia para la primera sinusoidal
  constant clock_period2: time := 20 ns;  -- Frecuencia para la segunda sinusoidal
  constant clock_period3: time := 30 ns;  -- Frecuencia para la tercera sinusoidal
  signal stop_the_clock: boolean;

begin

  uut1: sine_wave port map ( clock1, reset, enable, wave_out1 );
  uut2: sine_wave port map ( clock2, reset, enable, wave_out2 );
  uut3: sine_wave port map ( clock3, reset, enable, wave_out3 );

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
    wait for 1 ms;

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock1 <= '1', '0' after clock_period1 / 2;
      clock2 <= '1', '0' after clock_period2 / 2;
      clock3 <= '1', '0' after clock_period3 / 2;
      wait for clock_period1;
    end loop;
    wait;
  end process;

end;
