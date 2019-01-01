# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab5_part2.v

#load simulation
vsim counter

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets


force {clock} 0 0ns , 1 {10ns} -r 20ns

force {choice[1]} 0
force {choice[0]} 0
run 251ms

force {clock} 0 0ns , 1 {10ns} -r 20ns

force {choice[1]} 0
force {choice[0]} 1
run 251ms

force {clock} 0 0ns , 1 {10ns} -r 20ns

force {choice[1]} 1
force {choice[0]} 0
run 501ms

force {clock} 0 0ns , 1 {10ns} -r 20ns

force {choice[1]} 1
force {choice[0]} 1
run 1001ms


