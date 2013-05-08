

OBJS += kernel/kernel.a

subdirs = kernel

include common.mk

a11: subdir linix

linix: $(OBJS)
	-test -d bin || mkdir bin
	gcc -o bin/$@.$(KERNEL_SUF)   $^ $(LDFLAGS)

subdir: force
	$(foreach d, $(subdirs), $(MAKE) -C $(d))

boot: force
	$(MAKE) -C boot

.PHONY : clean force

clean:
	@find . -name "*.[oadP]" | xargs -I{} rm {}
	-rm -f bin/*
