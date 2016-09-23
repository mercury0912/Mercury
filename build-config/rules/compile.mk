#
# compile
#
# Compile rule definitions for makefiles
#

#
# Targets
#
.PHONY: all static_debug shared_debug all_release \
        static_release shared_release

all: $(DEFAULT_TARGET)
all_release: static_release shared_release

#
# Create directories if nessary
#
.PHONY: objdirs libdirs bindirs static_bindirs
objdirs: $(OBJPATH_RELEASE_STATIC) $(OBJPATH_DEBUG_STATIC) $(OBJPATH_RELEASE_SHARED) $(OBJPATH_DEBUG_SHARED)
libdirs: objdirs $(LIBPATH)
bindirs: objdirs $(BINPATH)
static_bindirs: objdirs $(BINPATH)/static

$(OBJPATH_RELEASE_STATIC) $(OBJPATH_DEBUG_STATIC) $(OBJPATH_RELEASE_SHARED) \
$(OBJPATH_DEBUG_SHARED) $(LIBPATH) $(BINPATH) $(BINPATH)/static $(DEPPATH):
	$(MKDIR) $@

#
# Rules for compiling
#
POSTCOMPILE = @mv -f $(DEPPATH)/$*.Td $(DEPPATH)/$*.d
$(OBJPATH_DEBUG_STATIC)/%.o: %.cpp $(DEPPATH)/%.d
	@echo "** Compiling" $< "(debug, static)"
	$(CXX) $(DEPFLAGS) $(INCLUDE) $(CXXFLAGS) $(DEBUGOPT_CXX) -c $< -o $@
	$(POSTCOMPILE)

$(OBJPATH_DEBUG_STATIC)/%.o: %.c $(DEPPATH)/%.d
	@echo "** Compiling" $< "(debug, static)"
	$(CC) $(DEPFLAGS) $(INCLUDE) $(CFLAGS) $(DEBUGOPT_CC) -c $< -o $@
	$(POSTCOMPILE)

$(OBJPATH_DEBUG_SHARED)/%.o: %.cpp $(DEPPATH)/%.d
	@echo "** Compiling" $< "(debug, shared)"
	$(CXX) $(DEPFLAGS) $(INCLUDE) $(CXXFLAGS) $(DEBUGOPT_CXX) $(SHAREDOPT_CXX) -c $< -o $@
	$(POSTCOMPILE)

$(OBJPATH_DEBUG_SHARED)/%.o: %.c $(DEPPATH)/%.d
	@echo "** Compiling" $< "(debug, shared)"
	$(CC) $(DEPFLAGS) $(INCLUDE) $(CFLAGS) $(DEBUGOPT_CC) $(SHAREDOPT_CC) -c $< -o $@
	$(POSTCOMPILE)

#
# Rules for creating dependency information
#
$(DEPPATH)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d
