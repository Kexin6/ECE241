# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab3_part2.v

#load simulation
vsim lab3_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

# SW[3] for b, SW[7] for a, SW[8] for cin
#second test case, change input values and run for another 10ns
force {SW[4]} 0
force {SW[0]} 0
force {SW[8]} 0


run 10ns

force {SW[4]} 0
force {SW[0]} 0
force {SW[8]} 1


run 10ns


force {SW[4]} 1
force {SW[0]} 0
force {SW[8]} 1


run 10ns

force {SW[4]} 1
force {SW[0]} 1
force {SW[8]} 1


run 10ns