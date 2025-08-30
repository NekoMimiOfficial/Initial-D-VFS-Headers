.text
.globl xor_uint32

xor_uint32:
    movl %edi, %eax
    xorl %esi, %eax

    ret 
