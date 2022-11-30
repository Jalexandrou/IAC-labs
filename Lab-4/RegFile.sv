module RegFile #(
    parameter   ADDRESS_WIDTH = 32,
                DATA_WIDTH = 32
)(
    input  logic                         clk,
    input  logic     [ADDRESS_WIDTH-1:0] ad1,
    input  logic     [ADDRESS_WIDTH-1:0] ad2,
    input  logic     [ADDRESS_WIDTH-1:0] ad3,
    input  logic                         we3,
    input  logic     [DATA_WIDTH-1:0]    wd3,
    output logic     [DATA-WIDTH-1:0]    rd1,
    output logic     [DATA_WIDTH-1:0]    rd2,
    output logic     [DATA_WIDTH-1:0]    a0
);

    logic [DATA_WIDTH-1:0] reg_file [2**ADDRESS_WIDTH=1:0];

    always_ff @(posedge clk) begin
        if (we3 == 1'b1)
            reg_file[ad3] <= wd3;
    end

    always_comb begin
            rd1 <= reg_file[ad1];
            rd2 <= reg_file[ad2];
    end
    
endmodule
