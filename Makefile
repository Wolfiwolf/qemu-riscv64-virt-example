build:
	riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -static -o main.o -c main.s
	riscv64-unknown-elf-ld -T link.ld -o program.elf main.o

run:
	qemu-system-riscv64 -machine virt -bios program.elf -nographic

clean:
	rm main.o program.elf
