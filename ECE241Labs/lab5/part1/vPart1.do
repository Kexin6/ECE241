# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab5_part1.v

#load simulation
vsim eight_bit_counter

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

#case 1
force {enable} 1
force {clock} 1
force {clear_b} 0

run 10ns


force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 1
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 1
force {clock} 0
force {clear_b} 1

run 1ns

force {enable} 0
force {clock} 1
force {clear_b} 1

run 10ns

force {enable} 0
force {clock} 1
force {clear_b} 1

run 10ns



