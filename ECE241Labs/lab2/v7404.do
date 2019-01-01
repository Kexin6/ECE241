# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab2_part2.v

#load simulation using v7404
vsim v7404

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets


#second test case, change input values and run for another 30ns
force {pin1} 1
force {pin3} 1
force {pin5} 1
force {pin9} 1
force {pin11} 1
force {pin13} 1
run 30ns

force {pin1} 0
force {pin3} 0
force {pin5} 0
force {pin9} 0
force {pin11} 0
force {pin13} 0
run 30ns

