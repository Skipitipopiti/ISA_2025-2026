vcom -work ./work ../R4-MBE/vhdl/ha.vhd
vcom -work ./work ../R4-MBE/vhdl/fa.vhd
vcom -work ./work ../R4-MBE/vhdl/wallace_tree.vhd

vcom -work ./work ../tb/tb_wallace_tree.vhd

vsim -t ps work.tb_wallace_tree -voptargs=+acc

add wave *
run 250 ns
