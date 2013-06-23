#ifndef _STRING_H_
#define _STRING_H_
/*
 *  Implement  functions of libc.
 *  
 *       
 */


#include "type.h"

extern void *memset(void *s, int c, size_t n);

extern char *strchr(const char *s, int c);
extern char *strrchr(const char *s, int c);

extern size_t strlen(const char *s);

#endif
