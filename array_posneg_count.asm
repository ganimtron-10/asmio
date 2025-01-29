; Write X86/64 ALP to count number of positive and negative numbers from the array.

; Macros

; push reg
%macro pushReg 0
    push eax
    push ebx
    push ecx
    push edx
%endmacro

; pop reg
%macro popReg 0
    pop edx
    pop ecx
    pop ebx
    pop eax
%endmacro

; print
%macro print 2
    
    pushReg

    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80

    popReg

%endmacro

; printNumber
%macro printNumber 3

    pushReg
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

    mov edx, buffer + 10
    sub edx, edi

    print edi, edx

    pop edi
    popReg

%endmacro


; exit
%macro exit 1
    mov eax, 1
    mov ebx, %1
    int 0x80
%endmacro


section .text
    pos_cnt_msg db "Positive Elements Count: "
    pos_cnt_msg_len equ $-pos_cnt_msg

    neg_cnt_msg db "Negeative Elements Count: "
    neg_cnt_msg_len equ $-neg_cnt_msg

    newline db 0xa
    newline_len equ 1

    array dd -1, 10, -9, 0, 11, 35, -88, 90
    array_size equ $-array
    ele_size equ 4
    array_len equ array_size/ele_size

section .bss
    buffer resb 10
    pos_cnt resd 1
    neg_cnt resd 1


section .data
    global _start

_start:

    mov dword [pos_cnt], 0
    mov dword [neg_cnt], 0

    ; loop over individual array element
    mov esi, array
    mov ecx, array_len

    .iterate_array:
        cmp ecx, 0
        je .print_result

        ; check if pos or neg
        cmp dword [esi], 0
        jg .pos_num
        jl .neg_num
    
    .next_ele:
        add esi, ele_size
        dec ecx
        jmp .iterate_array

    ; increment count accordingly
    .pos_num:
        inc dword [pos_cnt]
        jmp .next_ele
    
    .neg_num:
        inc dword [neg_cnt]
        jmp .next_ele
    
    ; print
    .print_result:
        print pos_cnt_msg, pos_cnt_msg_len
        printNumber pos_cnt, buffer, 1
        print newline, newline_len

        print neg_cnt_msg, neg_cnt_msg_len
        printNumber neg_cnt, buffer, 2
        print newline, newline_len

        exit 0