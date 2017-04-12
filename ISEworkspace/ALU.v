`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:00 04/08/2017 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [3:0] opcode,
	 input [15:0] operandA,
	 input [15:0] operandB,
//	 input [2:0] lastFlags,
	 output reg [15:0] ALUo,
	 output reg [2:0] flags
    );
	 
//	 `define LCF	lastFlags[0]
//	 `define LZF	lastFlags[1]
//	 `define LNF	lastFlags[2]
	 `define CF		flags[0]
	 `define ZF		flags[1]
	 `define NF		flags[2]
	 
	 reg ex;
	 
    always @(opcode or operandA or operandB) begin
	     case(opcode)
		      `A_AND: ALUo = operandA & operandB;
				`A_OR: ALUo = operandA | operandB;
				`A_NOT: ALUo = ~operandA;
				`A_XOR: ALUo = operandA ^ operandB;
				`A_ADD: {`CF, ALUo} = operandA + operandB;
				`A_ADDPLS: {`CF, ALUo} = operandA + operandB + 16'd1;
				`A_SUB: begin
				            {ex, ALUo} = {1'b1, operandA} - {1'b0, operandB};
								`CF = ~ex;
						  end
				`A_SUBMNS: begin
				               {ex, ALUo} = {1'b1, operandA} - {1'b0, operandB} - 17'd1;
								   `CF = ~ex;
							  end
				`A_SL: ALUo = operandA << operandB[3:0];
				`A_SRL: ALUo = operandA >> operandB[3:0];
				`A_SRA: ALUo = $signed(operandA) >>> operandB[3:0];
				default: ALUo = operandA & operandB;
		  endcase
	 end
	 
	 always @(ALUo) begin
	     `NF = ALUo[15];
		  `ZF = ALUo == 16'd0;
	 end

endmodule
