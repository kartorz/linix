CC = gcc
AS = as
LD = ld

#TOPDIR = /home/joni/Projects/GNU/linix/src
TOPDIR = /home/joni/Projects/linix/linix
INCLUDE = -I$(TOPDIR)/include
#-Wextra -Werror
CFLAGS += $(INCLUDE) -fno-stack-protector -Wall 
LDFLAGS = -nostdlib -nostartfiles -nodefaultlibs
KERNEL_SUF = img

%o : %S
	$(CC) $(DEFINES) $(CFLAGS) -c $< -o $@

%o : %c
	$(CC) $(DEFINES) $(CFLAGS) -c $< -o $@

$(lib_a): $(objs)
	$(AR) -r $@  $(objs)
