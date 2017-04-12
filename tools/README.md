## assembler
# compile 
cd assembler
g++ assembler.cpp -o assembler -O3
# execute
assembler < code.asm > inst.txt

## coe_generator
# compile
cd coe_generator
g++ gcoe.cpp -o gcoe -O3
#execute
gcoe < inst.txt > init.coe    \# or
gcoe 10 < inst.txt > init.coe \# for decimal data

gcoe 2 < inst.txt > init.coe \# for binary data