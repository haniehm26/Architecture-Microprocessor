module instrDecoder (input logic [1:0] Op,
					 output logic [1:0] ImmSrc,
					 output logic [1:0] RegSrc);
	assign ImmSrc = Op;
	assign RegSrc[1] = (Op == 2'b01);
	assign RegSrc[0] = (Op == 2'b10);
endmodule // instrDecoder