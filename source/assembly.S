.section .note.GNU-stack,"",@progbits
.text
.globl xor_uint32
.globl sqrt_fast
.globl asm_crc
.globl asm_sha256

xor_uint32:
    movl %edi, %eax
    xorl %esi, %eax

    ret

sqrt_fast:
    call sqrt@PLT

    ret

asm_crc:
    movl %esi, %eax

loop_start:
    cmpb $0, (%rdx)
    je loop_end
    crc32b (%rdx), %eax
    incq %rdx
    
    jmp loop_start

loop_end:
    ret

asm_sha256:
    sha256rnds2 $0, %xmm0, %xmm1
    
    movdqu (%rsi), %xmm2
    movdqu 16(%rsi), %xmm3
    movdqu 32(%rsi), %xmm4
    movdqu 48(%rsi), %xmm5

    sha256rnds2 $0, %xmm0, %xmm2
    sha256rnds2 $0, %xmm1, %xmm3
    sha256rnds2 $0, %xmm0, %xmm4
    sha256rnds2 $0, %xmm1, %xmm5
    
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    
    ret
