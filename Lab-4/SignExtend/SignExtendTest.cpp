#include <iostream>
#include <iomanip>
#include <bitset>
#include "VSignExtend.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {

Verilated::commandArgs(argc, argv);
// init top verilog instance
VSignExtend* top = new VSignExtend;
//init trace dump
Verilated::traceEverOn(true);
VerilatedVcdC* tfp = new VerilatedVcdC;
top->trace (tfp, 99);
tfp->open ("SignExtend.vcd");

std::cout << "Testing Imm type" << std::endl;

top->ImmSrc = 0;
top->instr = 0b10000000000000000000000000000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;

top->ImmSrc = 0;
top->instr = 0b01000000000000000000000000000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;

std::cout << "Testing UppImm type" << std::endl;

top->ImmSrc = 1;
top->instr = 0b11111111111111111111111111111111;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;

std::cout << "Testing Store type" << std::endl;

top->ImmSrc = 2;
top->instr = 0b11111110000000000000111110000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;

top->ImmSrc = 2;
top->instr = 0b01111110000000000000111110000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;

std::cout << "Testing Branch type" << std::endl;

top->ImmSrc = 3;
top->instr = 0b11111110000000000000111110000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;

top->ImmSrc = 3;
top->instr = 0b00111110000000000000111110000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;
//Output here should have bit 10 = 0

std::cout << "Testing Jump type" << std::endl;

top->ImmSrc = 4;
top->instr = 0b11111111111111111111000000000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;

top->ImmSrc = 4;
top->instr = 0b00111111111111111111000000000000;
top->eval ();
std::cout << std::bitset<32>(top->ImmOp) << std::endl;
//Output here should have bit 10 = 0


if  (Verilated::gotFinish())
    exit(0);                
    tfp->close();
}
