vlib work
vlog lab6_part2.v
vsim lab6_part2
log {/*}

add wave -label "clock" {CLOCK_50}
add wave -label "syn_resetn" {KEY[0]}
add wave -label "go" {KEY[1]}
add wave -label "data_in" -hex {SW[7:0]}
add wave -label "data result" -hex {LEDR}
add wave -label "current state" -decimal  -position end  sim:/lab6_part2/u0/C0/current_state

force {CLOCK_50} 0 0ns, 1 5ns -r 10ns
force {SW[7:0]} 'd5 5ns, 'd4 20ns, 'd3 60ns, 'd2 100ns
force {KEY[1]} 0 0ns, 1 20ns -r 40ns
force {KEY[0]} 0 0ns, 1 5ns

run 220ns