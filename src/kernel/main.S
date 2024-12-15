#define UART_ADDRESS 0x10000000

.section .rodata
msg1: .asciz "First message\n"
msg2: .asciz "Second message\n"

.global _kernel_start
.section .text.kernel
_kernel_start:
	addi sp, sp, -8

	la t0, msg1
	sd t0, 0(sp) 
	call print_str

	la t0, msg2
	sd t0, 0(sp) 
	call print_str

	addi sp, sp, 8

trap:
	j trap

/* a0: char */
put_char:
	li t3, UART_ADDRESS
	sb a0, 0(t3)
	ret

/* sp[0]: string_addr */
print_str:
	add s0, ra, zero    /* Save return address */
	ld t0, 0(sp) 	/* Load string address from stack into a0 */

.print_loop:

	lb t1, 0(t0) 	    /* Load byte into t1 */
	beqz t1, .print_end
	
	add a0, zero, t1    /* Move t1 into a0 */
	call put_char

	addi t0, t0, 1 	    /* Increment t0 address */
	j .print_loop

.print_end:
	add ra, s0, zero    /* Load back return address */
	ret
