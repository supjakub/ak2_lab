global main

section .data
    s_format: db "%s", 10, 0
    lf_format: db "%lf", 0
    c_format: db " %c", 0
    msg1 db "Podaj pierwszy operand: ", 0
    msg2 db "Podaj drugi operand: ", 0
    msg3 db "Podaj dzialanie (+, -, *, /): ", 0
    msg4 db "Podaj sposob zaokraglania: 1-nearest, 2-down, 3-up, 4-to zero: ", 0

section .bss
    number1: resq 1
    number2: resq 1
    operation: resb 1
    rounding: resb 1

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

    push msg3
    push s_format
    call printf

    push operation
    push c_format
    call scanf

    push msg4
    push s_format
    call printf

    push rounding
    push c_format
    call scanf

    ;Wyjscie z programu
    mov eax, 1
    int 80h
