#include "boot/multiboot.h"
extern void putstr(char *);
void boot2_main (unsigned long magic, unsigned long addr)
{
     /* Print out the flags. */
  //    printf ("Welcome linix");
    putstr("Welcome linix");
}
