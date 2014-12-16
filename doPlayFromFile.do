vdel -all
vlib work
vmap work work
vlog -reportprogress 300 -work work playFromFile.v songMemory.v squareWave.v noiseWave.v edgeDetector.v keyboardBringup.v
vsim -voptargs="+acc" testPlayFromFile
add wave -position insertpoint \
sim:/testPlayFromFile/clk \
sim:/testPlayFromFile/outBank1 \
sim:/testPlayFromFile/outBank2 \
sim:/testPlayFromFile/outBank3 \
sim:/testPlayFromFile/pFF/Addr \
sim:/testPlayFromFile/pFF/notes 
run 5000000
wave zoom full