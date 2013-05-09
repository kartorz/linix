
DEFINES = -D__ELF__

objs =  boot.o \
        boot2.o \
        lib/i386.a

include ../common.mk

boot.bin: $(objs)
	$(LD) -T linker.ld  $^ -o $@

lib/i386.a: force
	$(MAKE) -C lib

clean:
	@find . -name "*.[oadP]" | xargs -I{} rm {}
	@rm boot.bin

.PHONY: force clean
