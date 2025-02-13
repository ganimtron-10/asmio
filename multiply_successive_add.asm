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
    pushReg

    mov eax, 4 
    mov ebx, 1 
    mov ecx, %1 
    mov edx, %2 
    int 0x80 
    
    popReg
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

%macro int_to_ascii 3 
    pushReg
    push esi
    push edi

    mov eax, %1 
    mov edi, %2 + 15  
    mov byte [edi], 0 

    %xdefine iterator_label iterate%3

    iterator_label:
        xor edx, edx
        mov ebx, 10
        div ebx
        add dl, '0'
        dec edi
        mov byte [edi], dl
        test eax, eax
        jnz iterator_label

    
    mov esi, %2 + 15 
    sub esi, edi
    mov edx, esi 

    print edi, edx

    pop edi
    pop esi
    popReg

%endmacro

section .data
    a dw 9
    b dw 10

section .bss
    buffer resb 16

section .text
    global _start

_start:
    xor eax, eax
    mov ecx, [b]

add_a:
    add al, [a]
    loop add_a

    int_to_ascii eax, buffer, 1

    exit 0