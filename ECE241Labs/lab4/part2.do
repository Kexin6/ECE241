# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog lab4_part2.v

#load simulation using mux as the top level simulation module
vsim lab4_part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {KEY[0]} 0
force {SW[9]} 0
run 2ns

force {KEY[0]} 1
force {SW[9]} 0
run 2ns

force {SW[9]} 1 
run 1ns

force {KEY[0]} 0 
run 1ns
# reset over

#repeat Case 0 // addition
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

#repeat Case 0 // addition
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

#repeat Case 1 // addition
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

#repeat Case 1 // addition
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

#repeat Case 2 // NAND case NOR
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

#repeat Case 2 // NAND case NOR
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

# test RESET
force {KEY[0]} 0
force {SW[9]} 1
run 2ns

force {KEY[0]} 1
force {SW[9]} 1
run 2ns

force {SW[9]} 0
run 1ns

force {KEY[0]} 0 
run 1ns
# reset over

#repeat Case 3 // 
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 1
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

#repeat Case 3 // 
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0

force {KEY[3]} 0
force {KEY[2]} 1
force {KEY[1]} 1
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

#repeat Case 4 // 
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

# test RESET
force {KEY[0]} 0
force {SW[9]} 0
run 2ns

force {KEY[0]} 1
force {SW[9]} 0
run 2ns

force {SW[9]} 1
run 1ns

force {KEY[0]} 0 
run 1ns
# reset over

# test purpose for case 4 (add 3 bits 1 to the register)
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

# test purpose for case 4
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

# repeat case 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 1
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

# repeat case 6
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns

# repeat case 7
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1

force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 1
run 8ns
force {KEY[0]} 1
run 1ns
force {KEY[0]} 0
run 1ns