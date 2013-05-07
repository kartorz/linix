
OBJS =  boot.o	\
        boot2.o \
        lib/i386.a

include ../common.mk

boot: $(OBJS)
	gcc -o $@  $(LDFLAGS) $^

