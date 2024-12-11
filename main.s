.section .rodata
msg1: .asciz "First message\n"
msg2: .asciz "Second message\n"

.global _start
.section .text.bios

_start:
.setup_stack:
	li sp, 0x80200000 /* This address is also used by opensbi for loading the program */

.program:
	addi sp, sp, -8

	la a0, msg1
	sd a0, 0(sp)
	call print_str

	la a0, msg2
	sd a0, 0(sp)
	call print_str
	
	addi sp, sp, 8
.loop:	
	j .loop

/* a1: char */
put_char:
	li t0, 0x10000000
	sb a1, 0(t0)
	ret

/* sp[0]: string_addr */
print_str:
	ld a0, 0(sp)
	
	addi sp, sp, -8 /* We need some stack for saving return address */

.print_loop:

	lb a1, 0(a0)
	beqz a1, .print_end
	
	sd x1, 0(sp)
	call put_char
	ld x1, 0(sp)

	addi a0, a0, 1

	j .print_loop

.print_end:
	addi sp, sp, 8 /* Clear the stack */

	ret
