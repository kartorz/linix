/*
 *  The kernel ELF will be invoked by bootloader like grub.
 *  Now, the bootloader has switched CPU to protected mode.
 *
 *  Reference multiboot specification for more detail.        
 *
 */
   
#include "i386/asm.h"
        
#define ASM_SOURCE
#include "i386/multiboot.h"
        
/* The size of our stack (16KB). */
#define STACK_SIZE                      0x4000

IMPORT(kmain)
        
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
       	/* Initialize the stack pointer, we need a stack*/
		movl $(stack + STACK_SIZE), %esp
        /* Push the pointer to the Multiboot information structure. */
        pushl   %ebx
        /* Push the magic value. */
        pushl   %eax
	    /* Reset EFLAGS. */
	    pushl $0
	    popf
        call _C_LABEL(boot)
        /* Now enter the C main function... */
        /* call  _C_LABEL(kmain) */
        
loop: hlt
            jmp     loop

halt_message:
        .asciz  "Halted."
        
 /* Our stack area. */
.comm   stack, STACK_SIZE
