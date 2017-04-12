`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:15 04/08/2017 
// Design Name: 
// Module Name:    CPU_Control 
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
`include "header.v"
module CPU_Control(
    input clock,
	 input reset,
	 input start,
	 input enable,
	 output reg state
    );
	 reg next_state;
    always @(posedge clock) begin
        if (!reset)
            state <= `idle;
        else
            state <= next_state;
    end
        
    always @(*) begin
        case (state)
            `idle : 
                if ((enable == 1'b1) 
                && (start == 1'b1))
                    next_state <= `exec;
                else    
                    next_state <= `idle;
            `exec :
                if ((enable == 1'b0) 
                || (wb_ir[15:11] == `HALT))
                    next_state <= `idle;
                else
                    next_state <= `exec;
        endcase
    end

endmodule
