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

    mov cx, 100
    mov byte ah, buffer
    loop:
        cmp ah, 0
        je end
        add byte ah, 13
        inc ah
        dec cx
    jnz loop
        

    ; Wypisywanie tekstu
    end:
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 100
    int 80h

    ; Zakonczenie programu
    mov eax, 1
    int 80h
