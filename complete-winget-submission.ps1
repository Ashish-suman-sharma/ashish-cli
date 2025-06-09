# 🚀 Complete Winget Submission - Automated Script

param(
    [Parameter(Mandatory=$true)]
    [string]$GitHubUsername,
    
    [Parameter(Mandatory=$false)]
    [string]$GitHubToken = ""
)

Write-Host "🚀 Ashish CLI - Complete Winget Submission" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Validate prerequisites
Write-Host "🔍 Checking prerequisites..." -ForegroundColor Yellow

# Check if git repository exists
if (-not (Test-Path ".git")) {
    Write-Host "❌ Git repository not found. Please run 'git init' first." -ForegroundColor Red
    exit 1
}

# Check if executable exists
if (-not (Test-Path "dist\ashish.exe")) {
    Write-Host "❌ Executable not found. Building..." -ForegroundColor Red
    npm run build
    if (-not (Test-Path "dist\ashish.exe")) {
        Write-Host "❌ Build failed. Please check your build configuration." -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Prerequisites checked" -ForegroundColor Green

# Step 2: Update manifests with GitHub username
Write-Host "📝 Updating Winget manifests..." -ForegroundColor Yellow

$manifestFiles = Get-ChildItem "winget\*.yaml"
foreach ($file in $manifestFiles) {
    $content = Get-Content $file.FullName -Raw
    $content = $content -replace "YOUR_USERNAME", $GitHubUsername
    Set-Content $file.FullName $content
    Write-Host "   Updated $($file.Name)" -ForegroundColor Gray
}

Write-Host "✅ Manifests updated with GitHub username: $GitHubUsername" -ForegroundColor Green

# Step 3: Setup GitHub remote (if not exists)
Write-Host "🔗 Setting up GitHub remote..." -ForegroundColor Yellow

$remoteExists = git remote get-url origin 2>$null
if (-not $remoteExists) {
    $repoUrl = "https://github.com/$GitHubUsername/ashish-cli.git"
    git remote add origin $repoUrl
    Write-Host "✅ Added GitHub remote: $repoUrl" -ForegroundColor Green
} else {
    Write-Host "✅ GitHub remote already exists" -ForegroundColor Green
}

# Step 4: Commit and push changes
Write-Host "📤 Pushing to GitHub..." -ForegroundColor Yellow

git add .
git commit -m "feat: update Winget manifests for publication" -q
git push -u origin main

Write-Host "✅ Code pushed to GitHub" -ForegroundColor Green

# Step 5: Instructions for GitHub Release
Write-Host ""
Write-Host "🎯 Next Steps - GitHub Release" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Go to: https://github.com/$GitHubUsername/ashish-cli/releases" -ForegroundColor White
Write-Host "2. Click 'Create a new release'" -ForegroundColor White
Write-Host "3. Set tag: v1.0.0" -ForegroundColor White
Write-Host "4. Set title: Ashish CLI v1.0.0 - Initial Release" -ForegroundColor White
Write-Host "5. Upload file: dist\ashish.exe" -ForegroundColor White
Write-Host "6. Publish release" -ForegroundColor White
Write-Host ""

# Step 6: Prepare WinGet Create command
$releaseUrl = "https://github.com/$GitHubUsername/ashish-cli/releases/download/v1.0.0/ashish.exe"
Write-Host "🛠️  Once release is created, run this command:" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "wingetcreate new `"$releaseUrl`"" -ForegroundColor Yellow
Write-Host ""

# Alternative manual submission info
Write-Host "🔄 Alternative: Manual Submission" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Fork: https://github.com/microsoft/winget-pkgs" -ForegroundColor White
Write-Host "2. Create folder: manifests/a/Ashish/AshishCLI/1.0.0/" -ForegroundColor White
Write-Host "3. Copy files from winget/ folder to the new location" -ForegroundColor White
Write-Host "4. Create Pull Request" -ForegroundColor White
Write-Host ""

# Step 7: Validation command
Write-Host "✅ Validate manifests (optional):" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "winget validate winget\" -ForegroundColor Yellow
Write-Host ""

# Summary
Write-Host "🎉 Summary" -ForegroundColor Green
Write-Host "==========" -ForegroundColor Green
Write-Host ""
Write-Host "✅ Manifests updated with your GitHub username" -ForegroundColor White
Write-Host "✅ Code pushed to GitHub repository" -ForegroundColor White
Write-Host "✅ WinGet Create tool ready for submission" -ForegroundColor White
Write-Host "⏳ GitHub release needed (manual step)" -ForegroundColor Yellow
Write-Host "⏳ Winget submission (automated once release is created)" -ForegroundColor Yellow
Write-Host ""

Write-Host "Your Ashish CLI will be available to Windows users via:" -ForegroundColor Green
Write-Host "winget install Ashish.AshishCLI" -ForegroundColor Cyan
Write-Host ""

# Create a quick reference file
$quickRef = @"
# Quick Reference - Winget Submission

## Your Package Details
- Package ID: Ashish.AshishCLI
- GitHub: https://github.com/$GitHubUsername/ashish-cli
- SHA256: 49399D3ECF14169513B5750FA0F0366D0AC6F4AD870065BA73244D1C346E1D39

## After GitHub Release
Run: wingetcreate new "https://github.com/$GitHubUsername/ashish-cli/releases/download/v1.0.0/ashish.exe"

## User Installation (after approval)
winget install Ashish.AshishCLI

## Status Check
Check submission status at: https://github.com/microsoft/winget-pkgs
"@

$quickRef | Out-File -FilePath "WINGET_REFERENCE.md" -Encoding UTF8
Write-Host "📄 Created reference file: WINGET_REFERENCE.md" -ForegroundColor Green
