#include "i386/asm.h"

#define	CR0_PE		1

	.text
	.align  16
gdt:
	.word	0, 0
	.byte	0, 0x00, 0x00, 0

	/* kernel code segment */
	.globl flatcodeseg
flatcodeseg = . - gdt
	.word	0xffff, 0
	.byte	0, 0x9f, 0xcf, 0

	/* kernel data segment */
	.globl flatdataseg
flatdataseg = . - gdt
	.word	0xffff, 0
	.byte	0, 0x93, 0xcf, 0

	/* boot code segment, base will be patched */
bootcodeseg = . - gdt
	.word	0xffff, 0
	.byte	0, 0x9e, 0x4f, 0

	/* boot data segment, base will be patched */
bootdataseg = . - gdt
	.word	0xffff, 0
	.byte	0, 0x92, 0xcf, 0

	/* 16 bit real mode, base will be patched */
bootrealseg = . - gdt
	.word	0xffff, 0
	.byte	0, 0x9e, 0x00, 0

	/* limits (etc) for data segment in real mode */
bootrealdata = . - gdt
	.word	0xffff, 0
	.byte	0, 0x92, 0x00, 0
gdtlen = . - gdt

	.align	16
gdtarg:
	.word	gdtlen-1		/* limit */
	.long	0			/* physical addr, will be inserted */

 toreal:    .word	xreal			/* off:seg address for indirect jump */

_ENTRY(gdt_init)
     .code32
     pushl	%eax   
     movl	$gdt, %eax
	 movl	%eax, gdtarg+2
     lgdt	%cs:gdtarg		/* Global descriptor table */
     mov	$bootdataseg, %eax
	 mov	%ax, %ds
	 mov	%ax, %es
	 mov	%ax, %ss
     popl   %eax
     ret
 /*
 * real_to_prot()
 *
 * Switch CPU to 32bit protected mode to execute C.
 *
 * NB: Call with the 32bit calll instruction so that a 32 bit
 *     return address is pushed.
 *
 * All registers are preserved, %ss:%esp will point to the same
 * place as %ss:%sp did, although the actual value of %esp might
 * be changed.
 *
 * Interrupts are disabled while we are in 32bit mode to save us
 * having to setup a different IDT.  This code is only used during
 * the boot process and it doesn't use any interrupts.
 */
_ENTRY(real_to_prot)
	.code16
	pushl	%eax
	cli

	lgdt	%cs:gdtarg		/* Global descriptor table */

	movl	%cr0, %eax
	or	$CR0_PE, %ax
	movl	%eax, %cr0 		/* Enter 'protected mode' */

	ljmp	$bootcodeseg, $1f	/* Jump into a 32bit segment */
1:

	.code32
	/*  Set all the segment registers to map the same area as the code */
	mov	$bootdataseg, %eax
	mov	%ax, %ds
	mov	%ax, %es
	mov	%ax, %ss

	popl	%eax
	ret

/*
 * prot_to_real()
 *
 * Switch CPU back to 16bit real mode in order to call system bios functions.
 *
 * All registers are preserved, except that %sp may be changed so that
 * %ss:%sp points to the same memory.
 * Note that %ebp is preserved and will not reference the correct part
 * of the stack.
 *
 * Interrupts are enabled while in real mode.
 *
 * Based on the descripton in section 14.5 of the 80386 Programmer's
 * reference book.
 */

_ENTRY(prot_to_real)
	.code32
	pushl	%eax
	/*
	 * Load the segment registers while still in protected mode.
	 * Otherwise the control bits don't get changed.
	 * The correct base addresses are loaded later.
	 */
	movw    $bootrealdata, %ax
	movw    %ax, %ds
	movw    %ax, %es
	movw    %ax, %ss

	/*
	 * Load %cs with a segment that has the correct attributes for
	 * 16bit operation.
	 */
	ljmp	$bootrealseg, $1f
1:

	.code16
	movl	%cr0, %eax
	and 	$~CR0_PE, %eax
	movl	%eax, %cr0		/* Disable potected mode */

	/* Jump far indirect to load real mode %cs */
	ljmp	*%cs:toreal
xreal:
	/*
	 * CPU is now in real mode, load the other segment registers
	 * with their correct base addresses.
	 */
	mov	%cs, %ax
	mov	%ax, %ds
	mov	%ax, %es
	/*
	 * If stack was above 64k, 16bit %ss needs to be different from
	 * 32bit %ss (and the other segment registers).
	 */
        
	/* Check we are returning to an address below 64k */
	push	%bp
	movw	%sp, %bp
	movw	2/*bp*/ + 4/*eax*/ + 2(%bp), %ax	/* high bits ret addr */
	test	%ax, %ax
	jne	1f
	pop	%bp

	sti
	popl	%eax
	retl

1:	movw	$3f, %si
	call	message
	movl	2/*bp*/ + 4/*eax*/(%bp), %eax		/*  return address */
	call	dump_eax
	int	$0x18
2:	sti
	hlt
	jmp	2b
3:	.asciz	"prot_to_real can't return to "

	.global	dump_eax_buff
dump_eax_buff:
	. = . + 16


#ifdef EPIA_HACK
trash_return_cache:
	.code32
	pop	%eax
	jmp	*%eax
#endif

/* vtophys(void *)
 * convert boot time 'linear' address to a physical one
 */

_ENTRY(vtophys)
	.code32
	xorl	%eax, %eax
	shll	$4, %eax
	addl	4(%esp), %eax
	ret
