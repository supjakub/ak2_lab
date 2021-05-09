all: fpu

fpu.o: fpu.s
	nasm -f elf32 fpu.s

fpu: fpu.o
	gcc -m32 fpu.o -o fpu
	
