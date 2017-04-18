addi $1, 60		#0x003c
mov  $2, 60		#0x003c
load $6, $0, 3	#0x2369
load $7, $0, 7	#0x5555
ldih $1, 171	#ab3c
jr   $0, 15
nop
nop
nop
add  $6, $6, $3	#2459
xor  $7, $7, $4	#5403
j    22
nop
nop
nop
sll  $3, $2, 2	#00f0
srl  $4, $1, 7	#0156
sra  $5, $1, 7	#ff56
bn   $0, 9
nop
nop
nop
store $6, $0, 0
store $7, $0, 1
halt
