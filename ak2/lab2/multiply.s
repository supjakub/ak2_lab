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
    mov ax, dx
    mov bl, 8
    div bl
    cmp ah, 0
    je no_add1
    inc al
    no_add1:
    mov [len1], al
    lea esi, [ascii2]
    lea edi, [number2]
    call ascii_to_hex
    mov ax, dx
    mov bl, 8
    div bl
    cmp ah, 0
    je no_add2
    inc al
    no_add2:
    mov [len2], al

    call multi

    ;Wyjscie z programu
    mov eax, 1
    int 80h

ascii_to_hex:
    xor dx, dx
    xor ebx, ebx
    xor ecx, ecx
    xor eax, eax
    next_digit:
    mov al, byte [esi]
    cmp al, 10
    je end_ath
    inc dx
    cmp al, 48
    jl bad_input
    cmp al, 57
    jg upper_case
    ;zamiana cyfr
    sub al, 30h
    shl ebx, 4
    add ebx, eax
    inc ecx
    inc esi
    cmp ecx, 8
    je next_dword
    jmp next_digit
    upper_case:
    cmp al, 65
    jl bad_input
    cmp al, 70
    jg lower_case
    ;zamiana A-F
    sub al, 37h
    shl ebx, 4
    add ebx, eax
    inc ecx
    inc esi
    cmp ecx, 8
    je next_dword
    jmp next_digit
    lower_case:
    cmp al, 97
    jl bad_input
    cmp al, 102
    jg bad_input
    ;zamiana a-f
    sub al, 57h
    shl ebx, 4
    add ebx, eax
    inc ecx
    inc esi
    cmp ecx, 8
    je next_dword
    jmp next_digit

    next_dword:
    mov [edi], ebx
    add edi, 4
    xor ebx, ebx
    xor ecx, ecx
    jmp next_digit    
    
    end_ath:
    mov [edi], ebx
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
    lea esi, [number1]
    mov dl, [len1]
    next_address1:
    cmp dl, 1
    je good_address1
    add esi, 4
    dec dl
    jmp next_address1
    good_address1:
    mov eax, [esi]

    lea edi, [number2]
    mov dl, [len2]
    next_address2:
    cmp dl, 1
    je good_address2
    add edi, 4
    dec dl
    jmp next_address2
    good_address2:
    mov ebx, [edi]

    ret
