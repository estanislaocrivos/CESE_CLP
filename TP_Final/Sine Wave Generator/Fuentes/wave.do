onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal /sine_wave_tb/uut/state
add wave -noupdate -color Red -format Analog-Interpolated -height 60 -itemcolor White -offset 150.0 -scale 0.20000000000000001 /sine_wave_tb/uut/wave_out
add wave -noupdate -color White -format Analog-Interpolated -height 30 -itemcolor White -offset 10.0 -scale 0.20000000000000001 /sine_wave_tb/uut/table_index
add wave -noupdate -format Logic /sine_wave_tb/uut/positive_cycle
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16630 ns} 0}
WaveRestoreZoom {10098 ns} {15498 ns}
configure wave -namecolwidth 123
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
