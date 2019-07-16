 module datapath(input  logic        clk, reset,
                output logic [31:0] Adr, WriteData,
                input  logic [31:0] ReadData,
                output logic [31:0] Instr,
                output logic [3:0]  ALUFlags,
                input  logic        PCWrite, RegWrite,
                input  logic        IRWrite,
                input  logic        AdrSrc, 
                input  logic [1:0]  RegSrc, 
                input  logic [1:0]  ALUSrcA, ALUSrcB, ResultSrc,
                input  logic [1:0]  ImmSrc, ALUControl);

  logic [31:0]  PC; //PCnext is equal to result
  logic [31:0] ExtImm, SrcA, SrcB, Result;
  logic [31:0] Data, RD1, RD2, A, ALUResult, ALUOut;
  logic [3:0] RA1, RA2;
  logic [31:0] shifted;

  //the register that saves the read data from memory
  flopr #(32) registerMRD (clk , reset , ReadData , Data);
  //the register that saves the instruction read from memory
  flopenr #(32) registerMRI (clk , reset , IRWrite, ReadData , Instr);
  //muxes for RA1 and RA2 (the first and second input for register file)
  mux2 #(4) muxRA1(Instr[19:16] , 4'b1111 , RegSrc[0] , RA1);
  mux2 #(4) muxRA2(Instr[3:0] , Instr[15:12] , RegSrc[1] , RA2);
  //register file 
  regfile registerfile(clk, RegWrite, RA1, RA2, Instr[15:12], Result, Result, RD1, RD2); 
  //extending the immediate vlaues
  extend ext(Instr[23:0], ImmSrc, ExtImm);
  //registers that save RD1 and RD2 
  flopr #(32) registerRD1 (clk , reset , RD1 , A);
  flopr #(32) registerRD2 (clk , reset , RD2 , WriteData);
  //muxes selecting the input for ALU
  mux2 #(32) muxSrcA(A , PC , ALUSrcA[0] , SrcA);
  mux3 #(32) muxSrcB(shifted , ExtImm, 32'd4 , ALUSrcB , SrcB);
  //shift module (external point)
  
  shifter shift_module ( WriteData ,Instr[25], Instr [11:7], Instr[6:5] ,Instr[4], shifted);
  //ALU 
  ALU #(32) mainalu (SrcA , SrcB ,ALUControl , ALUResult,ALUFlags);
  flopr #(32) registerAlUres (clk , reset , ALUResult , ALUOut);
  //mux selecting the result 
  mux3 #(32) muxresult (ALUOut ,Data, ALUResult,ResultSrc,Result);
  //the address (input for memory)
  mux2 #(32) muxAdr(PC , Result , AdrSrc , Adr);
  //the register saving pc 
  flopenr #(32) registerPC (clk , reset , PCWrite, Result , PC);
  
endmodule