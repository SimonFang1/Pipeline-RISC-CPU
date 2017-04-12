mov $0, 123
mov $1, 456
sub $3, $1, $0
nop
or $2, $3, $1
nop
and $4, $2, $1
nop
j 12
nop
addi $4, 12
nop
sl $5, $4, 2
halt