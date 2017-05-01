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
	output reg [15:0] ALUo,
	output reg [2:0] flags
);
	`define CF		flags[0]
	`define ZF		flags[1]
	`define NF		flags[2]
	always @(opcode or operandA or operandB) begin
		case(opcode)
			`A_AND: begin ALUo = operandA & operandB; `CF = 0; end
			`A_OR: begin ALUo = operandA | operandB; `CF = 0; end
			`A_NOT: begin ALUo = ~operandA; `CF= 0; end
			`A_XOR: begin ALUo = operandA ^ operandB; `CF = 0; end
			`A_ADD: {`CF, ALUo} = operandA + operandB;
			`A_ADDPLS: {`CF, ALUo} = operandA + operandB + 1'b1;
			`A_SUB: {`CF, ALUo} = operandA - operandB;
			`A_SUBMNS: {`CF, ALUo} = operandA - operandB - 1'b1;
			`A_SLL: begin ALUo = operandA << operandB[4:0]; `CF = 0; end
			`A_SLA: begin ALUo = {operandA[15], operandA[14:0] <<< operandB[3:0]}; `CF = 0; end
			`A_SRL: begin ALUo = operandA >> operandB[4:0]; `CF = 0; end
			`A_SRA: begin ALUo = $signed(operandA) >>> operandB[4:0]; `CF = 0; end
			default: begin ALUo = operandA & operandB; `CF = 0; end
		endcase
	end
	always @(ALUo) begin
		`NF = ALUo[15];
		`ZF = ALUo == 16'd0;
	end
endmodule
