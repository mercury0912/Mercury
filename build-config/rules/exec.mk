#
# exec
#
# Rule definitions for building executables
#

#
# Target names
#
EXEC_DEBUG_STATIC = $(BINPATH)/static/$(target)d
EXEC_DEBUG_SHARED = $(BINPATH)/$(target)d

#
# Include the compile rules
#
include $(MERCURY_BASE)/build-config/rules/compile.mk

clean:
	$(RM) $(OBJPATH)
	$(RM) $(EXEC_DEBUG_STATIC) $(EXEC_DEBUG_SHARED)

distclean: clean
	$(RM) $(BINPATH)
	$(RM) $(DEPPATH)

#
# Rules for creating an executable
#
static_debug: $(OBJPATH_DEBUG_STATIC) $(BINPATH)/static $(DEPPATH) $(EXEC_DEBUG_STATIC)
shared_debug: $(OBJPATH_DEBUG_SHARED) $(BINPATH) $(DEPPATH) $(EXEC_DEBUG_SHARED)

$(EXEC_DEBUG_STATIC): $(foreach o,$(objects), $(OBJPATH_DEBUG_STATIC)/$(o).o)
	@echo "** Building executable (debug)" $@
	$(LINK) $(LINKFLAGS) $(DEBUGOPT_LINK) $(STATICOPT_LINK) -o $@ $^
	$(postbuild)

$(EXEC_DEBUG_SHARED): $(foreach o,$(objects), $(OBJPATH_DEBUG_SHARED)/$(o).o)
	@echo "** Building executable (debug)" $@
	$(LINK) $(LINKFLAGS) $(DEBUGOPT_LINK) $(SHARED_LINK) -o $@ $^
	$(postbuild)
#
# Include the automatically generated dependency files
#
sinclude $(addprefix $(DEPPATH)/, $(addsuffix .d, $(objects)))
