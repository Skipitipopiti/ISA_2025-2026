vlog -sv -work ./work ../R4-MBE/verilog/ha.sv
vlog -sv -work ./work ../R4-MBE/verilog/fa.sv
vlog -sv -work ./work ../R4-MBE/verilog/wallace_tree.sv
vlog -sv -work ./work ../R4-MBE/verilog/booth_encoder.sv
vlog -sv -work ./work ../R4-MBE/verilog/r4mbe.sv

vlog -sv -work ./work ../tb/tb_r4mbe.sv

vsim -t ps work.tb_r4mbe -voptargs=+acc

add wave *
#add wave -position insertpoint /tb_r4mbe/uut/be_in
#add wave -position insertpoint /tb_r4mbe/uut/s_be
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p0
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p1
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p2
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p3
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p4
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/s_l0
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/c_l0
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/f_l0
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/s_l1
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/c_l1
#add wave -position insertpoint /tb_r4mbe/uut/wt_inst/f_l1

run 450 ns
