all: multiply

multiply.o: multiply.s
	nasm -f elf32 multiply.s

multiply: multiply.o
	ld -m elf_i386 -s -o multiply multiply.o
	
