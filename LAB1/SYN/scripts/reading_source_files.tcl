analyze -f vhdl -lib WORK {../src/filter_core.vhd ../src/FF.vhd ../src/regn_s.vhd}
set power_preserve_rtl_hier_names true
elaborate filter_core -arch beh -lib WORK