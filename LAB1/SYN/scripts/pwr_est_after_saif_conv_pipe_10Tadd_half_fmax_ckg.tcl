read_verilog -netlist ../netlist/filter_core_pipe_10Tadd_half_fmax_ckg.v
current_design filter_core_pipe_10Tadd
read_saif -input ../saif/filter_core_pipe_10Tadd_half_fmax_ckg_syn.saif -instance tb_fir_pipe_10Tadd/UUT -unit ns -scale 1
create_clock -name MY_CLK -period 3.06 clk