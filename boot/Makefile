
DEFINES = -D__ELF__

objs =  boot.o \
        boot2.o \
        lib/i386.a

include ../common.mk

boot: $(objs)
	$(LD) -T linker.ld  $^ -o $@

lib/i386.a: force
	$(MAKE) -C lib

clean:
	@find . -name "*.[oadP]" | xargs -I{} rm {}

.PHONY: force clean
