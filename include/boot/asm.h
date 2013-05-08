
/*	
 * Copyright (c) 2013
 *	MINIX.
 *
 *  This file comes from minix source code.
 *  You can find the minix websit in the README file and, get more information about minix.
 */

#define _ALIGN_TEXT .align 16


#define _ENTRY(x) \
	.text; _ALIGN_TEXT; .globl x; .type x,@function; x:

#define ENTRY(x) _ENTRY(x)

#define _LABEL(x) \
	.globl x; x:


#ifdef __ELF__
# define _C_LABEL(x)	x
#else
#define _C_LABEL(sym)  _ ## sym
#endif

#define	_ASM_LABEL(x)	x
