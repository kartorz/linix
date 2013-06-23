/* 
 *   Copyright (c) 2013
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *    If you want to get more infomation about,see <http://www.gnu.org/licenses/>.
 * 
 */

#include "string.h"

void *memset(void *s, int c, size_t n)
{
    char *d = (char *)s;

    if(!s || !n)
        return NULL;

    d = s+n-1;

    for(; n>0; --n)
    {
        *(d--) = c;
    }
    return s;
}
