module PCLogic (input logic [3:0] Rd,
				input logic Branch,
				input logic RegW,
				output logic PCS);

	assign PCS = ((Rd == 4'b1111) & RegW) | Branch; 
endmodule