vcom -work ./work ../tb/clk_gen_pipe_10Tadd_half_fmax.vhd
vcom -work ./work ../tb/data_maker_pipe_10Tadd_half_fmax.vhd
vcom -work ./work ../tb/data_sink_pipe_10Tadd_half_fmax.vhd

vlog -work ./work ../netlist/filter_core_pipe_10Tadd_half_fmax.v
vlog -sv -work ./work ../tb/tb_fir_pipe_10Tadd.sv

vsim -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir_pipe_10Tadd
vsim -t ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fir_pipe_10Tadd/UUT=../netlist/filter_core_pipe_10Tadd_half_fmax.sdf work.tb_fir_pipe_10Tadd

vcd file ../vcd/filter_core_pipe_10Tadd_half_fmax_syn.vcd
vcd add /tb_fir_pipe_10Tadd/UUT/*

add wave *
run 9 us 