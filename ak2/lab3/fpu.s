global main

section .data
    msg1 db "Podaj pierwszy operand: ", 0
    format: db "%s", 10, 0

section .bss

section .text
extern printf

main:

    push msg1
    push format
    call printf
    add esp, 4
    pop eax

    ;Wyjscie z programu
    mov eax, 1
    int 80h
