module ALU #(
    parameter DATA_WIDTH = 32;
)(
    input  logic   [DATA_WIDTH-1:0] ALUop1,
    input  logic   [DATA_WIDTH-1:0] ALUop2,
    input  logic              [2:0] ALUctrl,
    output logic   [DATA_WIDTH-1:0] sum,
    output logic                    eq
);

    always_comb begin
        if(ALUctrl == 0)
            sum <= ALUop1 + ALUop2;
        if (ALUop1 = ALUop2)
                eq <= 1;
    end

endmodule
