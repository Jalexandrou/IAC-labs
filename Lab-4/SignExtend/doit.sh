#!/bin/sh

#cleanup
rm -rf obj_dir
rm -f *.vcd

#run Verilator to translate Verilog into C++, including C++ testbench
verilator -Wall --cc --trace SignExtend.sv --exe SignExtendTest.cpp

#build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f VSignExtend.mk VSignExtend

#run executable simulation file
obj_dir/VSignExtend