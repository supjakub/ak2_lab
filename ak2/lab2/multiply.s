global _start

section .data
    
message1 db "Podaj mnozna: "
    message2 db "Podaj mnoznik: "
    message3 db "Wynik: "

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

    ; Zakonczenie programu
    mov eax, 1
    int 80h


    

