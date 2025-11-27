 ungroup -all -flatten
 change_names -hierarchy -rules verilog
 write_sdf ../netlist/fpnew_top_fmax.sdf
 write -f verilog -hierarchy -output ../netlist/fpnew_top_fmax.v
 write_sdc ../netlist/fpnew_top_fmax.sdc