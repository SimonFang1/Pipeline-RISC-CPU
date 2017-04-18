#include <iostream>
#include <cstdlib>
using namespace std;

int main(int argc, char const *argv[]) {
	int radix;
	if (argc < 2)
		radix = 2;
	else
		radix = atoi(argv[1]);
	cout << "MEMORY_INITIALIZATION_RADIX=" << radix << ";\n"
		 << "MEMORY_INITIALIZATION_VECTOR="<< '\n';
	string line;
	getline(cin, line);
	cout << line;
	while (getline(cin, line))
		cout << ",\n" << line;
	cout << ';' << endl;
	return 0;
}
