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
    inc esi
    inc ecx
    cmp ecx, [ebp+24]
    jl first_row

    mov word [row], 2
    next_row:
    mov ecx, 0
    next_byte_left:
    mov byte [edi], 255
    inc edi
    inc esi
    inc ecx
    cmp ecx, [ebp+20]
    jl next_byte_left

    mov word [column], 2
    next_pixel:
    mov ecx, 0
    next_byte:

    mov eax, 0
    mov ebx, 0
    sub esi, [ebp+24]
    sub esi, [ebp+20]
    mov al, [esi]
    imul byte [edx]
    add ebx, eax

    mov eax, 0
    add esi, [ebp+20]
    mov al, [esi]
    imul byte [edx+1]
    add ebx, eax

    mov eax, 0
    add esi, [ebp+20]
    mov al, [esi]
    imul byte [edx+2]
    add ebx, eax

    mov eax, 0
    add esi, [ebp+24]
    mov al, [esi]
    imul byte [edx+5]
    add ebx, eax

    mov eax, 0
    sub esi, [ebp+20]
    mov al, [esi]
    imul byte [edx+4]
    add ebx, eax

    mov eax, 0
    sub esi, [ebp+20]
    mov al, [esi]
    imul byte [edx+3]
    add ebx, eax

    mov eax, 0
    add esi, [ebp+24]
    mov al, [esi]
    imul byte [edx+6]
    add ebx, eax

    mov eax, 0
    add esi, [ebp+20]
    mov al, [esi]
    imul byte [edx+7]
    add ebx, eax

    mov eax, 0
    add esi, [ebp+20]
    mov al, [esi]
    imul byte [edx+8]
    add ebx, eax

    sub esi, [ebp+24]
    sub esi, [ebp+20]

    mov eax, ebx
    mov ebx, 0
    add bl, [edx]
    add bl, [edx+1]
    add bl, [edx+2]
    add bl, [edx+3]
    add bl, [edx+4]
    add bl, [edx+5]
    add bl, [edx+6]
    add bl, [edx+7]
    add bl, [edx+8]
    cmp bl, 0
    je no_div
    idiv bl
    no_div:

    mov byte [edi], al
    inc edi
    inc esi
    inc ecx
    cmp ecx, [ebp+20]
    jl next_byte
    inc word [column]
    mov cx, [ebp+12]
    cmp [column], cx
    jl next_pixel

    mov ecx, 0
    next_byte_right:
    mov byte [edi], 255
    inc edi
    inc esi
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
    inc esi
    inc ecx
    cmp ecx, [ebp+24]
    jl last_row

    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
