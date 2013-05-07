/*	
 * Copyright (c) 2013
 *	MINIX.
 *
 *  This file comes from minix source code.
 *  You can find the minix websit in the README file and, get more information about minix.
 */

void printf(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vprintf(fmt, ap);
	va_end(ap);
}
