all: filter

filter.o: filter.s
	nasm -f elf32 -F dwarf filter.s

filter: filter.o filter.c
	gcc -g -m32 filter.o filter.c -o filter
	
