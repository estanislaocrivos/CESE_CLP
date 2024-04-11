-- Test bench configuration created by tb_gen_vhdl.pl
-- Copyright Doulos Ltd
-- SD, 10 May 2002
configuration cfg_sine_wave_tb of sine_wave_multifreq_tb is
  for bench
    for uut1: sine_wave
      use entity work.sine_wave(arch1);
    end for;
    for uut2: sine_wave
      use entity work.sine_wave(arch2);
    end for;
    for uut3: sine_wave
      use entity work.sine_wave(arch3);
    end for;
  end for;
end cfg_sine_wave_tb;
