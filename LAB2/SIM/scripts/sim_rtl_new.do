vcom -work ./work ../cvfpu_lite/tb/clk_gen.vhd
vcom -work ./work ../cvfpu_lite/tb/data_gen16.vhd

vlog -work ./work ../cvfpu_lite/src/cf_math_pkg.sv
vlog -work ./work ../cvfpu_lite/src/lzc.sv
vlog -work ./work ../cvfpu_lite/src/rr_arb_tree.sv
vlog -work ./work ../cvfpu_lite/src/fpnew_pkg.sv
vlog -work ./work ../cvfpu_lite/src/fpnew_classifier.sv
vlog -work ./work ../cvfpu_lite/src/fpnew_rounding.sv
vlog -work ./work ../cvfpu_lite/src/fpnew_fma_r4mbe.sv
vlog -work ./work ../cvfpu_lite/src/fpnew_opgroup_fmt_slice.sv
vlog -work ./work ../cvfpu_lite/src/fpnew_opgroup_block.sv
vlog -work ./work ../cvfpu_lite/src/fpnew_top.sv

vlog -sv -work ./work ../R4-MBE/verilog/ha.sv
vlog -sv -work ./work ../R4-MBE/verilog/fa.sv
vlog -sv -work ./work ../R4-MBE/verilog/wallace_tree.sv
vlog -sv -work ./work ../R4-MBE/verilog/booth_encoder.sv
vlog -sv -work ./work ../R4-MBE/verilog/r4mbe.sv

vlog -sv -work ./work ../cvfpu_lite/tb/tb_fpnew_top_rtl.sv

vsim -t ps work.tb_fpnew_top_rtl -voptargs=+acc

add wave *
run 250 ns