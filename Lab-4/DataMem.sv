module DataMem #(
    parameter ADDRESS_WIDTH = 32;
    parameter DATA_WIDTH = 32;
)(
    input  logic                         clk,
    input  logic                         we;
    input  logic [ADDRESS_WIDTH-1:0]     address;
    input  logic [DATA_WIDTH-1:0]        writeData;
    output logic [DATA_WIDTH-1:0]        readData;
)

    logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH=1:0];

    always_ff @(posedge clk) begin
        if (we == 1'b1)
            ram_array[address] <= writeData;
        else 
            readData <= ram_array[address]
    end

endmodule
