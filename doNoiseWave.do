vdel -all
vlib work
vmap work work
vlog -reportprogress 300 -work work noiseWave.v squareWave.v
vsim -voptargs="+acc" testNoiseWave
add wave -position insertpoint \
sim:/testNoiseWave/clk \
sim:/testNoiseWave/q \
sim:/testNoiseWave/outG \
sim:/testNoiseWave/outA \
sim:/testNoiseWave/outB \
sim:/testNoiseWave/outC 
run 5000000
wave zoom full