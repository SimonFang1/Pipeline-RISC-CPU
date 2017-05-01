load  $3, $0, 0  # $3 = 10
subi  $3, 2      # $3 = 8
add   $1, $0, $0
add   $2, $3, $0 # (1)
load  $4, $2, 1  # (2)
load  $5, $2, 2
cmp   $5, $4
bn    $0, 10     # jump to (3)
store $4, $2, 2
store $5, $2, 1
subi  $2, 1      # (3)
cmp   $2, $1
bnn   $0, 4      # jump to (2)
addi  $1, 1
cmp   $3, $1
bnn   $0, 3      # jump to (1)
halt
