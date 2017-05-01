#ifndef __ASM_HEADER_H__
#define __ASM_HEADER_H__

#define NOP 	"00000"
#define HALT	"00001"
#define LOAD	"00010"
#define STORE	"00011"
#define LDIH	"10000"
#define MOV		"10100"
#define ADD		"01000"
#define ADDI	"01001"
#define ADDC	"10001"
#define SUB		"01010"
#define SUBI	"01011"
#define SUBC	"10010"
#define CMP		"01100"

#define AND 	"01101"
#define OR		"01110"
#define XOR		"01111"
#define NOT		"10011"
#define SL		"00100"
#define SLL		"00100"
#define SRL		"00101"
#define SLA		"00110"
#define SRA		"00111"

#define JUMP	"11000"
#define	JMPR	"11001"
#define BZ		"11010"
#define BNZ		"11011"
#define BN		"11100"
#define BNN		"11101"
#define BC		"11110"
#define BNC		"11111"

#endif
