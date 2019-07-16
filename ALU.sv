module ALU#(parameter WIDTH = 32) (input logic [31:0] a,b,
			input logic [31:0] ALUcontrol,
			output logic [31:0] Result ,
			output logic [3:0] ALUflags);
	logic neg,zero,carry,overflow;
	logic [31:0] condinvb;
	logic [32:0] sum;
	assign condinvb = ALUcontrol[0] ? ~b:b;
	assign sum = a + condinvb + ALUcontrol[0];

	
	always_comb 
		casex (ALUcontrol[1:0])
		2'b0?: Result = sum;
		2'b10: Result = a&b;
		2'b11: Result = a|b;
	endcase

	assign neg = Result[31];
	assign zero = (Result == 32'b0);
	assign carry = (ALUcontrol[1] == 1'b0) & sum[32];
	assign overflow = (ALUcontrol[1] == 1'b0) & ~(a[31]^b[31]^ALUcontrol[0]) 
					&(a[31]^sum[31]);
	assign ALUflags = {neg , zero , carry , overflow};
endmodule // ALU