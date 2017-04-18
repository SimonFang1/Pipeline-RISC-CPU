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

// this module is used for simulation test only
// IP CORE d_mem is used for for synthesize
module dmem(
	 input clock,
	 input [7:0] address,
	 input we,
	 input [15:0] data,
	 output [15:0] q
    );
    reg [15:0] ram[0:255];
	 assign q = ram[address];
    always @(posedge clock) begin
        if (we)
            ram[address] <= data;
	 end
	 initial begin
	     $readmemb("ipcore_dir/d_mem.mif", ram);
	 end
endmodule
