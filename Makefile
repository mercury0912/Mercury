#
# Makefile
#
# The global Makefile for linux-programming
#

sinclude config.make

ifndef MERCURY_BASE
$(warning WARNING: MERCURY_BASE is not defined. Assuming current directory.)
export MERCURY_BASE=$(shell pwd)
endif

ifndef MERCURY_BUILD
export MERCURY_BUILD=$(MERCURY_BASE)/build
endif

.PHONY: mercury all samples clean cleans distclean

all: mercury

cleans = mercury-clean

.PHONY: $(cleans)

cleans: mercury-clean

mercury:
	$(MAKE) -C $(MERCURY_BASE)/mercury

mercury-clean:
	$(MAKE) -C $(MERCURY_BASE)/mercury distclean

samples:
	$(MAKE) -C $(MERCURY_BASE)/samples

clean: cleans

distclean:
	find $(MERCURY_BUILD) -name obj -type d -print0 | xargs -0 rm -rf
	find $(MERCURY_BUILD) -name .dep -type d -print0 | xargs -0 rm -rf
	find $(MERCURY_BUILD) -name bin -type d -print0 | xargs -0 rm -rf
