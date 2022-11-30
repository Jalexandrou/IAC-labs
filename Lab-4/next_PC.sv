module next_PC #(
    parameter WIDTH = 32
)(
    // interface signals
    input logic [WIDTH-1:0] PC,         //PC cycle
    input logic [WIDTH-1:0] ImmOp,      //Immediate Operand 
    input logic             PCsrc,      //PC src 
    output logic [WIDTH-1:0] next_PC    //next PC output
);

    logic branch_PC, inc_PC;

    assign branch_PC= PC + ImmOp;
    assign inc_PC= PC + 3'b100;
    assign next_PC= PCsrc ? branch_PC : inc_PC;
    
endmodule
