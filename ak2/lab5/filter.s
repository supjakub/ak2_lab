global filter

section .bss
    row: resw 1
    column: resw 1

section .text

filter:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    mov edx, [ebp+28]
    mov esi, [ebp+8]
    mov edi, [ebp+32]

    mov ecx, 0
    first_row:
    mov byte [edi], 255
    inc edi
    inc ecx
    cmp ecx, [ebp+24]
    jl first_row

    mov word [row], 2
    next_row:
    mov ecx, 0
    next_byte_left:
    mov byte [edi], 255
    inc edi
    inc ecx
    cmp ecx, [ebp+20]
    jl next_byte_left

    mov ecx, 6
    next_byte:
    mov byte [edi], 0
    inc edi
    inc ecx
    cmp ecx, [ebp+24]
    jl next_byte

    mov ecx, 0
    next_byte_right:
    mov byte [edi], 255
    inc edi
    inc ecx
    cmp ecx, [ebp+20]
    jl next_byte_right

    inc word [row]
    mov cx, [row]
    cmp cx, [ebp+16]
    jl next_row

    mov ecx, 0
    last_row:
    mov byte [edi], 255
    inc edi
    inc ecx
    cmp ecx, [ebp+24]
    jl last_row

    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
