SECTIONS {
	. = 0x80000000;
	.text.bios 0x80000000 : {
		*(.text.bios)
		*(.rodata)
	}

	. = 0x80200000;
	.text.kernel 0x80200000 : {
		*(.text.kernel)
		*(.rodata)
	}

	_end = .;
}
