module RedBlock #(
    parameter ADDRESS_WIDTH = 32;
    parameter DATA_WIDTH = 32;
)(
    input logic     [ADDRESS_WIDTH-1:0] rs1,
    input logic     [ADDRESS_WIDTH-1:0] rs2,
    input logic     [ADDRESS_WIDTH-1:0] rd,
    input logic                         RegWrite,
    input logic                         clk,
    input logic        [DATA_WIDTH-1:0] ImmOp,
    input logic                   [2:0] ALUsrc,
    input logic                         ALUctrl,
    output logic                        a0,
    output logic                        eq                    
);
    logic [DATA_WIDTH-1:0] ALUop1;
    logic [DATA_WIDTH-1:0] ALUop2;
    logic [DATA_WIDTH-1:0] regOp2;
    logic [DATA_WIDTH-1:0] ALUout;

    RegFile RegisterFile (
        .clk (clk),
        .ad1 (rs1),
        .ad2 (rs2),
        .ad3 (rd),
        .we3 (RegWrite),
        .wd3 (ALUout),
        .rd1 (ALUop1),
        .rd2 (regOp2),
        .a0 (a0)
    );

    mux mux2 (
        .regOp2 (regOp2),
        .ImmOp (ImmOp),
        .ALUop2 (ALUop2)
    );

    ALU adder (
        .ALUop1 (ALUop1),
        .ALUop2 (ALUop2),
        .sum (ALUout),
        .eq (eq),
        .ALUctrl (ALUctrl)
    );

endmodule
