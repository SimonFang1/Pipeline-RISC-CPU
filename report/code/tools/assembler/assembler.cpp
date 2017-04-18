#include <iostream>
#include <string>
#include <sstream>
using namespace std;

#define INIT_ALL_MEM
#ifdef INIT_ALL_MEM
#define TOTAL_DEPTH 256
#endif

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
	for (int i = bits - 1; i >= 0; i--) {
		bin += (n & (1 << i)) ? '1': '0';
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
		}else if (op == "load") {
			ss >> R1_R2_V3;
			machineCode = LOAD + getBin(r1, 3) + getBin(r2, 4) + getBin(val3, 4);
		} else if (op == "mov" || op == "ldi") {
			ss >> R1_IM;
			machineCode = MOV + getBin(r1, 3) + getBin(immediate, 8);
		}
		... // other instructions
		else {
			cerr << line + 1 << ": unknown instruction \"" << asmbl << "\""<< endl;
			machineCode = NOP + getBin(0, 11);
		}
		cout << machineCode << endl;
		line++;
		ss.clear();
		ss.str("");
	}
#ifdef INIT_ALL_MEM
	int rest = TOTAL_DEPTH - line;
	string reset = getBin(0, 16) + '\n';
	while (rest--) {
		cout << reset;
	}
	cout << flush;
#endif
	return 0;
}
