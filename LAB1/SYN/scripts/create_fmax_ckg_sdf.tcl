 ungroup -all -flatten
 change_names -hierarchy -rules verilog
 write_sdf ../netlist/filter_core_fmax_ckg.sdf
 write -f verilog -hierarchy -output ../netlist/filter_core_fmax_ckg.v
 write_sdc ../netlist/filter_core_fmax_ckg.sdc