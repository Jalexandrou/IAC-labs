module ALU #(
    parameter DATA_WIDTH = 32;
)(
    input  logic   [DATA_WIDTH-1:0] ALUop1,
    input  logic   [DATA_WIDTH-1:0] ALUop2,
    input  logic   [2:0]            ALUctrl,
    output logic   [DATA_WIDTH-1:0] ALUOut,
    output logic                    eq
);

    typedef enum bit[2:0] {add, subtract, and, or, slt = 5} func;

    always_comb begin
        case(ALUctrl)
            add: ALUOut = ALUop1 + ALUop2;
            subtract: ALUOut = ALUop1 - ALUop2;
            and: ALUOut = ALUop1 & ALUop2;
            or: ALUOut = ALUop1 | ALUop2;
            slt: ALUOut = (ALUop1 < ALUop2) ? 1 : 0;
            default: ALUOut = ALUop1 + ALUop2;
        endcase
        if (ALUop1 = ALUop2) eq = 1;
        else                 eq = 0;
    end;


endmodule
