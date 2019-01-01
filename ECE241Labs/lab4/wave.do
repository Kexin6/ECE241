onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand /lab4_part2/SW
add wave -noupdate -expand /lab4_part2/KEY
add wave -noupdate -expand /lab4_part2/LEDR
add wave -noupdate /lab4_part2/HEX0
add wave -noupdate /lab4_part2/HEX1
add wave -noupdate /lab4_part2/HEX2
add wave -noupdate /lab4_part2/HEX3
add wave -noupdate /lab4_part2/HEX4
add wave -noupdate /lab4_part2/HEX5
add wave -noupdate /lab4_part2/wrin
add wave -noupdate /lab4_part2/wrout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {330128 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {336 ns}
