# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab2_part2.v

#load simulation using lab2_part2 as the top level simulation module
vsim lab2_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 0
#run simulation for a few ns
run 30ns

#second test case, change input values and run for another 10ns
# SW[0] should control LED[0]
force {SW[0]} 0
force {SW[1]} 1
force {SW[9]} 0
run 30ns

# ...
# SW[0] should control LED[0]
force {SW[0]} 1
force {SW[1]} 0
force {SW[9]} 0
run 30ns

# SW[0] should control LED[0]
force {SW[0]} 1
force {SW[1]} 1
force {SW[9]} 0
run 30ns

# SW[1] should control LED[0]
force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 1
run 30ns

# SW[1] should control LED[0]
force {SW[0]} 0
force {SW[1]} 1
force {SW[9]} 1
run 30ns

# SW[1] should control LED[0]
force {SW[0]} 1
force {SW[1]} 0
force {SW[9]} 1
run 30ns

# SW[1] should control LED[0]
force {SW[0]} 1
force {SW[1]} 1
force {SW[9]} 1
run 30ns

