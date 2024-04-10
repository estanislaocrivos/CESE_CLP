proc r {} {source go.tcl}
proc q {} {quit -force}

vlib mylib
vmap work mylib

vcom sine_package.vhd

vcom sine_wave.vhd
vcom sine_wave_tb.vhd
vcom sine_wave_cf.vhd

vsim mylib.sine_wave_tb

view wave
wm geometry .wave 663x257+353+465
source wave.do

run -all

