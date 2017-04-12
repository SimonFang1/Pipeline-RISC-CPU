`timescale 1ns / 1ps

module carry_test;
    reg [3:0] a, b, sum;
	 reg ex;
	 reg carry;
	 reg add;
	 reg signal;
	 initial begin
	     #100;
	     signal = 0;
		  
		  add = 1;
	     $display("test addition");
	     a = 10;
		  b = 7;
		  signal = ~signal;
		  #1;
		  
		  add = 0;
	     $display("test subtraction");
		  a = 1;
		  b = 4;
		  signal = ~signal;
		  #1;
	 end
	 
	 always @(signal) begin
	     if (add) begin
		      {ex, sum} = a + b;
				carry = ex;
		      $display("carry=%b, sum=%b, a = %b, b = %b", carry, sum, a, b);
		  end else begin
		      {ex, sum} = a - b;
		      carry = ex;
		      $display("borrow=%b, diff=%b, a = %b, b = %b", carry, sum, a, b);
		  end
	 end
		  
		  
endmodule
