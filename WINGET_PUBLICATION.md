# Winget Publication Guide for Ashish CLI

## Current Status
Your Winget manifests are prepared but need some updates for successful publication.

## Option 1: Direct npm Installation (Recommended)

Update the installer manifest to use npm directly, which is simpler and more reliable:

```yaml
# Ashish.AshishCLI.installer.yaml
PackageIdentifier: Ashish.AshishCLI
PackageVersion: 1.0.0
Platform:
- Windows.Desktop
MinimumOSVersion: 10.0.0.0
InstallerType: portable
Scope: user
InstallModes:
- interactive
- silent
UpgradeBehavior: install
Commands:
- ashish
Dependencies:
  PackageDependencies:
  - PackageIdentifier: OpenJS.NodeJS
    MinimumVersion: 14.0.0
Installers:
- Architecture: neutral
  InstallerType: portable
  InstallerUrl: https://www.npmjs.com/package/ashish-cli
  InstallerSha256: # Not needed for npm packages
  InstallModes:
  - interactive
  InstallerSwitches:
    Custom: npm install -g ashish-cli
ManifestType: installer
ManifestVersion: 1.6.0
```

## Option 2: GitHub Release Binary (Better for Winget)

This approach uses your standalone executable from GitHub releases:

### Steps:

1. **Create GitHub Repository** (if not done yet):
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/ashish-cli.git
   git push -u origin main
   ```

2. **Create GitHub Release**:
   - Go to GitHub repository → Releases
   - Create new release with tag `v1.0.0`
   - Upload your `dist/ashish.exe` file
   - Get the download URL and SHA256

3. **Update Installer Manifest**:
   ```yaml
   Installers:
   - Architecture: x64
     InstallerUrl: https://github.com/YOUR_USERNAME/ashish-cli/releases/download/v1.0.0/ashish.exe
     InstallerSha256: <ACTUAL_SHA256_OF_EXE_FILE>
     InstallerType: portable
   ```

## Submission Process

### Method 1: Using WinGet Create Tool

1. **Install WinGet Create**:
   ```powershell
   winget install Microsoft.WingetCreate
   ```

2. **Generate Manifests**:
   ```powershell
   wingetcreate new https://github.com/YOUR_USERNAME/ashish-cli/releases/download/v1.0.0/ashish.exe
   ```

3. **Submit to Microsoft**:
   ```powershell
   wingetcreate submit --token YOUR_GITHUB_TOKEN manifests/a/Ashish/AshishCLI/1.0.0/
   ```

### Method 2: Manual GitHub PR

1. **Fork the winget-pkgs repository**:
   ```
   https://github.com/microsoft/winget-pkgs
   ```

2. **Create folder structure**:
   ```
   manifests/a/Ashish/AshishCLI/1.0.0/
   ├── Ashish.AshishCLI.installer.yaml
   ├── Ashish.AshishCLI.locale.en-US.yaml
   └── Ashish.AshishCLI.yaml
   ```

3. **Submit Pull Request** to microsoft/winget-pkgs

## Updated Manifest Files

I'll create the corrected manifest files for you:
