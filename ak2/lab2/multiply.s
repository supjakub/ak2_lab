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

    ;Wyjscie z programu
    mov eax, 1
    int 80h

ascii_to_hex:
    next_digit:
    movzx eax, byte[esi]
    inc esi
    cmp al, 10
    je end_loop
    cmp al, 48
    jl bad_input
    cmp al, 57
    jg upper_case
    ;zamiana cyfr
    sub al, 30h
    mov [edi], al
    inc edi
    jmp next_digit
    upper_case:
    cmp al, 65
    jl bad_input
    cmp al, 70
    jg lower_case
    ;zamiana A-F
    sub al, 37h
    mov [edi], al
    inc edi
    jmp next_digit
    lower_case:
    cmp al, 97h
    jl bad_input
    cmp al, 102
    jg bad_input
    ;zamiana a-f
    sub al, 57h
    mov [edi], al
    inc edi
    jmp next_digit

    end_loop:
    ret

    bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_bad_input
    mov edx, 19
    int 80h
    mov eax, 1
    int 80h

    
