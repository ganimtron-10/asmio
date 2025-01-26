section .data
    msg db "Hello, World!", 0xa
    len equ $-msg

section .text
    global _start

_start:
    ; align stck pointer (crucial for 64-bit and PIE)
    push rbp        ; Save current rbp
    mov rbp, rsp    ; Set RBP to current RSP
    and rsp, 0xfffffffffffffff0 ; Align RSP to 16 bytes

    ; writing (64-bit syscall)
    mov rax, 1      ; syscall number for write
    mov rdi, 1      ; file descriptor 1 (stdout)
    mov rsi, msg    ; pointer to the message
    mov rdx, len    ; message length
    syscall         

    ; exiting (64-bit syscall)
    mov rax, 60     ; syscall number for exit
    xor rdi, rdi    ; exit code 0
    syscall         

    ; Restore stack pointer
    mov rsp, rbp
    pop rbp

    