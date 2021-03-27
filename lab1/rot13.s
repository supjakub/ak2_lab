global _start

section .data

    message db "Podaj swoj tekst:", 0ah
    buffer times 100 db 0

section .text
_start:

    ; Wypisywanie tekstu
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, 18
    int 80h

    ; Pobieranie tekstu
    mov eax, 3
    mov ebx, 1
    mov ecx, buffer
    mov edx, 100
    int 80h

    mov cl, 100
    mov eax, buffer
    loop:

        cmp byte [eax], 65
        jl end_loop
        cmp byte [eax], 90
        jg check_lowercase
        
        ; Wielkie litery
        sub byte [eax], 52
        cmp byte [eax], 26 ; mod 26
        jl no_sub1
        sub byte [eax], 26
        no_sub1:
        add byte [eax], 65
        jmp end_loop

        check_lowercase:
        cmp byte [eax], 97
        jl end_loop
        cmp byte [eax], 122
        jg end_loop

        ; Male litery
        sub byte [eax], 84
        cmp byte [eax], 26 ; mod 26
        jl no_sub2
        sub byte [eax], 26
        no_sub2:
        add byte [eax], 97

        end_loop:
        inc eax
        dec cl
        cmp cl, 0
    jne loop
        

    ; Wypisywanie tekstu
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 100
    int 80h

    ; Zakonczenie programu
    mov eax, 1
    int 80h
