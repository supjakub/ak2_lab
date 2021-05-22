global steg

section .text

steg:

    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    add eax, 1
    
    pop ebp
    ret
