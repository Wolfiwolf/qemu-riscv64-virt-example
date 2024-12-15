.global _start
.section .text.bios

_start:
	la t0, trap_handler
	csrw mtvec, t0 	    /* Set the trap handler (mtvec csr register)*/

	la sp, _kernel_start /* Set the stack pointer to start of kernel */
	jr sp 		     /* Jump to start of the kernel */	

trap_handler:
	j trap_handler
