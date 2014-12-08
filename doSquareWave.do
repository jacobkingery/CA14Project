vdel -all
vlib work
vmap work work
vlog -reportprogress 300 -work work squareWave.v
vsim -voptargs="+acc" testSquareWave
add wave -position insertpoint \
sim:/testSquareWave/clk \
sim:/testSquareWave/outG \
sim:/testSquareWave/outA \
sim:/testSquareWave/outB \
sim:/testSquareWave/outC \
sim:/testSquareWave/outD 
run 5000000
wave zoom full