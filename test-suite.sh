#!/bin/bash

echo "=== Ashish CLI - Universal Code Runner Test Suite ==="
echo ""

echo "1. Testing Python execution:"
ashish examples/hello.py
echo ""

echo "2. Testing C++ execution with verbose output:"
ashish examples/hello.cpp --verbose
echo ""

echo "3. Testing Java execution:"
ashish examples/Hello.java
echo ""

echo "4. Testing JavaScript execution:"
ashish examples/hello.js
echo ""

echo "5. Testing Go execution:"
ashish examples/hello.go
echo ""

echo "6. Testing Rust execution:"
ashish examples/hello.rs
echo ""

echo "7. Testing interactive C++ program with input file:"
ashish examples/sum.cpp -i examples/input.txt
echo ""

echo "8. Testing error handling (compilation error):"
ashish examples/buggy.cpp
echo ""

echo "9. Testing JSON output format:"
ashish examples/hello.py --json
echo ""

echo "10. Listing supported languages:"
ashish languages
echo ""

echo "11. Showing configuration:"
ashish config
echo ""

echo "12. Testing unsupported file extension:"
echo "This should fail" > examples/test.xyz
ashish examples/test.xyz 2>&1 || echo "Expected error for unsupported extension"
rm -f examples/test.xyz
echo ""

echo "13. Testing file not found error:"
ashish nonexistent.py 2>&1 || echo "Expected error for missing file"
echo ""

echo "=== Test Suite Complete! ==="
