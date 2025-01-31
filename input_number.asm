%macro pushReg 0
    push eax
    push ebx
    push ecx
    push edx
%endmacro

%macro popReg 0
    pop edx
    pop ecx
    pop ebx
    pop eax
%endmacro

%macro print 2    
    push eax
    push ebx
    push ecx
    push edx

    mov eax, 4 
    mov ebx, 1 
    mov ecx, %1 
    mov edx, %2 
    int 0x80 

    
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


%macro scan 2
    pushReg

    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 0x80 

    popReg
%endmacro

%macro ascii_to_int 2
    pushReg
    push esi
    push edi

    mov esi, %1
    mov edi, %2

    xor eax, eax

    %xdefine cnt %[counter]
    inc dword [counter]

    .iterate%[cnt]:
        mov cl, byte [esi]
        cmp cl, 0xa
        je .iterate_end%[cnt]
        cmp cl, 0x0
        je .iterate_end%[cnt]
        cmp cl, '0'
        jl .invalid_input%[cnt]
        cmp cl, '9'
        jg .invalid_input%[cnt]
        
        sub cl, '0'
        mov ebx, 10
        mul ebx
        add eax, ecx
        inc esi
        jmp .iterate%[cnt]
        
    .invalid_input%[cnt]:
        print err_msg, err_msg_len
        print newline, newline_len
        exit 1
    
    .iterate_end%[cnt]:
        add dword [edi], eax
    
        push edi
        push esi
        popReg
%endmacro

%macro int_to_ascii 3
    pushReg
    push esi
    push edi

    ; number %1, buffer %2
    mov edi, %2 + 9
    mov byte [edi], 0
    mov eax, [%1]
    mov ebx, 10

    %xdefine iterator_label iterate%3

    iterator_label:
        xor edx, edx
        div ebx
        add dl, '0'
        dec edi
        mov byte [edi], dl
        test eax, eax
        jnz iterator_label

    mov edx, %2 + 10
    sub edx, edi

    print edi, edx

    pop edi
    pop esi
    popReg

%endmacro

section .data
    msg db "Enter Any Number: "
    msg_len equ $-msg
    err_msg db "You didn't enter valid number."
    err_msg_len equ $-err_msg
    newline db 0xa
    newline_len equ 1

section .bss
    ipbuffer resd 10
    opbuffer resd 10
    op resd 1
    counter resd 1

section .text
    global _start

_start:
    mov dword [op], 0
    mov dword [counter], 0

    print msg, msg_len

    scan ipbuffer, 10
    
    ascii_to_int ipbuffer, op

    add dword [op], 1

    int_to_ascii op, opbuffer, 10

    ; print opbuffer, 10

    ; print op, 1

    print newline, newline_len

    exit 0    



