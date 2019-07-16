module shifter (input logic [31:0] firstvalue,
				input logic imm,
				input logic [4:0] shammt,
				input logic [1:0] sh,
				input logic regshammt , 
				output logic [31:0] shifted);
	logic [31:0] immshift;
	logic [63:0] temprotate;
	logic [63:0] doubleshift;
	assign shifted = ~imm & ~regshammt ? immshift : firstvalue ;
	assign temprotate = {firstvalue , firstvalue};
	assign doubleshift = temprotate >> shammt ; 
	assign immshift = (sh == 2'b00) ? firstvalue  << shammt : //lsl
					  (sh == 2'b01) ? firstvalue >> shammt :  //lsr
					  (sh == 2'b10) ? firstvalue >>> shammt : //asr
					  (sh == 2'b11) ? doubleshift [31:0] : firstvalue  << shammt ; //ror
					  
endmodule // shifter