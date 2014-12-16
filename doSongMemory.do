vdel -all
vlib work
vmap work work
vlog -reportprogress 300 -work work songMemory.v
vsim -voptargs="+acc" testSongMemory
add wave -position insertpoint \
sim:/testSongMemory/clk \
sim:/testSongMemory/Addr \
sim:/testSongMemory/notes 
run 50000
wave zoom full