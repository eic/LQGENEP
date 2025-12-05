# 64-bit Support for LQGENEP

This document describes the 64-bit port of LQGENEP and how to use it.

## Overview

LQGENEP has been ported to support both 32-bit and 64-bit systems. The original code relied on CERNLIB libraries (PDFLIB, HBOOK, etc.) which are only available for 32-bit systems. The 64-bit port provides compatibility layers to replace these dependencies.

## Building

### 64-bit Build (Recommended for Modern Systems)

```bash
make 64bit
```

This will build the 64-bit version using:
- `gfortran` for Fortran compilation
- `g++` for C++ compilation
- Built-in simple PDF parameterization (when LHAPDF is not available)
- Custom numerical integration routines
- PYTHIA6 for event generation

### 32-bit Build (Legacy)

```bash
make 32bit
```

This requires:
- 32-bit `gfortran` (or `f77`)
- CERNLIB libraries: `pdflib804`, `packlib`, `mathlib`

### Building with LHAPDF (Optional, Recommended for Production)

If you have LHAPDF6 installed:

```bash
# Ensure lhapdf-config is in PATH
make 64bit
```

The Makefile will automatically detect LHAPDF and use it instead of the simple PDF.

## Docker Builds

### 64-bit Docker Image

```bash
docker build -f Dockerfile.64bit -t lqgenep:64bit .
docker run --rm -v $PWD:/work -w /work lqgenep:64bit
```

### 32-bit Docker Image (Legacy)

```bash
docker build --platform linux/386 -f Dockerfile -t lqgenep:32bit .
docker run --platform linux/386 --rm -v $PWD:/work -w /work lqgenep:32bit
```

## PDF Implementation

The 64-bit version uses different PDF implementations:

### With LHAPDF6 (Recommended)
- Uses modern LHAPDF6 library
- Supports many PDF sets (CTEQ, MMHT, NNPDF, etc.)
- Best accuracy and compatibility

### Without LHAPDF (Built-in Simple PDF)
- Uses a simple built-in PDF parameterization
- Approximates Leading Order PDFs similar to CTEQ6L1
- Suitable for testing and development
- **Not recommended for production physics results**

### Legacy 32-bit (PDFLIB)
- Uses CERNLIB PDFLIB library
- Original PDF implementation
- Only available on 32-bit systems

## Numerical Differences

The 64-bit port may produce slightly different results compared to the 32-bit version due to:

1. **Different PDF implementations**: Simple PDF vs PDFLIB, or LHAPDF vs PDFLIB
2. **Different integration methods**: Custom DADMUL vs CERNLIB DADMUL
3. **Floating-point precision**: 64-bit systems may handle arithmetic differently
4. **Random number generation**: PYTHIA's random number generator may behave slightly differently

To minimize differences:
- Use LHAPDF6 with the same PDF set as PDFLIB (e.g., CTEQ6L1)
- Use the same random seed
- Compare statistical distributions rather than event-by-event

## Testing

A test script is provided to compare outputs:

```bash
./test_compare.sh <number_of_events>
```

This will:
- Run both 32-bit and 64-bit versions (if available)
- Generate output files
- Compare event counts and structure
- Show sample events

## Components

### Core Files
- `LQguser.f` - Main program
- `lqgenep.f` - Event generator core
- `extrafiles/pythia6156.f` - PYTHIA6 library

### 64-bit Compatibility Layer
- `cernlib_compat.f` - Fortran stubs for CERNLIB functions
- `lhapdf_wrap.cpp` - C++ wrapper for LHAPDF6
- `simple_pdf.f` - Built-in simple PDF parameterization

### Build System
- `Makefile` - Build system for both architectures
- `Dockerfile.64bit` - 64-bit Docker build
- `Dockerfile` - 32-bit Docker build (legacy)

### Testing
- `test_compare.sh` - Compare 32-bit and 64-bit outputs
- `.github/workflows/ci.yml` - Automated CI testing

## Recommendations

### For Production Use
1. Use 64-bit build with LHAPDF6 installed
2. Install a suitable PDF set (e.g., `cteq6l1`)
3. Validate results against reference calculations
4. Use sufficient statistics for meaningful comparisons

### For Development/Testing
1. Use 64-bit build with built-in simple PDF
2. Use small number of events for quick testing
3. Remember that absolute values may differ from production runs

### For Reproducibility
1. Keep 32-bit Docker image for legacy comparisons
2. Document the PDF set and version used
3. Record the exact software versions
4. Use fixed random seeds when comparing runs

## Known Limitations

1. **Simple PDF Accuracy**: The built-in simple PDF is a basic approximation. For physics results, use LHAPDF.

2. **Integration Precision**: The custom DADMUL implementation uses simpler algorithms than CERNLIB. Results should be statistically equivalent but may have different numerical precision.

3. **Histogram Functions**: HBOOK functions are stubbed out. External tools should be used for histogram analysis.

## Future Improvements

1. **LHAPDF Integration**: Add automated LHAPDF installation to Docker builds
2. **PDF Validation**: Add validation tests comparing PDF outputs
3. **Performance Optimization**: Optimize numerical integration routines
4. **Documentation**: Add more examples and use cases

## Support

For issues or questions:
- Check the main README.md for general usage
- Review GitHub issues for known problems
- Open a new issue with detailed information about your build environment
