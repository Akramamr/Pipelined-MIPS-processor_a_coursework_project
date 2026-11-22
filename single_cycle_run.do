vlog -f single_cycle_files.f
vsim -voptargs=+acc work.single_cycle_tb
add wave *
run -all