global _start

section .data
    msg1 db "Podaj mnozna: "
    ascii1 times 200 db 0
    msg2 db "Podaj mnoznik: "
    ascii2 times 200 db 0
    number1 times 200 db 0
    number2 times 200 db 0
    msg_bad_input db "Nieprawidlowe dane", 0xa

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
    lea esi, [ascii2]
    lea edi, [number2]
    call ascii_to_hex

    ;Wyjscie z programu
    mov eax, 1
    int 80h

ascii_to_hex:
    next_byte:
    mov al, byte [esi]
    cmp al, 10
    je end
    inc cx
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

    
