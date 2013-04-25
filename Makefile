
include boot/makefile.inc
include kernel/makefile.inc

include common.mk

a11: linix

linix: $(OBJS)
	gcc -o bin/$@.$(KERNEL_SUF)   $^ $(LDFLAGS)

#subdir: force
#	$(foreach d, $(subdirs), $(MAKE) -C $(dir))

.PHONY : clean

clean:
	@rm $(OBJS)
