`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:09:22 04/11/2017 
// Design Name: 
// Module Name:    dmem 
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
module dmem(
	 input clock,
	 input [7:0] address,
	 input we,
	 input [15:0] data,
	 output [15:0] q
    );
    reg [15:0]ram[255:0];
	 assign q = ram[address];
    always @(negedge clock) begin
        if (we)
            ram[address] <= data;
	 end
endmodule
