read_verilog -netlist ../netlist/filter_core_fmax_ckg.v
current_design filter_core
read_saif -input ../saif/filter_core_fmax_ckg_syn.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK -period 2.18 clk