addi  $1, 9
addi  $2, 9
jump  5          # jump to start
subi  $1, 1      # new round
bz    $7, 18     # jump to end
load  $3, $0, 0  # start
load  $4, $0, 1
cmp   $3, $4
bn    $7, 11     # jump to NO_op
store $3, $0, 1
store $4, $0, 0
addi  $0, 1      # NO_op
cmp   $0, $2
bn    $7, 17     # jump to continue
subi  $2, 1
sub   $0, $0, $0
jump  3          # jump to new round
jump  5          # continue, jump to start
halt
