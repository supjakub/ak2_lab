all: rot13

rot13.o: rot13.S
	nasm -f elf32 rot13.s

rot13: rot13.o
	ld -m elf_i386 -s -o rot13 rot13.o
	