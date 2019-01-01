vlib work
vlog lab6_part3.v
vsim lab6_part3
log {/*}

add wave -label "clock" {CLOCK_50}
add wave -label "syn_reset" {KEY[0]}
add wave -label "go" {KEY[1]}
add wave -label "Dividend" -hex {SW[7:4]}
add wave -label "Divisor" -hex {SW[3:0]}
add wave -label "Quotient" -hex {LEDR[3:0]}
add wave -label "Remainder" -hex {remainder}
add wave -label "current state" -decimal  -position end  sim:/lab6_part3/u0/c0/current_state
add wave -label "register a"  -position end  sim:/lab6_part3/u0/d0/a
add wave -label "register d"  -position end  sim:/lab6_part3/u0/d0/d


force {CLOCK_50} 0 0ns, 1 5ns -r 10ns
force {SW[3:0]} 'd3 5ns
force {SW[7:4]} 'd7 5ns

force {KEY[1]} 0 0ns, 1 10ns -r 20ns
force {KEY[0]} 1 0ns, 0 20ns

run 225ns

force {CLOCK_50} 0 0ns, 1 5ns -r 10ns
force {SW[3:0]} 'd4 5ns
force {SW[7:4]} 'd6 5ns

force {KEY[1]} 0 0ns, 1 10ns -r 20ns
force {KEY[0]} 1 0ns, 0 20ns

run 225ns