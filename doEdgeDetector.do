vdel -all
vlib work
vmap work work
vlog -reportprogress 300 -work work edgeDetector.v
vsim -voptargs="+acc" testEdgeDetector
add wave -position insertpoint \
sim:/testEdgeDetector/clk \
sim:/testEdgeDetector/in \
sim:/testEdgeDetector/pos \
sim:/testEdgeDetector/neg 
run 500
wave zoom full