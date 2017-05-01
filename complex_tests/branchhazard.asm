j     6
store $1, $0, 0
add   $3, $3, $3 # 0x0006
add   $2, $3, $2 # 0x0004
j     9
j     1          # flush
addi  $3, 3      # 0x0003
subi  $2, 2      # 0xfffe
bn    $0, 1
store $2, $0, 2
store $3, $0, 3
halt
