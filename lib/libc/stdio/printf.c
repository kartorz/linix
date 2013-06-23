/*	
 *
 */

#include "string.h"
#include "vd.h"

static void kvprintf(const char *format, char* arg[])
{
    int c;
    char buf[20];
     
    while ((c = *format++) != 0)
    {
        if (c != '%')
            vd_putchar (c);
        else
        {
            char *p;
            c = *format++;
            switch (c)
            {
            case 'd':
            case 'u':
            case 'x':
                #if 0
                // itoa (buf, c, *((int *) arg++));
                // p = buf;
                // goto string;
                #endif
                break;
     
            case 's':
                p = *arg++;
                if (! p)
                    p = "(null)";
     
            string:
                while (*p)
                    vd_putchar (*p++);
                break;
     
            default:
                vd_putchar (*((int *) arg++));
                break;
            }
        }
    }
}


void kprintf(const char *fmt, ...)
{
    char **arg = (char **) &fmt;
    arg++;   
   	kvprintf(fmt, arg);
}
