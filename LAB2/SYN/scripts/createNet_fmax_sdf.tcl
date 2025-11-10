 ungroup -all -flatten
 change_names -hierarchy -rules verilog
 write_sdf ../netlist/fpnew_top.sdf
 write -f verilog -hierarchy -output ../netlist/fpnew_top.v
 write_sdc ../netlist/fpnew_top.sdc