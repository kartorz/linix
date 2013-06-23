linix
============================================
Linix is a tutorial show you how to program in X86 protected and real address mode,
how to write a OS from a scratch : compiling, link, loading and so on.
So, I just keep every thing simple, straight, no more coding technique hiding things deeply.

What's the host OS needed?
-------------------------------------------
The source code need to be compiled by GNU suit(gcc, ld, as, make, .etc).
So, a OS which can run the GNU suit is needed, and we use grub as a bootloader,
the GNU grub is needed. Finally,you need a "virtualbox" to run Linux also.


GNU suit: http://www.gnu.org/
vritualbox: https://www.virtualbox.org/

How to build?
------------------------------------------
1: make
   Will build a kernel.img under "bin" directory.
2: make iso
   Will make a bootable iso, you can run it in "virtualbox".


