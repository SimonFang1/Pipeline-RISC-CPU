addi  $7, 16      # $7 = 0x10
ldih  $1, 182     # $1 = 0xb600
store $1, $7, 0   # str to mem10
load  $1, $0, 0   # $1 = 0xfffd = -3
load  $2, $0, 1   # $2 = 4
addc  $3, $1, $2  # $3 = 1, cf = 1
store $3, $7, 1   # str to mem11
addc  $3, $0, $2  # $3 = 5, cf = 0
store $3, $7, 2   # str to mem12
load  $1, $0, 2   # $1 = 5
subc  $3, $1, $2  # $3 = 1, cf = 0
store $3, $7, 3   # str to mem13
sub   $3, $2, $1  # $3 = -1, cf = 1
store $3, $7, 4   # str to mem14
subc  $3, $2, $1  # $3 = -2, cf = 1
store $3, $7, 5   # str to mem15
load  $1, $0, 3   # $1 = 0xc369
load  $2, $0, 4   # $2 = 0x69c3
and   $3, $1, $2  # $3 = 0x4141
store $3, $7, 6   # str to mem16
or    $3, $1, $2  # $3 = 0xebeb
store $3, $7, 7   # str to mem17
xor   $3, $1, $2  # $3 = 0xaaaa
store $3, $7, 8   # str to mem18
sll   $3, $1, 0   # $3 = 0xc369
store $3, $7, 9   # str to mem19
sll   $3, $1, 1   # $3 = 0x86d2
store $3, $7, 10  # str to mem1a
sll   $3, $1, 4   # $3 = 0x3690
store $3, $7, 11  # str to mem1b
sll   $3, $1, 15  # $3 = 0x8000
store $3, $7, 12  # str to mem1c
srl   $3, $1, 0   # $3 = 0xc369
store $3, $7, 13  # str to mem1d
srl   $3, $1, 1   # $3 = 0x61b4
store $3, $7, 14  # str to mem1e
srl   $3, $1, 8   # $3 = 0x00c3
store $3, $7, 15  # str to mem1f
srl   $3, $1, 15  # $3 = 0x0001
addi  $7, 16      # $7 = 0x20
store $3, $7, 0   # str to mem20
sla   $3, $1, 0   # $3 = 0xc369
store $3, $7, 1   # str to mem21
sla   $3, $1, 1   # $3 = 0x86d2
store $3, $7, 2   # str to mem22
sla   $3, $1, 8   # $3 = 0xe900
store $3, $7, 3   # str to mem23
sla   $3, $1, 15  # $3 = 0x8000
store $3, $7, 4   # str to mem24
sla   $3, $2, 0   # $3 = 0x69c3
store $3, $7, 5   # str to mem25
sla   $3, $2, 1   # $3 = 0x5386
store $3, $7, 6   # str to mem26
sla   $3, $2, 8   # $3 = 0x4300
store $3, $7, 7   # str to mem27
sla   $3, $2, 15  # $3 = 0x0000
store $3, $7, 8   # str to mem28
sra   $3, $1, 0   # $3 = 0xc369
store $3, $7, 9   # str to mem29
sra   $3, $1, 1   # $3 = 0xe1b4
store $3, $7, 10  # str to mem2a
sra   $3, $1, 8   # $3 = 0xffc3
store $3, $7, 11  # str to mem2b
sra   $3, $1, 15  # $3 = 0xffff
store $3, $7, 12  # str to mem2c
sra   $3, $2, 0   # $3 = 0x69c3
store $3, $7, 13  # str to mem2d
sra   $3, $2, 1   # $3 = 0xe1b4
store $3, $7, 14  # str to mem2e
sra   $3, $2, 8   # $3 = 0xffc3
store $3, $7, 15  # str to mem2f
addi  $7, 16      # $7 = 0x30
sra   $3, $2, 15  # $3 = 0xffff
store $3, $7, 0   # str to mem30
load  $1, $0, 5   # $1 = 0x41
load  $2, $0, 6   # $2 = 0xffff
load  $3, $0, 7   # $3 = 0x1
jump  79          # j to 0x4f
store $7, $7, 1   # flush
jmpr  $1, 16      # j to 0x51
store $7, $7, 2   # flush
add   $4, $2, $3  # $4 = 0x0, cf = 1
bnc   $1, 40      # !j to 0x69
bc    $1, 20      # j to 0x55
store $7, $7, 3   # flush
add   $4, $3, $3  # $4 = 0x2, cf = 0
bc    $1, 40      # !j to 0x69
bnc   $1, 24      # j to 0x59
store $7, $7, 4   # flush
cmp   $3, $3      # zf = 1, nf = 0
bnz   $1, 40      # !j to 0x69
bz    $1, 28      # j to 0x5d
store $7, $7, 5   # flush
cmp   $4, $3      # zf = 0, nf = 0
bz    $1, 40      # !j to 0x69
bnz   $1, 32      # j to 0x61
store $7, $7, 6   # flush
cmp   $3, $4      # zf = 0, nf = 1
bnn   $1, 40      # !j to 0x69
bn    $1, 36      # j to 0x65
store $7, $7, 7   # flush
cmp   $4, $3      # zf = 0, nf = 0
bn    $1, 40      # !j to 0x69
bnn   $1, 39      # j to 0x68
store $7, $7, 8   # str to mem38
halt
