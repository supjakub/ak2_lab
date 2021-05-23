global code

section .text

code:

    push ebp
    mov ebp, esp

    mov eax, [ebp+8] ;Poczatek pikseli
    mov ebx, [ebp+12] ;Poczatek tekstu    
    
    pop ebp
    ret
