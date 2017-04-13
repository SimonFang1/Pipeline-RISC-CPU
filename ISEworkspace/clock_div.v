`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:43:42 03/13/2017 
// Design Name: 
// Module Name:    clock_div 
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
module clock_div(
    input clock,
	 input reset,
	 input [31:0] div_ratio,
	 output reg clk_div
    );

reg [31:0] count;

initial begin
    clk_div = 0;
    count = 0;
end
 
always @ (posedge clock or posedge reset)
begin
    if (reset == 1'b1)
        count <= 32'b0;
    else if (count == div_ratio - 1)
        count <= 32'b0;
    else
        count <= count + 1;
end

always @ (posedge clock or posedge reset)
begin
    if (reset == 1'b1)
        clk_div <= 1'b0;
    else if (count == div_ratio - 1)
        clk_div <= ~clk_div;
    else
        clk_div <= clk_div;
end

endmodule
