/*
 *
 */

#ifndef _STDIO_H_

#define _STDIO_H_

int kprintf(const char *format, ...);

#define printf  kprintf

#endif
