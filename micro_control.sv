module micro_control (input logic  clk, reset,
					  input logic Funct5,Funct0,
					  input logic [1:0] Op,

					  output logic RegW, MemW, IRWrite, NextPC,
					  output logic AdrSrc, Branch , 
					  output logic [1:0] ResultSrc,
					  output logic SrcA ,
					  output logic [1:0] SrcB,
					  output logic ALUOp);

	logic[4:0] branch_target;
  logic[4:0] curr_address;
 	logic[16:0] control_line;
 	logic[16:0] next_add_control;
 	
  sequential_logic1 seq_logic (Op,Funct5,Funct0,next_add_control[4:0],branch_target);

  rom memory_address (branch_target , control_line);

  always_ff @(posedge clk ) 
   	if (reset)  next_add_control <= 17'b10010101100000001; 
   	else next_add_control<= control_line;

  assign {NextPC , RegW , MemW , IRWrite , AdrSrc} = next_add_control [16:12];
  assign ResultSrc = next_add_control [11:10];
  assign SrcA = next_add_control [9];
  assign SrcB = next_add_control [8:7];
  assign ALUOp = next_add_control [6];
  assign Branch = next_add_control [5];

endmodule


module sequential_logic1 (input logic [1:0] Op,
              input logic Funct5, Funct0,
              input logic [4:0] branch_target,
              output logic [4:0] address);

	logic [4:0] assignDecode,assignMemRead;
	
    assign address = (branch_target == 5'b01010) ? assignDecode : ((branch_target == 5'b01011) ? assignMemRead : branch_target); 
    assign assignDecode = (Op==2'b01) ? 5'b00010 : (Op==2'b10) ? 5'b01001 : (Funct5) ? 5'b00111 : 5'b00110;
    assign assignMemRead = (Funct0) ? 5'b00011: 5'b00101;

endmodule // sequential_logic