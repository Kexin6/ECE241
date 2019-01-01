# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab6_part2.v

#load simulation using mux as the top level simulation module
vsim lab6_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

########################### FIRST TEST ############################
# reset start
force {CLOCK_50} 0 0ps , 1 {5ns} -r 10ns
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[0]} 0
force {KEY[1]} 0
run 20ns

force {KEY[0]} 0
force {KEY[1]} 0
run 20ns

force {KEY[0]} 1
force {KEY[1]} 1
run 20ns
# reset over

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set A to 5

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set B to 4

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set C to 3

force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set X to 2

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 100ns
# start computation

########################### SECOND TEST ############################
# reset start
force {CLOCK_50} 0 0ps , 1 {5ns} -r 10ns
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[0]} 0
force {KEY[1]} 0
run 20ns

force {KEY[0]} 0
force {KEY[1]} 0
run 20ns

force {KEY[0]} 1
force {KEY[1]} 1
run 20ns
# reset over

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set A to 7

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set B to 4

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set C to 15

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set X to 4

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 100ns
# start computation

########################### THIRD TEST ############################
# reset start
force {CLOCK_50} 0 0ps , 1 {5ns} -r 10ns
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {KEY[0]} 0
force {KEY[1]} 0
run 20ns

force {KEY[0]} 0
force {KEY[1]} 0
run 20ns

force {KEY[0]} 1
force {KEY[1]} 1
run 20ns
# reset over

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set A to 11

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set B to 7

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set C to 12

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
run 20ns

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 20ns
# set X to 5

force {KEY[1]} 0
run 20ns

force {KEY[1]} 1
run 100ns
# start computation