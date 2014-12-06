vdel -all
vlib work
vmap work work
vlog -reportprogress 300 -work work squareWave.v
vsim -voptargs="+acc" testFreqDiv
add wave -position insertpoint \
sim:/testFreqDiv/clk \
sim:/testFreqDiv/DUT/counter \
sim:/testFreqDiv/out 
run 100000
wave zoom full