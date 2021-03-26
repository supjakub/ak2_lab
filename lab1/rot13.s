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

    mov cl, 5
    mov eax, buffer
    loop:
        add byte [eax], 13
        inc eax
        dec cl
    jnz loop
        

    ; Wypisywanie tekstu
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 100
    int 80h

    ; Zakonczenie programu
    mov eax, 1
    int 80h
