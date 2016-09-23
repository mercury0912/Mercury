#
# Makefile
#
# Makefile for mercury
#

include $(MERCURY_BASE)/build-config/rules/global.mk

target = mercury
target_version = 1
sub-components:=core net
INCLUDE += $(foreach p,$(sub-components),-I$(MERCURY_BASE)/$(COMPONENT)/$(p)/$(INCDIR))

srcs :=$(foreach sub-component, $(sub-components), $(wildcard $(sub-component)/src/*))
srcs :=$(notdir $(srcs))
objects =$(basename $(srcs))
nullstring:=
space:=$(nullstring) #end of the line
VPATH = $(subst $(space),:,$(patsubst %,%/src,$(sub-components)))

include $(MERCURY_BASE)/build-config/rules/exec.mk
