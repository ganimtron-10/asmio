; program to print an element at index 3 from the array


%macro print 2

    ; pushing register to stack, to retrieve thing back after printing
    push eax
    push ebx
    push ecx
    push edx

    mov eax, 4 ; syscall number for write
    mov ebx, 1 ; file descriptor (stdout)
    mov ecx, %1 ; first arg ie. msg
    mov edx, %2 ; second arg ie msg len
    int 0x80 

    ; retrieving register values
    pop edx
    pop ecx
    pop ebx
    pop eax
%endmacro

%macro exit 1
    mov eax, 1
    mov ebx, %1
    int 0x80 
%endmacro


section .data
    msg db "Enter anything: "
    msg_len equ $-msg
    newline db 0xa
    newline_length equ 1

section .bss
    buffer resb 10

section .text
    global _start

_start:
    print msg, msg_len

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    print buffer, 10
    print newline, newline_length

    exit 0    

