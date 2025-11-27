 ungroup -all -flatten
 change_names -hierarchy -rules verilog
 write_sdf ../netlist/fpnew_top_fmax_PPARCH.sdf
 write -f verilog -hierarchy -output ../netlist/fpnew_top_fmax_PPARCH.v
