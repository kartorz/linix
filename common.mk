CC = gcc
AS = as
LD = ld

INCLUDE = -I$(TOPDIR)/include  \
		-I$(TOPDIR)/include/arch/i386 \
		-I$(TOPDIR)/include/arch \
		-I$(TOPDIR)/include/libc

# 		-ansi 
CFLAGS += $(INCLUDE) -nostdinc  \
		-fno-stack-protector \
		-Wall 

LDFLAGS = -nostdlib -nostartfiles -nodefaultlibs

DEFINES = -D_ELF_

KERNEL_SUF = img



%o : %S
	$(CC) $(DEFINES) $(CFLAGS) -c $< -o $@

%o : %c
	$(CC) $(DEFINES) $(CFLAGS) -c $< -o $@

$(lib_a): $(objs)
	$(AR) -r $@  $(objs)
