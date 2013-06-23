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


static char *strchr_comm(const char *s, int c, int r)
{
    int i = 0;
    char *occur = NULL;

    do
    {
        if(s[i] == c)
        {
            occur =  &s[i];
            if(!r){
                return occur;
            }
        }
        ++i;
    }while(s[i] != '\0');

    return occur;
}

char *strchr(const char *s, int c)
{
    if(!s || c == '\0')
        return NULL;

    strchr_comm(s, c, 0);
}

char *strrchr(const char *s, int c)
{
    if(!s || c == '\0')
        return NULL;

    strchr_comm(s, c, 1);    
}


size_t strlen(const char *s)
{
    size_t i = 0;
    if(s == NULL)
        return 0;

    while(s[i] != '\0') ++i;
    return i-1;
}

