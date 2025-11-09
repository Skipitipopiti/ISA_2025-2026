analyze -f vhdl -lib WORK {../src/filter_core_pipe_10Tadd.vhd ../src/FF.vhd ../src/regn_s.vhd}
set power_preserve_rtl_hier_names true
elaborate filter_core_pipe_10Tadd -arch beh -lib WORK