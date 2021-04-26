global _start

section .data
    msg1 db "Podaj mnozna: "
    msg2 db "Podaj mnoznik: "
    msg_bad_input db "Nieprawidlowe dane", 0xa

section .bss
    ascii1: resb 200
    ascii2: resb 200
    number1: resb 100
    len1: resb 1
    number2: resb 100
    len2: resb 1
    result: resb 400

section .text

_start:
    ;Wczytywanie pierwszej liczby
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 14
    int 80h
    mov eax, 3
    mov ebx, 1
    mov ecx, ascii1
    mov edx, 200
    int 80h

    ;Wczytywanie drugiej liczby
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 15
    int 80h
    mov eax, 3
    mov ebx, 1
    mov ecx, ascii2
    mov edx, 200
    int 80h

    lea esi, [ascii1]
    lea edi, [number1]
    call ascii_to_hex
    mov [len1], cl
    lea esi, [ascii2]
    lea edi, [number2]
    call ascii_to_hex
    mov [len2], cl

    call multi

    ;Wyjscie z programu
    mov eax, 1
    int 80h

ascii_to_hex:
    xor cl, cl
    next_byte:
    mov al, byte [esi]
    cmp al, 10
    je end
    inc cl
    cmp al, 48
    jl bad_input
    cmp al, 57
    jg upper_case
    ;zamiana cyfr
    sub al, 30h
    inc esi
    jmp next_digit
    upper_case:
    cmp al, 65
    jl bad_input
    cmp al, 70
    jg lower_case
    ;zamiana A-F
    sub al, 37h
    inc esi
    jmp next_digit
    lower_case:
    cmp al, 97h
    jl bad_input
    cmp al, 102
    jg bad_input
    ;zamiana a-f
    sub al, 57h
    inc esi

    next_digit:
    mov bl, byte [esi]
    cmp bl, 10
    jne hex_to_ascii_continue
    mov [edi], al
    jmp end
    hex_to_ascii_continue:
    cmp bl, 48
    jl bad_input
    cmp bl, 57
    jg upper_case2
    ;zamiana cyfr
    sub bl, 30h  
    shl al, 4  
    add al, bl
    mov [edi], al
    inc edi
    inc esi
    jmp next_byte
    upper_case2:
    cmp bl, 65
    jl bad_input
    cmp bl, 70
    jg lower_case2
    ;zamiana A-F
    sub bl, 37h
    shl al, 4
    add al, bl
    mov [edi], al
    inc edi
    inc esi
    jmp next_byte
    lower_case2:
    cmp bl, 97h
    jl bad_input
    cmp bl, 102
    jg bad_input
    ;zamiana a-f
    sub bl, 57h
    shl al, 4
    add al, bl
    mov [edi], al
    inc edi
    inc esi
    jmp next_byte

    end:
    ret

    bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_bad_input
    mov edx, 19
    int 80h
    mov eax, 1
    int 80h

multi:
    xor eax, eax
    lea esi, [number1]
    mov al, [len1]
    dec al
    add esi, eax

    xor ebx, ebx
    lea edi, [number2]
    mov bl, [len2]
    dec bl
    add edi, ebx

    xor ch, ch
    xor cl, cl

    out_loop:
    cmp ch, [len1]
    jnl end_multi
    mov bl, [edi]
    push esi
    in_loop:
    lea edx, [result]
    mov al, [esi]
    mul bl
    add dl, cl
    add dl, ch
    clc
    add [edx], al
    inc edx
    adc [edx], ah
    check_carry:
    jnc no_carry
    inc edx
    adc [edx], byte 1
    jmp check_carry
    no_carry:
    inc cl
    dec esi
    cmp cl, [len2]
    jl in_loop
    dec edi
    pop esi
    xor cl, cl
    inc ch
    jmp out_loop

    end_multi:
    ret

    
