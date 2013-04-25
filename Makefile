
include boot/makefile.inc
include kernel/makefile.inc

include common.mk

a11: linix

linix: $(OBJS)
	-test -d bin || mkdir bin
	gcc -o bin/$@.$(KERNEL_SUF)   $^ $(LDFLAGS)

#subdir: force
#	$(foreach d, $(subdirs), $(MAKE) -C $(dir))

.PHONY : clean

clean:
	@find . -name "*.o" | xargs -I{} rm {}
