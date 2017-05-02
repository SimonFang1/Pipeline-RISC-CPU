load  $1, $0, 3  #0x2369 
srl   $1, $1, 12 #0x0002
load  $3, $0, 4  #0x69c3
store $3, $0, 0  
load  $2, $0, 1  #0x0004
nop
sub   $2, $2, $1 #0x0002
load  $1, $0, 5  #0x0060
store $1, $2, 0
halt
