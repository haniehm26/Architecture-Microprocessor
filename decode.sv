module decode (input logic       clk, reset,
              input logic [1:0] Op,
              input logic [5:0] Funct,
              input logic [3:0] Rd,
              output logic [1:0] FlagW,
              output logic       PCS, NextPC, RegW, MemW,
              output logic       IRWrite, AdrSrc,NoWrite,
              output logic [1:0] ResultSrc,
              output logic  ALUSrcA, 
              output logic [0:1] ALUSrcB, 
              output logic [1:0] ImmSrc, RegSrc, ALUControl);
  
  logic Branch ; 
  logic ALUOp;
  micro_control microinstruction_cont (clk,reset,Funct[5],Funct[0],Op, RegW, MemW, 
                                        IRWrite,NextPC,AdrSrc,Branch,ResultSrc,ALUSrcA ,ALUSrcB,ALUOp);

  PCLogic pc_logic (Rd, Branch, RegW, PCS);

  ALUDecoder alu_decoder (Funct[4:0], ALUOp, ALUControl,FlagW,NoWrite);
  instrDecoder instr_decoder (Op, ImmSrc, RegSrc);
endmodule
