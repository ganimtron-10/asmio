default: array

array:
	nasm -f elf array.asm -o array.o &&	ld -m elf_i386 array.o -o array && 	./array && rm array array.o




helloworld32:
	nasm -f elf hello32.asm -o hello32.o &&	ld -m elf_i386 hello32.o -o hello32 && 	./hello32 && rm hello32 hello32.o

helloworld64:
	nasm -f elf64 hello64.asm -o hello64.o &&	ld -m elf_x86_64 hello64.o -o hello64 && 	./hello64 && rm hello64 hello64.o