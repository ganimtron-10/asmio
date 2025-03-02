default: multiply_add_and_shift

multiply_add_and_shift:
	nasm -f elf -g multiply_add_and_shift.asm -o multiply_add_and_shift.o &&	ld -m elf_i386 multiply_add_and_shift.o -o multiply_add_and_shift && 	./multiply_add_and_shift && rm multiply_add_and_shift multiply_add_and_shift.o

multiply_successive_add:
	nasm -f elf -g multiply_successive_add.asm -o multiply_successive_add.o &&	ld -m elf_i386 multiply_successive_add.o -o multiply_successive_add && 	./multiply_successive_add && rm multiply_successive_add multiply_successive_add.o

array:
	nasm -f elf array.asm -o array.o &&	ld -m elf_i386 array.o -o array && 	./array && rm array array.o

pos_neg:
	nasm -f elf array_posneg_count.asm -o array_posneg_count.o &&	ld -m elf_i386 array_posneg_count.o -o array_posneg_count && 	./array_posneg_count && rm array_posneg_count array_posneg_count.o

input:
	nasm -f elf input.asm -o input.o &&	ld -m elf_i386 input.o -o input && 	./input && rm input input.o

input_number:
	nasm -f elf input_number.asm -o input_number.o &&	ld -m elf_i386 input_number.o -o input_number && 	./input_number && rm input_number input_number.o


helloworld32:
	nasm -f elf hello32.asm -o hello32.o &&	ld -m elf_i386 hello32.o -o hello32 && 	./hello32 && rm hello32 hello32.o

helloworld64:
	nasm -f elf64 hello64.asm -o hello64.o &&	ld -m elf_x86_64 hello64.o -o hello64 && 	./hello64 && rm hello64 hello64.o