`ifndef __HEADER_V__
`define __HEADER_V__

// CPU state
`define idle		1'b0
`define exec		1'b1
	
// operation code
//Data transfer & Arithmetic
`define NOP			5'b00000
`define HALT		5'b00001
`define LOAD		5'b00010
`define STORE		5'b00011
`define LDIH		5'b10000
`define MOV			5'b10100  // *
`define ADD			5'b01000
`define ADDI		5'b01001
`define ADDC		5'b10001
`define SUB			5'b01010  // *
`define SUBI		5'b01011  // *
`define SUBC		5'b10010  // *
`define CMP			5'b01100
//Logical / shift
`define AND			5'b01101
`define OR			5'b01110  // *
`define XOR			5'b01111  // *
`define NOT			5'b10011  // * bitwise inverse
`define SL			5'b00100
`define SLL			5'b00100  // pseudo-instruction
`define SRL			5'b00101  // *
`define SLA			5'b00100  // pseudo-instruction
`define SRA			5'b00111  // *
//Control
`define JUMP		5'b11000
`define JMPR		5'b11001
`define BZ			5'b11010
`define BNZ			5'b11011
`define BN			5'b11100
`define BNN			5'b11101  // *
`define BC			5'b11110
`define BNC			5'b11111  // *


// ALU operations
`define A_OR		4'b0000
`define A_AND		4'b0001
`define A_NOT		4'b0010
`define A_XOR		4'b0011
`define A_ADD		4'b0100
`define A_ADDPLS	4'b0101
`define A_SUB		4'b0110
`define A_SUBMNS	4'b0111
`define A_SL		4'b1000
`define A_SRL		4'b1001
`define A_SRA		4'b1010

//instruction segment
`define I_OP		15:11
`define I_R1		10:8
`define I_R2		6:4
`define I_R3		2:0
`define I_VAL2		7:4
`define I_VAL3		3:0
`define I_IMDT		7:0

// parse
`define P_NULL	 3'b000
`define P_VAL2  3'b010
`define P_VAL3  3'b001
`define P_IMDT  3'b011
`define P_HIMDT 3'b111

//gr
`define gr0 3'b000
`define gr1 3'b001
`define gr2 3'b010
`define gr3 3'b011
`define gr4 3'b100
`define gr5 3'b101
`define gr6 3'b110
`define gr7 3'b111



////alias
//`define CF			flags[0]
//`define ZF			flags[1]
//`define NF			flags[2]

`endif
