vcom -work ./work ../src/regn_s.vhd
vcom -work ./work ../src/FF.vhd
vcom -work ./work ../src/filter_core.vhd
vcom -work ./work ../tb/clk_gen.vhd
vcom -work ./work ../tb/data_maker.vhd
vcom -work ./work ../tb/data_sink.vhd

vlog -sv -work ./work ../tb/tb_fir.sv
vsim work.tb_fir -voptargs=+acc
add wave *
run 41 us