#include <iostream>
#include <string>
#include <sstream>
using namespace std;

#include "opcode.h"
#define DOLLAR ch
#define COMMA ch
#define R1 r1
#define R2 r2
#define R3 r3
#define VAL2 val2
#define VAL3 val3
#define IMDT immediate
#include "expression.h"

string getBin(int n, int bits) {
	string bin;
	for (int i = 0; i < bits; i++) {
		bin += n & (1 << i) ? '1': '0';
	}
	return bin;
}

int main() {
	string asmbl, op, machineCode;
	stringstream ss;
	char ch;
	int r1, r2, r3;
	int val2, val3, immediate;
	int line = 0;
	while (getline(cin, asmbl)) {
		ss << asmbl;
		ss >> op;
		if (op == "nop") {
			machineCode = NOP + getBin(0, 11);
		} else if (op == "halt") {
			machineCode = HALT + getBin(0, 11);
		} else if (op == "load") {
			ss >> R1_R2_V3;
			machineCode = LOAD + getBin(r1, 3) + getBin(r2, 4) + getBin(val3, 4);
		} else if (op == "store") {
			ss >> R1_R2_V3;
			machineCode = STORE + getBin(r1, 3) + getBin(r2, 4) + getBin(val3, 4);
		} else if (op == "ldih") {
			ss >> R1_IM;
			machineCode = LDIH + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "mov" || op == "ldi") {
			ss >> R1_IM;
			machineCode = MOV + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "add") {
			ss >> R1_R2_R3;
			machineCode = ADD + getBin(r1, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "addi") {
			ss >> R1_IM;
			machineCode = ADDI + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "addc") {
			ss >> R1_R2_R3;
			machineCode = ADDC + getBin(r1, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "sub") {
			ss >> R1_R2_R3;
			machineCode = ADD + getBin(r1, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "subi") {
			ss >> R1_IM;
			machineCode = SUBI + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "subc") {
			ss >> R1_R2_R3;
			machineCode = SUBC + getBin(r1, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "cmp") {
			ss >> R2_R3;
			machineCode = CMP + getBin(0, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "and") {
			ss >> R1_R2_R3;
			machineCode = AND + getBin(r1, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "or") {
			ss >> R1_R2_R3;
			machineCode = OR + getBin(r1, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "xor") {
			ss >> R1_R2_R3;
			machineCode = XOR + getBin(r1, 3) + getBin(r2, 4) + getBin(r3, 4);
		} else if (op == "not") {
			ss >> R1_R2;
			machineCode = NOT + getBin(r1, 3) + getBin(r2, 4) + getBin(0, 4);
		} else if (op == "sl" || op == "sll" || op == "sla") {
			ss >> R1_R2_V3;
			machineCode = SL + getBin(r1, 3) + getBin(r2, 4) + getBin(val3, 4);
		} else if (op == "srl") {
			ss >> R1_R2_V3;
			machineCode = SRL + getBin(r1, 3) + getBin(r2, 4) + getBin(val3, 4);
		} else if (op == "sra") {
			ss >> R1_R2_V3;
			machineCode = SRA + getBin(r1, 3) + getBin(r2, 4) + getBin(val3, 4);
		} else if (op == "jump" || op == "j") {
			ss >> immediate;
			machineCode = JUMP + getBin(0, 3) + getBin(immediate, 8);
		} else if (op == "jmpr" || op == "jr") {
			ss >> R1_IM;
			machineCode = JMPR + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "bz") {
			ss >> R1_IM;
			machineCode = BZ + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "bnz") {
			ss >> R1_IM;
			machineCode = BZ + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "bz") {
			ss >> R1_IM;
			machineCode = BNZ + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "bn") {
			ss >> R1_IM;
			machineCode = BN + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "bnn") {
			ss >> R1_IM;
			machineCode = BNN + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "bc") {
			ss >> R1_IM;
			machineCode = BC + getBin(r1, 3) + getBin(immediate, 8);
		} else if (op == "bnc") {
			ss >> R1_IM;
			machineCode = BNC + getBin(r1, 3) + getBin(immediate, 8);
		} else {
			cerr << line + 1 << ": unknown instruction \"" << asmbl << "\""<< endl;
			machineCode = NOP + getBin(0, 16-5);
		}
		cout << machineCode << endl;
		line++;
		ss.clear();
		ss.str("");
	}
	return 0;
}
