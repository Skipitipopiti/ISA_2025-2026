vcom -work ./work ../R4-MBE/vhdl/ha.vhd
vcom -work ./work ../R4-MBE/vhdl/fa.vhd
vcom -work ./work ../R4-MBE/vhdl/wallace_tree.vhd
vcom -work ./work ../R4-MBE/vhdl/booth_encoder.vhd
vcom -work ./work ../R4-MBE/vhdl/r4mbe.vhd

vcom -work ./work ../tb/tb_r4mbe.vhd

vsim -t ps work.tb_r4mbe -voptargs=+acc

add wave *
run 450 ns
