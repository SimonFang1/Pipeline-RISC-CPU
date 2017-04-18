#include <iostream>
#include <string>
using namespace std;

#define TOTAL_MEM 256

int mem[TOTAL_MEM]; // global data will be set to zero

string getBin(int n, int bits) {
	string bin;
	for (int i = bits - 1; i >= 0; i--) {
		bin += (n & (1 << i)) ? '1': '0';
	}
	return bin;
}

int main() {
	int addr, data;
	while (cin >> hex >> addr >> data) {
		mem[addr] = data;
	}
	for (int i = 0; i < TOTAL_MEM; i++) {
		cout << getBin(mem[i], 16) << '\n';
	}
	cout << flush;
	return 0;
}
