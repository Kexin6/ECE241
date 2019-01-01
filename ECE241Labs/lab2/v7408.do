# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab2_part2.v

#load simulation using v7408
vsim v7408

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {pin1} 0
force {pin2} 0
force {pin4} 0
force {pin5} 0
force {pin9} 0
force {pin10} 0
force {pin12} 0
force {pin13} 0
#run simulation for a few ns
run 30ns

#second test case, change input values and run for another 30ns
# SW[0] should control LED[0]
force {pin1} 0
force {pin2} 1
force {pin4} 0
force {pin5} 1
force {pin9} 0
force {pin10} 1
force {pin12} 0
force {pin13} 1
run 30ns

# ...
# SW[0] should control LED[0]
force {pin1} 1
force {pin2} 0
force {pin4} 1
force {pin5} 0
force {pin9} 1
force {pin10} 0
force {pin12} 1
force {pin13} 0
run 30ns

# SW[0] should control LED[0]
force {pin1} 1
force {pin2} 1
force {pin4} 1
force {pin5} 1
force {pin9} 1
force {pin10} 1
force {pin12} 1
force {pin13} 1
run 30ns