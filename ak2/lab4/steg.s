global code, decode

section .text

code:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ;Poczatek pikseli
    push ebx
    mov ebx, [ebp+12] ;Poczatek tekstu

    mov cl, 0
    loop_code:
    mov dl, [ebx] ;Bajt litery
    mov dh, [eax] ;Bajt pixela
    shr dh, 2
    shl dh, 2
    shl dl, cl
    shr dl, 6
    add dh, dl
    mov [eax], dh
    add cl, 2
    inc eax
    cmp cl, 8
    jl loop_code
    mov cl, 0
    inc ebx
    cmp byte [ebx], 10
    jne loop_code

    little_loop_code:
    mov dl, 0
    mov dh, [eax]
    shr dh, 2
    shl dh, 2
    shl dl, cl
    shr dl, 6
    add dh, dl
    mov [eax], dh
    add cl, 2
    inc eax
    cmp cl, 8
    jne little_loop_code

    pop ebx
    pop ebp
    ret

decode:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ;Pixele
    push ebx
    mov ebx, [ebp+12] ;Wynik

    outer_loop_decode:
    mov cl, 0
    mov dh, 0
    inner_loop_decode:
    mov dl, [eax]
    shl dl, 6
    shr dl, 6
    add dh, dl
    cmp cl, 3
    je no_shift
    shl dh, 2
    no_shift:
    inc cl
    inc eax
    cmp cl, 4
    jl inner_loop_decode
    mov [ebx], dh
    inc ebx
    cmp dh, 0
    jne outer_loop_decode

    pop ebx
    pop ebp
    ret
