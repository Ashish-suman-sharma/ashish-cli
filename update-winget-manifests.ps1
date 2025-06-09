# Replace placeholders in Winget manifests
$username = Read-Host "Enter your GitHub username"
$hash = "49399D3ECF14169513B5750FA0F0366D0AC6F4AD870065BA73244D1C346E1D39"

Get-ChildItem winget\*.yaml | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $content = $content -replace "YOUR_USERNAME", $username
    $content = $content -replace "REPLACE_WITH_ACTUAL_SHA256_HASH", $hash
    Set-Content $_.FullName $content
    Write-Host "Updated $($_.Name)" -ForegroundColor Green
}

Write-Host "All manifests updated!" -ForegroundColor Green
