CC = gcc
AS = as
LD = ld

INCLUDE = -I$(TOPDIR)/include
CFLAGS += $(INCLUDE) -fno-stack-protector -Wall 
LDFLAGS = -nostdlib -nostartfiles -nodefaultlibs
KERNEL_SUF = img
DEFINES = -D_ELF_

%o : %S
	$(CC) $(DEFINES) $(CFLAGS) -c $< -o $@

%o : %c
	$(CC) $(DEFINES) $(CFLAGS) -c $< -o $@

$(lib_a): $(objs)
	$(AR) -r $@  $(objs)
