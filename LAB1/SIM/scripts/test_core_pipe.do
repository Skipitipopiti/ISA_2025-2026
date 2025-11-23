vcom -work ./work ../src/regn_s.vhd
vcom -work ./work ../src/FF.vhd
vcom -work ./work ../src/filter_core_pipe_10Tadd.vhd
vcom -work ./work ../tb/clk_gen.vhd
vcom -work ./work ../tb/data_maker.vhd
vcom -work ./work ../tb/data_sink.vhd

vlog -sv -work ./work ../tb/tb_fir_pipe_10Tadd.sv
vsim work.tb_fir_pipe_10Tadd -voptargs=+acc
add wave *
run 1 ms