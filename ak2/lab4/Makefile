all: steg

steg.o: steg.s
	nasm -f elf32 -F dwarf steg.s

steg: steg.o steg.c
	gcc -g -m32 steg.o steg.c -o steg
	
