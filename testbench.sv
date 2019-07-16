//TESTBENCH
module testbench(); 
	logic clk;
	logic reset;
	logic [31:0] WriteData, DataAdr;
	logic MemWrite;

	top dut(clk, reset, WriteData, DataAdr, MemWrite);
 
    initial begin 
   	 reset <= 1; # 7; reset <= 0; 
   	end

    always begin
   	 clk <= 0; # 5; clk <= 1; # 5; 
   	end
endmodule