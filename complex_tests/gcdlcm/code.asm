load  $1, $0, 1  # $1 = 0x0020
load  $2, $0, 2  # $2 = 0x0018
add   $3, $0, $1 # (1)
sub   $1, $1, $2 # 
bz    $0, 9      # jump to (2)
bnn   $0, 2      # jump to (1)
add   $1, $0, $2
add   $2, $0, $3
jump  2          # jump to (1)
store $2, $0, 3  # (2)
load  $1, $0, 1
load  $2, $0, 2
addi  $4, 1      # (3)
sub   $2, $2, $3
bz    $0, 16     # jump to (4)
jump  12         # jump to (3)
subi  $4, 1      # (4)
bn    $0, 20     # jump to (5)
add   $5, $5, $1
jump  16         # jump to (4)
store $5, $0, 4  # (5)
load  $1, $0, 3  # gcd
load  $2, $0, 4  # lcm
halt
