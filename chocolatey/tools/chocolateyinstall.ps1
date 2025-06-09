$ErrorActionPreference = 'Stop'

$packageName = 'ashish-cli'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageUrl = 'https://registry.npmjs.org/ashish-cli/-/ashish-cli-1.0.0.tgz'

# Install via npm
$npmPath = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npmPath) {
    Write-Error "Node.js and npm are required but not found. Please install Node.js first."
    exit 1
}

Write-Host "Installing Ashish CLI via npm..." -ForegroundColor Green
Start-Process -FilePath "npm" -ArgumentList "install", "-g", "ashish-cli" -Wait -NoNewWindow

# Verify installation
$ashishPath = Get-Command ashish -ErrorAction SilentlyContinue
if ($ashishPath) {
    Write-Host "Ashish CLI installed successfully!" -ForegroundColor Green
    Write-Host "You can now use: ashish filename.ext" -ForegroundColor Yellow
    Write-Host "Example: ashish hello.py" -ForegroundColor Yellow
    Write-Host "Type 'ashish --help' for more information." -ForegroundColor Yellow
} else {
    Write-Error "Installation failed. Please try manually: npm install -g ashish-cli"
}
