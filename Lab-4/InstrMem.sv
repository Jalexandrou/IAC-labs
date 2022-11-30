module InstrMem #(
    parameter   DATA_WIDTH  = 8,
    parameter   INSTR_WIDTH = 32
)(
    input logic     [INSTR_WIDTH-1:0]      PC,
    output logic    [INSTR_WIDTH-1:0]      instr
);

logic [DATA_WIDTH-1:0] rom_array [2**16-1:0];

initial begin
        $readmemh("program.mem", rom_array);
end;
        //output is asynchronous
always_comb begin
    instr = {rom_array[PC], rom_array[PC+1],  rom_array[PC+2],  rom_array[PC+3]}; 
end; 
           
endmodule    
