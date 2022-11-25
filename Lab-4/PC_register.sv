module PC_register #(
    parameter WIDTH = 32
)(
    // interface signals
    input logic             clk,    //clock
    input logic             rst,    //reset
    input logic             inc,    //increment 
    output logic [WIDTH-1:0] PC     //PC output
);

always_ff @ (posedge clk)
    if (rst) PC <= {WIDTH{1'b0}};       
    else     PC <= PC + inc;
    
endmodule
