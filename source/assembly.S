.section .note.GNU-stack,"",@progbits
.text
.globl xor_uint32
.globl sqrt_fast
.globl asm_crc
.globl asm_sha256
.globl asm_aes

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
    lea sha256_initial_values_data(%rip), %rcx
    
    movdqu (%rcx), %xmm0
    movdqu 16(%rcx), %xmm1
    
    movdqu (%rsi), %xmm2
    movdqu 16(%rsi), %xmm3
    movdqu 32(%rsi), %xmm4
    movdqu 48(%rsi), %xmm5
    
    sha256rnds2 %xmm2, %xmm0
    sha256rnds2 %xmm3, %xmm1
    sha256rnds2 %xmm4, %xmm0
    sha256rnds2 %xmm5, %xmm1
    
    movdqu %xmm0, (%rdi)
    movdqu %xmm1, 16(%rdi)
    
    ret

asm_aes:
    movdqu (%rsi), %xmm0

    movdqu (%rdx), %xmm1

    pxor %xmm1, %xmm0
    
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0
    aesenc %xmm1, %xmm0

    aesenclast %xmm1, %xmm0

    movdqu %xmm0, (%rdi)
    
    ret

.section .rodata
.align 16
sha256_initial_values_data:
    .long 0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
