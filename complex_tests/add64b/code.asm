addi  $4, 4
load  $1, $0, 0  # (1)
load  $2, $0, 4
add   $3, $1, $2
bnc   $5, 6      # jump to (2)
addi  $6, 1      # carry
add   $3, $3, $7 # (2)
bnc   $5, 11     # jump to (3)
subi  $6, 0      #
bnz   $5, 11     # jump to (3)
addi  $6, 1      #
sub   $7, $7, $7 # (3)
add   $7, $7, $6 #
sub   $6, $6, $6 #
store $3, $0, 8  #
addi  $0, 1      #
cmp   $0, $4     #
bn    $5, 1      # jump to (1)
halt
