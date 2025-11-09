vcom -work ./work ../cvfpu_lite/tb/clk_gen.vhd
vcom -work ./work ../cvfpu_lite/tb/data_gen16.vhd

vlog -work ./work ../netlist/
vlog -sv -work ./work ../cvfpu_lite/tb/tb_fpnew_top_net.sv

vsim -L /eda/dk/nangate45/verilog/qsim2020.4 work.tb_fir
vsim -t ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fir/UUT=../netlist/filter_core_fmax.sdf work.tb_fir

vcd file ../vcd/filter_core_fmax_syn.vcd
vcd add /tb_fir/UUT/*

add wave *
run 1 us 