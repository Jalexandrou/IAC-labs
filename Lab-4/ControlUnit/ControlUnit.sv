module ControlUnit #(
    parameter   INSTR_WIDTH = 32
)(
	input 	logic 		        EQ,
	input 	[INSTR_WIDTH-1:0] 	instr,	
	output 	logic 		        RegWrite,	// enable to write regs
	output 	[2:0] 	            ALUctrl,
	output 	logic 		        ALUsrc,		
	output 	[2:0]               ImmSrc,		
	output 	logic 		        PCsrc	
);

typedef enum bit[6:0]   {addi = 7'b0010011, bne = 7'b1100011}   Opcode;

always_comb begin
	case (instr[6:0])
		addi: begin	
                RegWrite = 1;		
			    ALUctrl = 0;
	            ALUsrc = 1;
	            ImmSrc = 0;
	            PCsrc = 0;
		end
		bne: if (!EQ) begin
				RegWrite = 0;		
				ALUctrl = 001; //check if this is required for value of EQ
	            ALUsrc = 0;
	            ImmSrc = 3;
	            PCsrc = 1;
		end
		default: begin
			    RegWrite = 0; // Ensure no register is written to by default
                ALUctrl = 0;
	            ALUsrc = 0;
	            ImmSrc = 0;
	            PCsrc = 0;
		end
	endcase
end

endmodule
