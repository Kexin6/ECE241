 # set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in lab2_part2.v to working dir
# could also have multiple verilog files
vlog lab5_part3.v

#load simulation
vsim morseCoder

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 0
run 40ns

#case 1

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 0
force {clock} 0

force {choice[0]} 0
force {choice[1]} 0
force {choice[2]} 0

run 10ns

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 0
force {clock} 1

force {choice[0]} 0
force {choice[1]} 0
force {choice[2]} 0

run 3006ms
force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 0

force {choice[0]} 0
force {choice[1]} 0
force {choice[2]} 1
run 10ns

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 1

force {choice[0]} 0
force {choice[1]} 0
force {choice[2]} 1
run 1503ms

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 0

force {choice[0]} 0
force {choice[1]} 1
force {choice[2]} 0

run 10ns

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 1

force {choice[0]} 0
force {choice[1]} 1
force {choice[2]} 0

run 3507ms

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 0

force {choice[0]} 0
force {choice[1]} 1
force {choice[2]} 1

run 10ns
force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 1

force {choice[0]} 0
force {choice[1]} 1
force {choice[2]} 1

run 4509ms

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 0

force {choice[0]} 1
force {choice[1]} 0
force {choice[2]} 0

run 10ns

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 1

force {choice[0]} 1
force {choice[1]} 0
force {choice[2]} 0

run 4509s

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 0

force {choice[0]} 1
force {choice[1]} 0
force {choice[2]} 1

run 10ns

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 1

force {choice[0]} 1
force {choice[1]} 0
force {choice[2]} 1

run 5511ms

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 0

force {choice[0]} 1
force {choice[1]} 1
force {choice[2]} 0

run 10ns

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 1

force {choice[0]} 1
force {choice[1]} 1
force {choice[2]} 0

run 6513ms

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 0

force {choice[0]} 1
force {choice[1]} 1
force {choice[2]} 1

run 10ns

force {clock_50} 0 0ns , 1 {5ns} -r 20ns
force {resetn} 1
force {clock} 1

force {choice[0]} 1
force {choice[1]} 1
force {choice[2]} 1

run 6012ms

