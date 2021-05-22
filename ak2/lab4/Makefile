all: steg

steg.o: steg.s
	nasm -f elf32 steg.s

steg: steg.o steg.c libbmp.c libbmp.h
	gcc -m32 steg.o steg.c libbmp.c libbmp.h -o steg
	
