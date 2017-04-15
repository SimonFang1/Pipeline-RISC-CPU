`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:07:34 04/11/2017 
// Design Name: 
// Module Name:    imem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module imem(
    input [7:0] address,
	 output [15:0] q
    );
	 reg [15:0] ram[0:255];
	 assign q = ram[address];
	 initial begin
	     $readmemb("ipcore_dir/i_mem.mif", ram);
	 end
endmodule
