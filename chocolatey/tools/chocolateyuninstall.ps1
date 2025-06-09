$ErrorActionPreference = 'Stop'

Write-Host "Uninstalling Ashish CLI..." -ForegroundColor Green

# Uninstall via npm
$npmPath = Get-Command npm -ErrorAction SilentlyContinue
if ($npmPath) {
    Start-Process -FilePath "npm" -ArgumentList "uninstall", "-g", "ashish-cli" -Wait -NoNewWindow
    Write-Host "Ashish CLI uninstalled successfully!" -ForegroundColor Green
} else {
    Write-Warning "npm not found. Please manually uninstall: npm uninstall -g ashish-cli"
}
