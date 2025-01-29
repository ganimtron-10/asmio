default: pos_neg

array:
	nasm -f elf array.asm -o array.o &&	ld -m elf_i386 array.o -o array && 	./array && rm array array.o

pos_neg:
	nasm -f elf array_posneg_count.asm -o array_posneg_count.o &&	ld -m elf_i386 array_posneg_count.o -o array_posneg_count && 	./array_posneg_count && rm array_posneg_count array_posneg_count.o



helloworld32:
	nasm -f elf hello32.asm -o hello32.o &&	ld -m elf_i386 hello32.o -o hello32 && 	./hello32 && rm hello32 hello32.o

helloworld64:
	nasm -f elf64 hello64.asm -o hello64.o &&	ld -m elf_x86_64 hello64.o -o hello64 && 	./hello64 && rm hello64 hello64.o