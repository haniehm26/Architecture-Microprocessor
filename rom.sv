module rom(input logic [4:0] adr, 
		   output logic [16:0] dout);
	always_comb case(adr) 
		//next_pc regw MemW	IRWrite	AdrSrc ResSrc[1:0]	ALUsrcA ALUSrcB[1:0] ALUOP

		5'b00000: dout = 17'b10010101100000001; //fetch 
		5'b00001: dout = 17'b00000101100001010; //decode 
		5'b00010: dout = 17'b00000100010001011; //memadr
		5'b00011: dout = 17'b00001000000000100; //memread
		5'b00100: dout = 17'b01000010000000000; //memwb
		5'b00101: dout = 17'b00101000000000000; //memwrite
		5'b00110: dout = 17'b00000100001001000; //executeR
		5'b00111: dout = 17'b00000100011001000; //executeI
		5'b01000: dout = 17'b01000000000000000; //aluwb
		5'b01001: dout = 17'b00000100010100000; //branch
		default : dout = 17'b10010101100000001; //default
	endcase
endmodule