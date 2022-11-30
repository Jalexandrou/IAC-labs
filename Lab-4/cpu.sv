module cpu #(
    parameter   ADDRESS_WIDTH = 32,           // Parameters
                DATA_WIDTH = 32
)(
    input logic                     clk,      // Input/Output Logic
    input logic                     rst,
    output logic [DATA_WIDTH-1:0]   a0                  
);
    logic [DATA_WIDTH-1:0] ALUop1;          // Interconnecting Wires For ALU
    logic [DATA_WIDTH-1:0] ALUop2;
    logic [DATA_WIDTH-1:0] ALUOut;
    logic                  ALUctrl;
    logic                  ALUsrc;
    logic                  eq;

    logic [DATA_WIDTH-1:0] regOp2;         // Interconnecting Wires For RegFile
    logic [DATA_WIDTH-1:0] rs1;
    logic [DATA_WIDTH-1:0] rs2;
    logic [DATA_WIDTH-1:0] rd;
    logic                  RegWrite;

    logic [DATA_WIDTH-1:0] ImmOp;          // Interconnecting Wires For Sign Extend
    logic                  ImmSrc;

    logic [DATA_WIDTH-1:0] instr;           // Interconnecting Wires For PC
    logic [DATA_WIDTH-1:0] pc;
    logic [DATA_WIDTH-1:0] next_pc;
    logic                  PCsrc;

    RegFile RegFile (          
        .clk (clk),
        .ad1 (rs1),
        .ad2 (rs2),
        .ad3 (rd),
        .we3 (RegWrite),
        .wd3 (ALUOut),
        .rd1 (ALUop1),
        .rd2 (regOp2),
        .a0 (a0)
    );

    mux ALUmux (
        .regOp2 (regOp2),
        .ImmOp (ImmOp),
        .ALUop2 (ALUop2)
        .ALUsrc (ALUsrc)
    );

    ALU ALU (
        .ALUop1 (ALUop1),
        .ALUop2 (ALUop2),
        .ALUOut (ALUOut),
        .eq (eq),
        .ALUctrl (ALUctrl)
    );

    SignExtend SignExtend (
        .ImmOp (ImmOp),
        .ImmSrc (ImmSrc),
        .instr (insrt)
    );

    InstrMem InstrMem (
        .instr  (instr),
        .PC     (pc)
    );

    PC_register PCReg (
        .PC     (pc),
        .inc    (next_pc),
        .clk    (clk),
        .rst    (rst)
    );
    
    next_PC PCMux (
        .next_PC (next_pc),
        .PC (pc),
        .ImmOp (ImmOp),
        .PCsrc (PCsrc)
    );

    ControlUnit ControlUnit (
        .instr (instr),
        .EQ    (eq),
        .RegWrite (RegWrite),
        .ALUctrl (ALUctrl),
        .ALUsrc (ALUsrc),
        .ImmSrc (ImmSrc),
        .PCsrc (PCsrc)
    );

endmodule
