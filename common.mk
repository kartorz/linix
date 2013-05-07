TOPDIR =  /home/joni/Projects/linix/linix
CC = gcc
DEFINES :=
CFLAGS += -I$(TOPDIR)/include
LDFLAGS += -nostdlib -fno-stack-protector -fstack-protector-all
KERNEL_SUF = img

%o : %sx
	$(CC) -o $@ $(DEFINES) -c $(CFLAGS) $<

%o : %c
	$(CC) -o $@ $(DEFINES) -c $(CFLAGS) $<

$(lib_a): $(objs)
	$(AR) -r $@  $(objs)
