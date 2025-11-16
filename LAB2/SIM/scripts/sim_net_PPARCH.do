vcom -work ./work ../cvfpu_lite/tb/clk_gen.vhd
vcom -work ./work ../cvfpu_lite/tb/data_gen16.vhd

vlog -work ./work ../netlist/fpnew_top_fmax_PPARCH.v
vlog -work ./work ../cvfpu_lite/src/fpnew_pkg.sv
vlog -sv -work ./work ../cvfpu_lite/tb/tb_fpnew_top_net.sv

vsim -t ps -L /eda/dk/nangate45/verilog/qsim2020.4 -sdftyp /tb_fpnew_top_net/UUT=../netlist/fpnew_top_fmax_PPARCH.sdf work.tb_fpnew_top_net

add wave *
run 250 ns