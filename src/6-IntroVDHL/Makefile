SUBDIRS = and_2 shift_register ST SumadorSecuencial

.PHONY: all clean re $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir -f Makefile $@; \
	done

re: clean all


