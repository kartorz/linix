/*	
 * Copyright (c) 2013
 *	MINIX.
 *
 *  This file comes from minix source code.
 *  You can find the minix websit in the README file and, get more information about minix.
 */

#include "boot/asm.h"

/*
 * Diagnostic print routines callable from 32bit C code during early
 * parts of the boot process.
 */

/*
 * void putstr(const char *)
 *
 * display message on console
 * bugs: message address must be less than 64k
 */

	.globl	_C_LABEL(putstr)
_C_LABEL(putstr):
	.code32
	movl	4(%esp), %eax
	pusha
	movl	%eax, %esi

	call	_C_LABEL(prot_to_real)
	.code16

	movl	%esi, %eax
	call	message

	calll	_C_LABEL(real_to_prot)
	.code32
	popa
	ret

/*
 * void putint(int)
 *
 * display value on console as 8 hex digits followed by a space
 */

	.globl	_C_LABEL(putint)
_C_LABEL(putint):
	.code32
	movl	4(%esp), %eax
	pusha

	call	_C_LABEL(prot_to_real)
	.code16

	call	dump_eax

	calll	_C_LABEL(real_to_prot)
	.code32
	popa
	ret
