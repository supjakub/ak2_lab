.global _start

.data
    message: .ascii "Podaj zdanie:\n"
    buffer: .space 100    

.text

    _start:
        mov $4, %eax
        mov $1, %ebx
        mov $message, %ecx
        mov $14, %edx
        int $0x80

        mov $3, %eax
        mov $0, %ebx
        mov $buffer, %ecx
        mov $100, %edx
        int $0x80

        mov $4, %eax
        mov $1, %ebx
        mov $buffer, %ecx
        mov $100, %edx
        int $0x80      

        mov $1, %eax
        mov $0, %ebx
        int $0x80

