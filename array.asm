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
    array dd 1, 2, 3, 4, 5
    msg db "Printing array element: "
    msg_len equ $-msg
    newline db 0xa
    newline_length equ 1

section .bss
    buffer resb 10 ; used for converting number to ascii

section .text
    global _start

_start:
    mov esi, array ; storing array pointer in esi
    mov eax, 3 ; element index to be printed
    imul eax, 4 ; 4 byte for double word
    add esi, eax ;  offsetting esi stack pointer by our index bytes

    mov eax, [esi] ; loading value of the element where the esi is currently pointing

    print msg, msg_len ; calling print macro to print the message

    mov edi, buffer + 9 ; going to last element
    mov byte [edi], 0 ; adding null character
    mov ebx, 10 ; adding base 10 value as its decimal conversion 

.iterate:
    xor edx, edx ; clearing edx value
    div ebx ; diving eax by ebx
    add dl, '0' ; adding ascii value '0' to the dl (8bit) of edx register
    dec edi ;  decrementing edi register to come a place back
    mov byte [edi], dl ; assigning the ascii value to the edi position
    test eax, eax ; testing ie. anding the eax register without storing value only setting flags
    jnz .iterate ; looping if eax is not zero
    
    ; calculating length of array
    mov edx, buffer + 10 
    sub edx, edi

    print edi, edx

    print newline, newline_length ;  printing new line

    exit 0 ; exiting program with status 0

