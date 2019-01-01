vlib work
vlog lab6_part1.v
vsim lab6_part1
log {/*}

add wave -label "clock" {KEY[0]}
add wave -label "resetn" {SW[0]}
add wave -label "current state" {LEDR[3:0]}
add wave -label "w" {SW[1]}
add wave -label "out" {LEDR[9]}

force {SW[0]} 0 0ns, 1 10ns
force {SW[1]} 0 0ns, 1 25ns, 0 65ns, 1 75ns, 0 85ns
force {KEY[0]} 0 0ns, 1 5ns -r 10ns

run 100ns