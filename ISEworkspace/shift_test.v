`timescale 1ns / 1ps
module shift_test;
	 
	 reg signed [3:0] fuck;
	 
	 initial begin
		  fuck = -5;
		  $display("origin:%b", fuck);
		  $display("LSL:%b", fuck << 1);
	     $display("LSA:%b", fuck <<< 1);
		  $display("RSL:%b", fuck >> 1);
		  $display("RSA:%b", fuck >>> 1);
	 end
      
endmodule

