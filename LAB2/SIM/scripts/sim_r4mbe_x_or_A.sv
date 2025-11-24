vlog -sv -work ./work ../R4-MBE/verilog/ha.sv
vlog -sv -work ./work ../R4-MBE/verilog/fa.sv
vlog -sv -work ./work ../R4-MBE/verilog/wallace_tree.sv
vlog -sv -work ./work ../R4-MBE/verilog/booth_encoder.sv
vlog -sv -work ./work ../R4-MBE/verilog/r4mbe.sv

vlog -sv -work ./work ../tb/tb_r4mbe_x_or_A.sv

vsim -t ps work.tb_r4mbe_x_or_A -voptargs=+acc

add wave *

run 2 us
