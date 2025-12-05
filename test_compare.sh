#!/bin/bash
#
# Test script to compare 32-bit and 64-bit outputs
# This script runs both versions with the same input and compares results
#

set -e

echo "======================================"
echo "LQGENEP 32-bit vs 64-bit Comparison"
echo "======================================"
echo ""

# Configuration
NEVENTS=${1:-10}
OUTPUT_32="output_32bit.txt"
OUTPUT_64="output_64bit.txt"

# Create test input file
cat > inputfile_compare << EOF
${NEVENTS}	1936.5	8      18	275	1000      0.011   1       0.1     1       1	1
${OUTPUT_32}
EOF

echo "Test configuration:"
echo "  Number of events: ${NEVENTS}"
echo "  Output files: ${OUTPUT_32}, ${OUTPUT_64}"
echo ""

# Run 32-bit version (if binary exists)
if [ -f "LQguser_32bit" ]; then
    echo "Running 32-bit version..."
    cp inputfile_compare inputfile
    ./LQguser_32bit > /dev/null 2>&1
    if [ -f "${OUTPUT_32}" ]; then
        echo "  ✓ 32-bit run completed: $(wc -l < ${OUTPUT_32}) lines"
        EVENTS_32=$(grep -c "^    0 " ${OUTPUT_32} || echo "0")
        echo "  ✓ Generated events: ${EVENTS_32}"
    else
        echo "  ✗ 32-bit output file not found"
        exit 1
    fi
else
    echo "⚠ 32-bit binary not found (LQguser_32bit)"
    echo "  Skipping 32-bit test"
fi
echo ""

# Run 64-bit version
if [ -f "LQguser" ]; then
    echo "Running 64-bit version..."
    # Update inputfile for 64-bit output
    cat > inputfile_compare << EOF
${NEVENTS}	1936.5	8      18	275	1000      0.011   1       0.1     1       1	1
${OUTPUT_64}
EOF
    cp inputfile_compare inputfile
    ./LQguser > /dev/null 2>&1
    if [ -f "${OUTPUT_64}" ]; then
        echo "  ✓ 64-bit run completed: $(wc -l < ${OUTPUT_64}) lines"
        EVENTS_64=$(grep -c "^    0 " ${OUTPUT_64} || echo "0")
        echo "  ✓ Generated events: ${EVENTS_64}"
    else
        echo "  ✗ 64-bit output file not found"
        exit 1
    fi
else
    echo "✗ 64-bit binary not found (LQguser)"
    exit 1
fi
echo ""

# Compare outputs if both exist
if [ -f "${OUTPUT_32}" ] && [ -f "${OUTPUT_64}" ]; then
    echo "Comparing outputs..."
    echo "================================"
    
    # Extract event headers for comparison
    grep "^    0 " ${OUTPUT_32} > events_32.tmp || true
    grep "^    0 " ${OUTPUT_64} > events_64.tmp || true
    
    NEVENTS_32=$(wc -l < events_32.tmp)
    NEVENTS_64=$(wc -l < events_64.tmp)
    
    echo "Event counts:"
    echo "  32-bit: ${NEVENTS_32}"
    echo "  64-bit: ${NEVENTS_64}"
    
    if [ "${NEVENTS_32}" -eq "${NEVENTS_64}" ]; then
        echo "  ✓ Event counts match"
    else
        echo "  ✗ Event counts differ!"
    fi
    echo ""
    
    # Compare file structures
    echo "File structure comparison:"
    HEAD_32=$(head -5 ${OUTPUT_32})
    HEAD_64=$(head -5 ${OUTPUT_64})
    
    if [ "$HEAD_32" == "$HEAD_64" ]; then
        echo "  ✓ File headers match"
    else
        echo "  ⚠ File headers differ (expected for different PDF implementations)"
    fi
    echo ""
    
    # Show first event from each
    echo "Sample event (first event, particle 8):"
    echo "32-bit:"
    grep "^    8 " ${OUTPUT_32} | head -1 || echo "  (not found)"
    echo "64-bit:"
    grep "^    8 " ${OUTPUT_64} | head -1 || echo "  (not found)"
    echo ""
    
    # Cleanup
    rm -f events_32.tmp events_64.tmp
    
    echo "================================"
    echo "Comparison complete!"
    echo ""
    echo "Note: Numerical differences are expected due to:"
    echo "  - Different PDF implementations (PDFLIB vs simple PDF)"
    echo "  - Different integration methods (CERNLIB vs custom)"
    echo "  - Potential floating-point precision differences"
    echo ""
    echo "To verify identical behavior, use same PDF set with LHAPDF"
else
    echo "Cannot compare - one or both output files missing"
fi
