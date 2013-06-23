/*	
 * Copyright (c) 2013
 *	MINIX.
 *
 *  This file comes from minix source code.
 *  You can find the minix websit in the README file and, get more information about minix.
 */

#include "boot/asm.h"

/* This is useful for debugging - although you may need to
 * delete some code to fit it in.
 * %ds:dump_eax_buff must be somewhere it is safe to write 10 bytes.
 */

ENTRY(dump_eax)
	.code16
	pusha					/* saves bottom 16 bits only! */
	movw	$dump_eax_buff, %si
	mov	%si, %di
	movw	$8, %cx
1:	roll	$4, %eax
	push	%ax
	andb	$0x0f, %al
	addb	$0x30, %al			/* 30..3f - clear AF */
#if 1 /* 5 bytes to generate real hex... */
	daa					/* 30..39, 40..45 */
	addb	$0xc0, %al			/* f0..f9, 00..05 */
	adcb	$0x40, %al			/* 30..39, 41..46 */
#endif
	mov	%al,(%di)
	inc	%di
	pop	%ax
	loop	1b
	movw	$0x20,(%di)			/* space + NIL */
	jmp	message_1
