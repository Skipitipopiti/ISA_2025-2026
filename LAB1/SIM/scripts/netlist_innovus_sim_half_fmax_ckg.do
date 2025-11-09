vcom -work ./work ../tb/clk_gen_half_fmax_ckg.vhd
vcom -work ./work ../tb/data_maker_half_fmax_ckg.vhd
vcom -work ./work ../tb/data_sink_half_fmax_ckg.vhd

vlog -work ./work ../innovus/innovus_out/filter_core_half_fmax_ckg_innovus.v
vlog -sv -work ./work ../tb/tb_fir.sv

vsim -t ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdfmax /tb_fir/UUT=../innovus/innovus_out/filter_core_half_fmax_ckg_innovus.sdf work.tb_fir

vcd file ../vcd/filter_core_half_fmax_ckg_syn_innovus.vcd
vcd add /tb_fir/UUT/*

add wave *
run 9 us 