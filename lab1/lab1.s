.global _start

.data
    message: .ascii "Podaj zdanie:\n"
    message_length = . - message

.text

    _start:
        mov $4, %eax
        mov $1, %ebx
        mov $message, %ecx
        mov $message_length, %edx
        int $0x80

        mov $1, %eax
        mov $0, %ebx
        int $0x80

