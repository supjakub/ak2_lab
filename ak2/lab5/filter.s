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

    mov word [row], 1
    mov word [column], 1
    mov esi, [ebp+8]
    mov edi, [ebp+32]
    mov edx, [ebp+28]

    next_pixel:
    mov cl, 0
    mov bx, [ebp+12]
    cmp bx, [column]
    je next_row
    cmp word [column], 1
    je copy_byte
    cmp word [row], 1
    je copy_byte
    mov bx, [ebp+16]
    cmp word [row], bx
    je copy_byte
    next_byte:
    mov ebx, 0
    mov eax, 0
    sub esi, [ebp+24]
    dec esi
    mov al, [esi]
    imul byte [edx]
    add ebx, eax
    inc esi
    mov al, [esi]
    imul byte [edx+1]
    add ebx, eax
    inc esi
    mov al, [esi]
    imul byte [edx+2]
    add ebx, eax
    add esi, [ebp+24]
    sub esi, 2
    mov al, [esi]
    imul byte [edx+3]
    add ebx, eax
    inc esi
    mov al, [esi]
    imul byte [edx+4]
    add ebx, eax
    inc esi
    mov al, [esi]
    imul byte [edx+5]
    add ebx, eax
    add esi, [ebp+24]
    sub esi, 2
    mov al, [esi]
    imul byte [edx+6]
    inc esi
    mov al, [esi]
    imul byte [edx+7]
    add ebx, eax
    inc esi
    mov al, [esi]
    imul byte [edx+8]
    add ebx, eax
    mov [edi], bl
    sub esi, [ebp+24]
    inc edi
    inc cl
    cmp cl, 3
    jl next_byte
    inc word [column]
    jmp next_pixel

    next_row:
    mov word [column], 0
    inc word [row]
    mov bx, [ebp+16]
    cmp word [row], bx
    jg end
    copy_byte:
    mov al, [esi]
    mov [edi], al
    inc edi
    inc esi
    inc cl
    cmp cl, 3
    jl copy_byte
    inc word [column]
    jmp next_pixel
    end:
    copy_last:
    mov al, [esi]
    mov [edi], al
    inc edi
    inc esi
    inc cl
    cmp cl, [ebp+16]
    jg copy_last

    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
