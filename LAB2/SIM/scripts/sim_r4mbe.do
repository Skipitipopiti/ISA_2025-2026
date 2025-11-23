vcom -work ./work ../R4-MBE/vhdl/ha.vhd
vcom -work ./work ../R4-MBE/vhdl/fa.vhd
vcom -work ./work ../R4-MBE/vhdl/wallace_tree.vhd
vcom -work ./work ../R4-MBE/vhdl/booth_encoder.vhd
vcom -work ./work ../R4-MBE/vhdl/r4mbe.vhd

vcom -work ./work ../tb/tb_r4mbe.vhd

vsim -t ps work.tb_r4mbe -voptargs=+acc

add wave *
add wave -position insertpoint /tb_r4mbe/uut/be_in
add wave -position insertpoint /tb_r4mbe/uut/s_be
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p0
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p1
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p2
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p3
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/p4
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/s_l0
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/c_l0
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/f_l0
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/s_l1
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/c_l1
add wave -position insertpoint /tb_r4mbe/uut/wt_inst/f_l1

run 450 ns
