 ungroup -all -flatten
 change_names -hierarchy -rules verilog
 write_sdf ../netlist/filter_core_half_fmax.sdf
 write -f verilog -hierarchy -output ../netlist/filter_core_half_fmax.v
 write_sdc ../netlist/filter_core_half_fmax.sdc