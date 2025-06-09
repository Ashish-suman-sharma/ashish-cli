# Ashish CLI - Universal Code Runner Test Suite

Write-Host "=== Ashish CLI - Universal Code Runner Test Suite ===" -ForegroundColor Green
Write-Host ""

Write-Host "1. Testing Python execution:" -ForegroundColor Yellow
ashish examples/hello.py
Write-Host ""

Write-Host "2. Testing C++ execution with verbose output:" -ForegroundColor Yellow
ashish examples/hello.cpp --verbose
Write-Host ""

Write-Host "3. Testing Java execution:" -ForegroundColor Yellow
ashish examples/Hello.java
Write-Host ""

Write-Host "4. Testing JavaScript execution:" -ForegroundColor Yellow
ashish examples/hello.js
Write-Host ""

Write-Host "5. Testing Go execution:" -ForegroundColor Yellow
ashish examples/hello.go
Write-Host ""

Write-Host "6. Testing Rust execution:" -ForegroundColor Yellow
ashish examples/hello.rs
Write-Host ""

Write-Host "7. Testing interactive C++ program with input file:" -ForegroundColor Yellow
ashish examples/sum.cpp -i examples/input.txt
Write-Host ""

Write-Host "8. Testing error handling (compilation error):" -ForegroundColor Yellow
ashish examples/buggy.cpp
Write-Host ""

Write-Host "9. Testing JSON output format:" -ForegroundColor Yellow
ashish examples/hello.py --json
Write-Host ""

Write-Host "10. Listing supported languages:" -ForegroundColor Yellow
ashish languages
Write-Host ""

Write-Host "11. Showing configuration:" -ForegroundColor Yellow
ashish config
Write-Host ""

Write-Host "12. Testing unsupported file extension:" -ForegroundColor Yellow
"This should fail" | Out-File -FilePath "examples/test.xyz" -Encoding UTF8
try {
    ashish examples/test.xyz
} catch {
    Write-Host "Expected error for unsupported extension" -ForegroundColor Red
}
Remove-Item -Path "examples/test.xyz" -ErrorAction SilentlyContinue
Write-Host ""

Write-Host "13. Testing file not found error:" -ForegroundColor Yellow
try {
    ashish nonexistent.py
} catch {
    Write-Host "Expected error for missing file" -ForegroundColor Red
}
Write-Host ""

Write-Host "=== Test Suite Complete! ===" -ForegroundColor Green
