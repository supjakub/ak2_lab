global main

section .data
    s_format: db "%s", 10, 0
    lf_format: db "%lf", 0
    msg1 db "Podaj pierwszy operand: ", 0
    msg2 db "Podaj drugi operand: ", 0

section .bss
    number1: resb 64
    number2: resb 64

section .text
extern printf, scanf

main:

    push msg1
    push s_format
    call printf

    push number1
    push lf_format
    call scanf

    push msg2
    push s_format
    call printf

    push number2
    push lf_format
    call scanf

    ;Wyjscie z programu
    mov eax, 1
    int 80h
