global main

section .data
    s_format: db "%s", 10, 0
    lf_format: db "%lf", 0
    c_format: db " %c", 0
    result_format: db "Wynik: %f", 10, 0
    msg1 db "Podaj pierwszy operand: ", 0
    msg2 db "Podaj drugi operand: ", 0
    msg3 db "Podaj dzialanie (+, -, *, /): ", 0
    msg4 db "Podaj sposob zaokraglania: 1-nearest, 2-down, 3-up, 4-to zero: ", 0
    msg_error db "Zle wejscie", 0

section .bss
    number1: resq 1
    number2: resq 1
    operation: resb 1
    rounding: resb 1
    control_word: resw 1

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

    finit
    cmp byte [rounding], 49
    je nearest
    cmp byte [rounding], 50
    je to_down
    cmp byte [rounding], 51
    je to_up
    cmp byte [rounding], 52
    je to_zero
    jmp bad_input

    nearest:
    mov word [control_word], 0000001101111111b
    fldcw [control_word]
    jmp check_operation
    to_down:
    mov word [control_word], 0000011101111111b
    fldcw [control_word]
    jmp check_operation
    to_up:
    mov word [control_word], 0000101101111111b
    fldcw [control_word]
    jmp check_operation
    to_zero:
    mov word [control_word], 0000111101111111b
    fldcw [control_word]

    check_operation:
    fld qword [number1]
    fld qword [number2]
    cmp byte [operation], 43
    je add
    cmp byte [operation], 45
    je subtract
    cmp byte [operation], 42
    je multiply
    cmp byte [operation], 47
    je divide
    jmp bad_input

    add:
    fadd
    jmp print_result
    subtract:
    fsub
    jmp print_result
    multiply:
    fmul
    jmp print_result
    divide:
    fdiv

    print_result:
    fstp qword [esp]
    push result_format
    call printf

    ;Wyjscie z programu
    mov eax, 1
    int 80h

    bad_input:
    push msg_error
    push s_format
    call printf
    mov eax, 1
    int 80h
