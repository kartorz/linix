

export TOPDIR =$(shell pwd)

OBJS +=  i386/i386.a kernel/kernel.a 
subdirs = i386 kernel

include common.mk

a11: $(subdirs) linix

linix: $(OBJS)
	-test -d bin || mkdir bin
	$(LD) -T linker.ld  $^ $(LDFLAGS) -o bin/$@.$(KERNEL_SUF)

$(subdirs):
	$(MAKE) -C $@

iso:
	-cp bin/linix.$(KERNEL_SUF)  iso
	grub-mkrescue -o linix.iso iso

.PHONY : clean force  iso $(subdirs)

clean:
	@find . -name "*.[oadP]" | xargs -I{} rm {}
	-@rm -f bin/*
