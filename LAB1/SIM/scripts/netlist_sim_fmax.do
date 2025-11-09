vcom -work ./work ../tb/clk_gen_fmax.vhd
vcom -work ./work ../tb/data_maker_fmax.vhd
vcom -work ./work ../tb/data_sink_fmax.vhd

vlog -work ./work ../netlist/filter_core_fmax.v
vlog -sv -work ./work ../tb/tb_fir.sv

vsim -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir
vsim -t ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fir/UUT=../netlist/filter_core_fmax.sdf work.tb_fir

vcd file ../vcd/filter_core_fmax_syn.vcd
vcd add /tb_fir/UUT/*

add wave *
run 9 us 
