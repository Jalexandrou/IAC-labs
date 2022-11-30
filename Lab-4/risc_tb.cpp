#include "Vcpu.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"



int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    Vcpu* top = new Vcpu;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;

    top->trace(tfp, 99);
    tfp->open ("cpu.vcd");

    if (vbdOpen()!=1) return (-1);

    top->clk = 1;
    top->rst = 0;

    for (i=0; i<1000000; i++) {

        for (clk=0; clk<2; clk++) {
            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval ();
        }

        vbdHex(1, top->a0 & 0xF);
        vbdBar(top->a0 & 0xFF);

        if (Verilated::gotFinish() || (vbdGetkey()=='q')) exit(0);

    }

    vbdClose();
    tfp->close();
    exit(0);
}