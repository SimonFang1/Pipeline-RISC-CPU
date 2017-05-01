ldih  $1, 190    # $1 = 0xbe00
addi  $1, 239    # $1 = 0xbeef
halt
srl   $1, 1      # gr and mem
store $1, $0, 0  # cannot be 
store $1, $0, 1  # written
store $1, $0, 2  # after halt
store $1, $0, 3  # instruction.
