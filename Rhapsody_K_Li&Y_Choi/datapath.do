# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog final_project.v

#load simulation using mux as the top level simulation module
# vsim -L altera_mf_ver -L altera_mf work.fill
# vsim -L altera_mf_ver -L altera_mf work.ram32x4
# vsim work.part1 -L altera_mf
vsim datapath

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clk} 0 0ns , 1 {5ns} -r 10ns
force {resetn} 1
run 10ns

force {resetn} 0
run 10ns

force {resetn} 1
run 10ns
# reset over

# plot
#force {colour_in} 010
force {ld_plot} 1
force {is_black} 0
force {is_update} 0
force {colour_black} 0
run 10ns

# plot
#force {colour_in} 110
force {ld_plot} 1
force {is_black} 0
force {is_update} 0
force {colour_black} 0
run 10ns

# plot black
#force {colour_in} 010
force {ld_plot} 1
force {is_black} 1
force {is_update} 0
force {colour_black} 0
run 10ns
# plot black
#force {colour_in} 010
force {ld_plot} 1
force {is_black} 1
force {is_update} 0
force {colour_black} 0
run 10ns

# plot black
#force {colour_in} 010
force {ld_plot} 1
force {is_black} 0
force {is_update} 0
force {colour_black} 1
run 10ns

# plot black
#force {colour_in} 010
force {ld_plot} 1
force {is_black} 0
force {is_update} 0
force {colour_black} 1
run 10ns

# update
#force {colour_in} 010
force {ld_plot} 0
force {is_black} 0
force {is_update} 1
force {colour_black} 0
run 10ns

# update
#force {colour_in} 010
force {ld_plot} 0
force {is_black} 0
force {is_update} 1
force {colour_black} 0
run 10ns