quit -sim -force
cls
if {[file exists work]} {
    vdel -lib work -all
}


vlib work
vlog -f pip_files.list


vsim -voptargs="+acc" work.pip_tb

do pip_wave.do
run -all
