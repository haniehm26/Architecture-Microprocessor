module sequential_logic (input logic [1:0] Op,
              input logic [5:0] Funct,
              input logic [3:0] Rd,
              input logic [4:0] branch_target,
              output logic [4:0] address);
	
	always_comb case (branch_target)
		5'b01010 :  address = (Op == 2'b00) ? (Funct[5] ? 00111 : 00110) :
									(Op == 2'b01 ? 00010 : 01001);
		5'b01011 :  address = (Funct[0] ? 00011 : 00101);
		default :  address = branch_target;
	endcase
endmodule // sequential_logic