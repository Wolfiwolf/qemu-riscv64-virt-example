BLD_DIR = build
BOOTLOADER_BLD_DIR = $(BLD_DIR)/bootloader
KERNEL_BLD_DIR = $(BLD_DIR)/kernel

SRC_DIR = src
BOOTLOADER_SRC_DIR = $(SRC_DIR)/bootloader
KERNEL_SRC_DIR = $(SRC_DIR)/kernel

bld_dir:
	@mkdir -p $(BOOTLOADER_BLD_DIR)
	@mkdir -p $(KERNEL_BLD_DIR)

build: bld_dir
	riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -E $(KERNEL_SRC_DIR)/main.S -o $(KERNEL_BLD_DIR)/main.s
	riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -E $(BOOTLOADER_SRC_DIR)/main.S -o $(BOOTLOADER_BLD_DIR)/main.s

	riscv64-unknown-elf-as -march=rv64i -mabi=lp64 -o $(BOOTLOADER_BLD_DIR)/main.o -c $(BOOTLOADER_BLD_DIR)/main.s
	riscv64-unknown-elf-as -march=rv64i -mabi=lp64 -o $(KERNEL_BLD_DIR)/main.o -c $(KERNEL_BLD_DIR)/main.s
	riscv64-unknown-elf-ld -T link.ld $(KERNEL_BLD_DIR)/main.o $(BOOTLOADER_BLD_DIR)/main.o -o $(BLD_DIR)/img.elf

run:
	@echo ""
	@echo "First press CTRL-A and after releasing press x to stop the program."
	@echo ""
	qemu-system-riscv64 -machine virt -bios $(BLD_DIR)/img.elf -nographic

clean:
	rm -rf $(BLD_DIR)/*
