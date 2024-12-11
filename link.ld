MEMORY {
  dram_space (rwx) : ORIGIN = 0x80000000, LENGTH = 1024M
}

SECTIONS {
  .text : {
    main.o(.text.bios)
  } > dram_space
}
