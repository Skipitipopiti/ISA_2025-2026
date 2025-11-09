vcom -work ./work ../tb/clk_gen_half_fmax_ckg.vhd
vcom -work ./work ../tb/data_maker_half_fmax_ckg.vhd
vcom -work ./work ../tb/data_sink_half_fmax_ckg.vhd

vlog -work ./work ../netlist/filter_core_half_fmax_ckg.v
vlog -sv -work ./work ../tb/tb_fir.sv

vsim -t ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fir/UUT=../netlist/filter_core_half_fmax_ckg.sdf work.tb_fir

vcd file ../vcd/filter_core_half_fmax_ckg_syn.vcd
vcd add /tb_fir/UUT/*

add wave *
run 9 us 