%include "macros.asm"

section .data
    a db 9
    b db 10

section .bss
    buffer resb 16

section .text
    global _start

_start:
    mov al, [a]
    mov bl, [b]
    xor dl, dl

iterate:
    test bl, 1
    jz skip

    add dl, al

skip:
    shl al, 1

    shr bl, 1

    cmp bl, 0
    jne iterate

    movzx edx, dl

    int_to_ascii edx, buffer, 1
    
    exit 0