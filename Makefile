# Makefile for LQGENEP - supports both 32-bit and 64-bit builds
#
# Usage:
#   make               # Build 64-bit version (default)
#   make 32bit         # Build 32-bit version with CERNLIB
#   make 64bit         # Build 64-bit version with LHAPDF
#   make clean         # Clean build artifacts

.PHONY: all clean 32bit 64bit help

# Default target
all: 64bit

help:
	@echo "LQGENEP Build System"
	@echo "===================="
	@echo ""
	@echo "Targets:"
	@echo "  make          - Build 64-bit version (default)"
	@echo "  make 64bit    - Build 64-bit version with LHAPDF"
	@echo "  make 32bit    - Build 32-bit version with CERNLIB"
	@echo "  make clean    - Clean build artifacts"
	@echo ""
	@echo "Requirements for 64-bit build:"
	@echo "  - gfortran"
	@echo "  - g++"
	@echo "  - LHAPDF6 library (optional, stub provided)"
	@echo ""
	@echo "Requirements for 32-bit build:"
	@echo "  - 32-bit gfortran (f77)"
	@echo "  - CERNLIB (pdflib804, packlib, mathlib)"

# Detect LHAPDF
LHAPDF_CONFIG := $(shell command -v lhapdf-config 2> /dev/null)

# 64-bit build settings
FC_64 = gfortran
CXX_64 = g++
FFLAGS_64 = -std=legacy -w
CXXFLAGS_64 = -std=c++11

# Check if LHAPDF is available
ifdef LHAPDF_CONFIG
    LHAPDF_CXXFLAGS = $(shell lhapdf-config --cppflags) -DUSE_LHAPDF
    LHAPDF_LDFLAGS = $(shell lhapdf-config --ldflags)
    $(info Found LHAPDF: will build with full LHAPDF support)
else
    LHAPDF_CXXFLAGS = 
    LHAPDF_LDFLAGS = 
    $(info LHAPDF not found: will build with stub implementation)
    $(info   Install LHAPDF6 for full PDF support)
endif

# 32-bit build settings (for legacy CERNLIB builds)
FC_32 = f77
FFLAGS_32 = -m32 -Wl,--copy-dt-needed-entries
LIBS_32 = -lpdflib804 -lpacklib -lmathlib

# Source files
SOURCES_F = LQguser.f lqgenep.f extrafiles/pythia6156.f
COMPAT_F = cernlib_compat.f simple_pdf.f
COMPAT_CPP = lhapdf_wrap.cpp

# Build 64-bit version
64bit: LQguser

LQguser: $(SOURCES_F) $(COMPAT_F) lhapdf_wrap.o
	@echo "Building 64-bit version..."
	$(FC_64) $(FFLAGS_64) -o $@ $(SOURCES_F) $(COMPAT_F) lhapdf_wrap.o $(LHAPDF_LDFLAGS) -lstdc++

lhapdf_wrap.o: $(COMPAT_CPP)
	@echo "Compiling LHAPDF wrapper..."
	$(CXX_64) $(CXXFLAGS_64) $(LHAPDF_CXXFLAGS) -c $< -o $@

# Build 32-bit version (requires CERNLIB)
32bit: LQguser_32bit

LQguser_32bit: $(SOURCES_F)
	@echo "Building 32-bit version with CERNLIB..."
	$(FC_32) $(FFLAGS_32) -o $@ $(SOURCES_F) $(LIBS_32)

# Clean build artifacts
clean:
	rm -f LQguser LQguser_32bit lhapdf_wrap.o
	rm -f *.o *.mod
	rm -f fort.* 
	rm -f *.histo
	rm -f LQGENEP_output.txt
	@echo "Build artifacts cleaned"

# Test targets
test-64bit: 64bit
	@echo "Running 64-bit test..."
	./LQguser

test-32bit: 32bit
	@echo "Running 32-bit test..."
	./LQguser_32bit

.PHONY: test-64bit test-32bit
