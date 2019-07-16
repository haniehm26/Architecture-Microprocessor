module ALUDecoder (input logic [4:0] Funct,
				   input logic Op,
				   output logic [1:0] ALUControl,
				   output logic [1:0] FlagW,
				   output logic NoWrite);


	logic [1:0] contorlDP, ALUControlTmp , FlagWT ; 
	// logic NoWrite ; 
	assign ALUControl = NoWrite ? 2'b01 : ALUControlTmp;
	assign ALUControlTmp = Op ? contorlDP : 2'b00;

	assign contorlDP = Funct [4:1] == 4'b0100 ? 2'b00 : //add
					   Funct [4:1] == 4'b0010 ? 2'b01 : //sub
					   Funct [4:1] == 4'b0000 ? 2'b10 : //and
					   Funct [4:1] == 4'b1100 ? 2'b11 : 2'b00 ; //or


	assign FlagW = NoWrite ? 2'b11 : FlagWT ; 
	assign FlagWT = (Op & Funct [0]) ? (Funct[4:1] == 4'b0100 ) ? 2'b11 : 
	(Funct[4:1] == 4'b0100 ) ? 2'b11 : ((Funct[4:1] == 4'b0000 ) ? 2'b10 : 2'b10) : 2'b00 ;

	assign NoWrite = (Funct[4:1] == 4'b1010);


endmodule // ALUDecoder