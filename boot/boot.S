/*
 *  The Boot ELF will be invoked by bootloader like grub.
 *  Now, the bootloader has switched CPU to protected mode.
 *
 *  Reference multiboot specification for more detail.        
 *
 */
        
#include "boot/asm.h"        
#include "boot/multiboot.h"
        
/* The size of our stack (16KB). */
#define STACK_SIZE                      0x4000

#define CS_BASE 0x0FFFF0000
#define RAM_START   0x400
#define TSS_INDEX   10
        
#define DESC_SIZE 0x08
#define TEMP_TABLE_SIZE 0x02
#define LINEAR_SEL 1*DESC_SIZE
#define LINEAR_LO 0x0000FFFF
#define LINEAR_HI 0x000C9F00

.data
.bss        
halt_message:
        .asciz  "Halted."     
            /* Our stack area. */
        .comm   stack, STACK_SIZE

.text
_LABEL(start)
		jmp     multiboot_entry        
			/* Align 32 bits boundary. */
		.align  4
        
/* Multiboot header. */
multiboot_header:
		/* magic */
        .long   MULTIBOOT_HEADER_MAGIC
        /* flags */
        .long   MULTIBOOT_HEADER_FLAGS
        /* checksum */
        .long   -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

multiboot_entry:
       	/* Initialize the stack pointer. */
		movl $(stack + STACK_SIZE), %esp
	    /* Reset EFLAGS. */
	    pushl $0
	    popf
        call   gdt_init
        /* Push the pointer to the Multiboot information structure. */
        pushl   %ebx
        /* Push the magic value. */
        pushl   %eax
        /* Now enter the C main function... */
        call  _C_LABEL(boot2_main)
        
loop: hlt
            jmp     loop

        