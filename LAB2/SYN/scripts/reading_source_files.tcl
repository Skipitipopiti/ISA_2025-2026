analyze -f vhdl -lib WORK {../cvfpu_lite/src/cf_math_pkg.sv ../cvfpu_lite/src/lzc.sv ../cvfpu_lite/src/rr_arb_tree.sv ../cvfpu_lite/src/fpnew_pkg.sv ../cvfpu_lite/src/fpnew_classifier.sv ../cvfpu_lite/src/fpnew_rounding.sv ../cvfpu_lite/src/fpnew_fma.sv ../cvfpu_lite/src/fpnew_opgroup_fmt_slice.sv ../cvfpu_lite/src/fpnew_opgroup_block.sv ../cvfpu_lite/src/fpnew_top.sv  }
set power_preserve_rtl_hier_names true
elaborate fpnew_top -arch beh -lib WORK

