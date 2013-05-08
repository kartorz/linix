/*	
 * Copyright (c) 2013
 *	MINIX.
 *
 *  This file comes from minix source code.
 *  You can find the minix websit in the README file and, get more information about minix.
 */

#include "boot/asm.h"

	.global	message, message_1
/*
 * message: write the error message in %ds:%esi to the console
 */
message:

/*
 * BIOS call "INT 10H Function 0Eh" to write character to console
 *	Call with	%ah = 0x0e
 *			%al = character
 *			%bh = page
 *			%bl = foreground color
 */
	.code16
	pusha
message_1:			/* for dump_eax */
	lodsb
1:
	movb	$0x0e, %ah
	movw	$0x0001, %bx
	int	$0x10

	lodsb
	testb	%al, %al
	jnz	1b

#ifdef MESSAGE_PAUSE
	/* Delay for about 1 second to allow message to be read */
	movb	$0x86, %ah
	mov	$16, %cx		/* about a second */
	int	$0x15			/* delay cx:dx usecs */
#endif
	popa
	ret
