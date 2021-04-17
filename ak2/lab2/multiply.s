global _start

section .data
    
    message1 db "Podaj mnozna: "
    message2 db "Podaj mnoznik: "
    message3 db "Wynik: "
    message4 db "Nieprawidlowe dane"

    multiplicand times 200 db 0
    multiplier   times 200 db 0

section .text
_start:

    ; Wczytywanie danych
    mov eax, 4
    mov ebx, 1
    mov ecx, message1
    mov edx, 14
    int 80h

    mov eax, 3
    mov ebx, 1
    mov ecx, multiplicand
    mov edx, 200
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, message2
    mov edx, 15
    int 80h

    mov eax, 3
    mov ebx, 1
    mov ecx, multiplier
    mov edx, 200
    int 80h

    ;Walidacja i konwersja mnoznej
    mov cl, 200
    mov eax, multiplicand

    loop1:
        cmp byte [eax], 48
        jl bad_input
        cmp byte [eax], 57
        jg check_upper_case1
        ; TODO: zamiana cyfr
    
        check_upper_case1:
        cmp byte [eax], 65
        jl bad_input
        cmp byte [eax], 70
        jg check_lower_case1
        ; TODO: zamiana A-F

        check_lower_case1:
        cmp byte [eax], 97
        jl bad_input
        cmp byte [eax], 102
        jg bad_input
        ; TODO: zamiana a-f

        end_loop1:
        inc eax
        dec cl
        cmp cl, 0
    jne loop1

    ;Walidacja i konwersja mnoznika
    mov cl, 200
    mov eax, multiplier

    loop2:
        cmp byte [eax], 48
        jl bad_input
        cmp byte [eax], 57
        jg check_upper_case2
        ; TODO: zamiana cyfr
    
        check_upper_case2:
        cmp byte [eax], 65
        jl bad_input
        cmp byte [eax], 70
        jg check_lower_case2
        ; TODO: zamiana A-F

        check_lower_case2:
        cmp byte [eax], 97
        jl bad_input
        cmp byte [eax], 102
        jg bad_input
        ; TODO: zamiana a-f

        end_loop2:
        inc eax
        dec cl
        cmp cl, 0
    jne loop2
    
    ; Zakonczenie programu
    mov eax, 1
    int 80h

    ; Zle wejscie
    bad_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, message4
    mov edx, 20
    int 80h

    mov eax, 1
    int 80h


    

