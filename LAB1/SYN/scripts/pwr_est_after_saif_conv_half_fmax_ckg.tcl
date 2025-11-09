read_verilog -netlist ../netlist/filter_core_half_fmax_ckg.v
current_design filter_core
read_saif -input ../saif/filter_core_half_fmax_ckg_syn.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK -period 4.36 clk