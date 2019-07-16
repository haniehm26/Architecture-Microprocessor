module condlogic(input  logic       clk, reset,
                 input  logic [3:0] Cond,
                 input  logic [3:0] ALUFlags,
                 input  logic [1:0] FlagW,
                 input logic NoWrite,
                 input  logic       PCS, NextPC, RegW, MemW,
                 output logic       PCWrite, RegWrite, MemWrite);

  logic [1:0] FlagWrite;
  logic [3:0] Flags;
  logic       CondEx;
  logic CondEx_q;
  
  assign FlagWrite = FlagW & {2{CondEx}};

  // flopr #(2)flagwritereg(clk, reset, FlagW&{2{CondEx}}, FlagWrite);

  flopr #(1) CondExreg(clk, reset, CondEx, CondEx_q);
  flopenr #(2) flagreg1(clk, reset, FlagWrite[1], ALUFlags[3:2], Flags[3:2]);
  flopenr #(2) flagreg0(clk, reset, FlagWrite[0], ALUFlags[1:0], Flags[1:0]);
  
  condcheck condchecker (Cond,Flags,CondEx);

  assign RegWrite = RegW & CondEx_q;
  assign MemWrite = MemW & CondEx_q & (~NoWrite);
  assign PCWrite = (PCS & CondEx_q) | NextPC;
endmodule   
