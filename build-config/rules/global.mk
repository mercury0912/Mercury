#
# global
#
# Global build configuration
#
# Environment variables:
# MERCURY_BASE:    Path to mercury source tree. Must be defined.
# MERCURY_BUILD:   Path to directory where build files are put.
#                  Defaults to $(MERCURY_BASE).
# MERCURY_CONFIG:  Build configuration to use.
#                  Defaults to `uname`.

#
# Check for MERCURY_BASE
#
ifndef MERCURY_BASE
$(error MERCURY_BASE is not defined.)
endif

#
# Check for MERCURY_BUILD
#
ifndef MERCURY_BUILD
MERCURY_BUILD = $(MERCURY_BASE)/build
endif

ifeq ($(MERCURY_BASE), $(MERCURY_BUILD))
MERCURY_BUILD = $(MERCURY_BASE)/build
endif


#
# If MERCURY_CONFIG is not set, use `uname` as configuration name
#
ifndef MERCURY_CONFIG
MERCURY_CONFIG=$(shell uname)
endif

#
# Include system specific settings
#
include $(MERCURY_BASE)/build-config/config/$(MERCURY_CONFIG)

#
# Find out current component
#
COMPONENT := $(notdir $(CURDIR))

#
# Define standard directories
#
SRCDIR     = src
INCDIR     = include
LIBDIR     = lib
BINDIR     = bin
OBJDIR     = obj
DEPDIR     = .dep
LIBPATH    = $(MERCURY_BUILD)/$(LIBDIR)
BINPATH    = $(MERCURY_BUILD)/$(COMPONENT)/$(BINDIR)
OBJPATH    = $(MERCURY_BUILD)/$(COMPONENT)/$(OBJDIR)
DEPPATH    = $(MERCURY_BUILD)/$(COMPONENT)/$(DEPDIR)

#
# Determine link mode
#
ifndef LINKMODE
LINKMODE = BOTH
endif

ifeq ($(LINKMODE), SHARED)
DEFAULT_TARGET = shared_debug
endif
ifeq ($(LINKMODE), STATIC)
DEFAULT_TARGET = static_debug
endif
ifeq ($(LINKMODE), BOTH)
DEFAULT_TARGET = all_release
endif

#
# Compose object file path
#
OBJPATH_RELEASE_STATIC = $(OBJPATH)/release_static
OBJPATH_DEBUG_STATIC   = $(OBJPATH)/debug_static
OBJPATH_RELEASE_SHARED = $(OBJPATH)/release_shared
OBJPATH_DEBUG_SHARED   = $(OBJPATH)/debug_shared

#
# Compose compiler flags
#
COMMONFLAGS = $(MERCURY_FLAGS)
CFLAGS    += $(COMMONFLAGS) $(SYSFLAGS)
CXXFLAGS  += $(COMMONFLAGS) $(SYSFLAGS)
LINKFLAGS += $(COMMONFLAGS) $(SYSFLAGS)
