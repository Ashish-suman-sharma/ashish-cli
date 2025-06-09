# Step-by-Step Winget Publication Script

Write-Host "🚀 Ashish CLI - Winget Publication Helper" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Step 1: Check if executable exists
$exePath = ".\dist\ashish.exe"
if (Test-Path $exePath) {
    Write-Host "✅ Found executable: $exePath" -ForegroundColor Green
    
    # Calculate SHA256 hash
    $hash = Get-FileHash -Path $exePath -Algorithm SHA256
    Write-Host "📋 SHA256 Hash: $($hash.Hash)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Copy this hash for your Winget manifest!" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host "❌ Executable not found at $exePath" -ForegroundColor Red
    Write-Host "Building executable..." -ForegroundColor Yellow
    npm run build
    
    if (Test-Path $exePath) {
        $hash = Get-FileHash -Path $exePath -Algorithm SHA256
        Write-Host "✅ Built successfully!" -ForegroundColor Green
        Write-Host "📋 SHA256 Hash: $($hash.Hash)" -ForegroundColor Yellow
    } else {
        Write-Host "❌ Build failed. Please check your build configuration." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "📝 Next Steps for Winget Publication:" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1. Create GitHub Repository:" -ForegroundColor White
Write-Host "   - Go to https://github.com and create new repository 'ashish-cli'" -ForegroundColor Gray
Write-Host "   - Run: git remote add origin https://github.com/YOUR_USERNAME/ashish-cli.git" -ForegroundColor Gray
Write-Host "   - Run: git push -u origin main" -ForegroundColor Gray
Write-Host ""

Write-Host "2. Create GitHub Release:" -ForegroundColor White
Write-Host "   - Go to your repository → Releases → New Release" -ForegroundColor Gray
Write-Host "   - Tag: v1.0.0" -ForegroundColor Gray
Write-Host "   - Upload: dist/ashish.exe" -ForegroundColor Gray
Write-Host "   - Publish release" -ForegroundColor Gray
Write-Host ""

Write-Host "3. Update Winget Manifest:" -ForegroundColor White
Write-Host "   - Replace YOUR_USERNAME in winget/*.yaml files" -ForegroundColor Gray
Write-Host "   - Replace REPLACE_WITH_ACTUAL_SHA256_HASH with: $($hash.Hash)" -ForegroundColor Gray
Write-Host ""

Write-Host "4. Submit to Winget:" -ForegroundColor White
Write-Host "   Method A - Using WinGet Create:" -ForegroundColor Gray
Write-Host "   - Install: winget install Microsoft.WingetCreate" -ForegroundColor Gray
Write-Host "   - Run: wingetcreate new [YOUR_GITHUB_RELEASE_URL]" -ForegroundColor Gray
Write-Host ""
Write-Host "   Method B - Manual PR:" -ForegroundColor Gray
Write-Host "   - Fork: https://github.com/microsoft/winget-pkgs" -ForegroundColor Gray
Write-Host "   - Add manifests to: manifests/a/Ashish/AshishCLI/1.0.0/" -ForegroundColor Gray
Write-Host "   - Create Pull Request" -ForegroundColor Gray
Write-Host ""

Write-Host "🎯 Quick Commands:" -ForegroundColor Cyan
Write-Host "=================" -ForegroundColor Cyan
Write-Host ""

# Create a quick replacement script
$replaceScript = @"
# Replace placeholders in Winget manifests
`$username = Read-Host "Enter your GitHub username"
`$hash = "$($hash.Hash)"

Get-ChildItem winget\*.yaml | ForEach-Object {
    `$content = Get-Content `$_.FullName -Raw
    `$content = `$content -replace "YOUR_USERNAME", `$username
    `$content = `$content -replace "REPLACE_WITH_ACTUAL_SHA256_HASH", `$hash
    Set-Content `$_.FullName `$content
    Write-Host "Updated `$(`$_.Name)" -ForegroundColor Green
}

Write-Host "All manifests updated!" -ForegroundColor Green
"@

$replaceScript | Out-File -FilePath ".\update-winget-manifests.ps1" -Encoding UTF8
Write-Host "Created helper script: update-winget-manifests.ps1" -ForegroundColor Green
Write-Host "Run this script after creating your GitHub repository!" -ForegroundColor White
Write-Host ""

Write-Host "📞 Need Help?" -ForegroundColor Cyan
Write-Host "=============" -ForegroundColor Cyan
Write-Host "Winget Documentation: https://docs.microsoft.com/en-us/windows/package-manager/" -ForegroundColor Gray
Write-Host "Winget Packages Repo: https://github.com/microsoft/winget-pkgs" -ForegroundColor Gray
Write-Host ""

Write-Host "🎉 Your CLI tool is ready for Winget distribution!" -ForegroundColor Green
