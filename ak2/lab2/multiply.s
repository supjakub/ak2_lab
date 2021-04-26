global _start

section .data
    msg1 db "Podaj mnozna: "
    msg2 db "Podaj mnoznik: "
    msg3 db "Wynik: "
    msg_bad_input db "Nieprawidlowe dane", 0xa

section .bss
    ascii1: resb 200
    ascii2: resb 200
    number1: resb 100
    len1: resb 1
    number2: resb 100
    len2: resb 1
    result: resb 200
    ascii_result: resb 401
    odd1: resb 1
    odd2: resb 1

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

    ;Mnozenie
    xor eax, eax
    mov al, [len1]
    mov bl, 2
    div bl
    add al, ah
    mov [odd1], ah
    mov [len1], al

    xor eax, eax
    mov al, [len2]
    mov bl, 2
    div bl
    add al, ah
    mov [odd2], ah
    mov [len2], al

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
    push esi

    in_loop:
    mov al, [esi]
    mov ah, [edi]
    mul ah
    lea edx, [result]
    add dl, ch
    add dl, cl
    clc
    add byte [edx], al
    inc edx
    adc byte [edx], ah
    check_carry:
    jnc no_carry
    inc edx
    add byte [edx], 1
    jmp check_carry
    no_carry:
    dec esi
    inc cl
    cmp cl, [len1]
    jl in_loop
    pop esi
    push esi
    dec edi
    inc ch
    xor cl, cl
    cmp ch, [len2]
    jl in_loop

    ;Konwersja na ascii
    lea esi, [result]
    add esi, 400
    next:
    dec esi
    cmp byte [esi], 0
    je next

    lea edi, [ascii_result]
    next_byte_hta:
    mov al, byte [esi]
    mov bl, al
    shr al, 4
    cmp al, 9
    jg letter_al
    add al, 30h
    jmp digit_al
    letter_al:
    add al, 57h
    digit_al:
    mov [edi], al
    inc edi
    shl bl, 4
    shr bl, 4
    cmp bl, 9
    jg letter_bl
    add bl, 30h
    jmp digit_bl
    letter_bl:
    add bl, 57h
    digit_bl:
    mov [edi], bl
    inc edi
    dec esi
    cmp esi, result
    jge next_byte_hta
    xor edx, edx
    mov dl, [odd1]
    sub edi, edx
    mov dl, [odd2]
    sub edi, edx
    mov [edi], byte 0xa

    ;Wypisanie wyniku
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, 7
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, ascii_result
    mov edx, 200
    int 80h

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
    shl al, 4
    inc esi
    jmp next_digit
    upper_case:
    cmp al, 65
    jl bad_input
    cmp al, 70
    jg lower_case
    ;zamiana A-F
    sub al, 37h
    shl al, 4
    inc esi
    jmp next_digit
    lower_case:
    cmp al, 97h
    jl bad_input
    cmp al, 102
    jg bad_input
    ;zamiana a-f
    sub al, 57h
    shl al, 4
    inc esi

    next_digit:
    mov bl, byte [esi]
    cmp bl, 10
    jne hex_to_ascii_continue
    mov [edi], al
    jmp end
    hex_to_ascii_continue:
    inc cl
    cmp bl, 48
    jl bad_input
    cmp bl, 57
    jg upper_case2
    ;zamiana cyfr
    sub bl, 30h    
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
