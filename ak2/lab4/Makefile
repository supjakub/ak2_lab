all: steg

steg.o: steg.s
	nasm -f elf32 steg.s

steg: steg.o steg.c
	gcc -m32 steg.o steg.c -o steg
	
