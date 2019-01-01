# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab3_part1.v

#load simulation using v7404
vsim lab3_part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets


#second test case, change input values and run for another 30ns
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1

run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {SW[9]} 1
force {SW[8]} 1
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0

run 10ns

force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1

run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

force {SW[9]} 1
force {SW[8]} 1
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

run 10ns

