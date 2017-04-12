`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:16:07 03/05/2017 
// Design Name: 
// Module Name:    seven_seg 
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
module seven_seg(
    input [3:0] x,
    output [6:0] y
    );
	 
	 assign y[0] = x == 4'h0 | x == 4'h2 | x == 4'h3 | x == 4'h5 | x == 4'h6 |
					   x == 4'h7 | x == 4'h8 | x == 4'h9 | x == 4'ha | x == 4'hc |
						x == 4'he | x == 4'hf;
	 assign y[1] = x == 4'h0 | x == 4'h1 | x == 4'h2 | x == 4'h3 | x == 4'h4 |
						x == 4'h7 | x == 4'h8 | x == 4'h9 | x == 4'ha | x == 4'hd;
	 assign y[2] = x == 4'h0 | x == 4'h1 | x == 4'h3 | x == 4'h4 | x == 4'h5 | 
						x == 4'h6 | x == 4'h7 | x == 4'h8 | x == 4'h9 | x == 4'ha |
						x == 4'hb | x == 4'hd;
	 assign y[3] = x == 4'h0 | x == 4'h2 | x == 4'h3 | x == 4'h5 | x == 4'h6 |
						x == 4'h8 | x == 4'h9 | x == 4'hb | x == 4'hc | x == 4'hd |
						x == 4'he;
	 assign y[4] = x == 4'h0 | x == 4'h2 | x == 4'h6 | x == 4'h8 | x == 4'ha |
						x == 4'hb | x == 4'hc | x == 4'hd | x == 4'he | x == 4'hf;
	 assign y[5] = x == 4'h0 | x == 4'h4 | x == 4'h5 | x == 4'h6 | x == 4'h8 |
						x == 4'h9 | x == 4'ha | x == 4'hb | x == 4'hc | x == 4'he |
						x == 4'hf;
	 assign y[6] = x == 4'h2 | x == 4'h3 | x == 4'h4 | x == 4'h5 | x == 4'h6 |
						x == 4'h8 | x == 4'h9 | x == 4'ha | x == 4'hb | x == 4'hd |
						x == 4'he | x == 4'hf;

endmodule
