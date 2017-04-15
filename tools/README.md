# assembler
## compile 
g++ assembler/assembler.cpp -o assembler -O3
## execute
assembler < code.asm > inst.txt

# coe_generator
## compile
g++ coe_generator/gcoe.cpp -o gcoe -O3
## execute
gcoe < inst.txt > init.coe    \# or

gcoe 2 < inst.txt > init.coe \# for binary data


gcoe 10 < inst.txt > init.coe \# for decimal data