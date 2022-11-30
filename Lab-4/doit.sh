#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f __FILENAME__.vcd

sudo chmod -R 777 $(<vbuddy.cfg)

verilator -Wall --cc --trace __FILENAME__.sv --exe __FILENAME___tb.cpp

make -j -C obj_dir/ -f V__FILENAME__.mk V__FILENAME__

obj_dir/V__FILENAME__