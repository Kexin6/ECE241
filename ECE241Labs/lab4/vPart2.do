# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab4_part2.v

#load simulation
vsim lab4_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

#case 0
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 0

run 10ns

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0

run 10ns

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
force {SW[9]} 1

run 10ns

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
force {SW[9]} 0

run 10ns

#case 1
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 0


run 10ns

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0


run 10ns

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
force {SW[9]} 1


run 10ns

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
force {SW[9]} 0


run 10ns


#case 2
force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 0


run 10ns

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
force {SW[9]} 0


run 10ns

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 1


run 10ns

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
force {SW[9]} 0


run 10ns

#case 3
force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 0

run 10ns

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0

run 10ns

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 1

run 10ns

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0

run 10ns


#case 4
force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 0

run 10ns

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0

run 10ns

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 1

run 10ns

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0

run 10ns


#case 5
force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 0

run 10ns

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0

run 10ns

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 1

run 10ns

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0

run 10ns

#case 6
force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
force {SW[9]} 0


run 10ns

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0


run 10ns

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
force {SW[9]} 1


run 10ns

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
force {SW[9]} 0


run 10ns


#case 7
force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 0


run 10ns

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
force {SW[9]} 0


run 10ns

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0
force {SW[9]} 1


run 10ns

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
force {SW[9]} 0


run 10ns