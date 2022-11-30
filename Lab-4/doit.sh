#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f cpu.vcd

sudo chmod -R 777 $(<vbuddy.cfg)

verilator -Wall --cc --trace cpu.sv --exe cpu_tb.cpp

make -j -C obj_dir/ -f Vcpu.mk Vcpu

obj_dir/Vcpu