# 🏪 Winget Publication - Complete Guide

## ✅ What's Ready

Your Winget manifests are now **completely prepared** and ready for submission! Here's what we've set up:

### 📁 Manifest Files (in `winget/` folder):
- ✅ `Ashish.AshishCLI.yaml` - Version manifest
- ✅ `Ashish.AshishCLI.installer.yaml` - Installer configuration  
- ✅ `Ashish.AshishCLI.locale.en-US.yaml` - Package metadata
- ✅ SHA256 Hash: `49399D3ECF14169513B5750FA0F0366D0AC6F4AD870065BA73244D1C346E1D39`

### 🎯 Binary Ready:
- ✅ `dist/ashish.exe` - Standalone executable (verified)
- ✅ SHA256 calculated and embedded in manifests
- ✅ Portable installer type configured

## 🚀 Publication Process

### Step 1: Create GitHub Repository (5 minutes)

```bash
# Create repository on GitHub.com with name: ashish-cli
# Then connect your local repo:
git remote add origin https://github.com/YOUR_USERNAME/ashish-cli.git
git push -u origin main
```

### Step 2: Create GitHub Release (3 minutes)

1. Go to your GitHub repository
2. Click **Releases** → **Create a new release**
3. **Tag**: `v1.0.0`
4. **Title**: `Ashish CLI v1.0.0 - Initial Release`
5. **Upload file**: `dist/ashish.exe`
6. **Publish release**

### Step 3: Update Manifest URLs (2 minutes)

Run this script to update your GitHub username in manifests:

```powershell
.\update-winget-manifests.ps1
```

Or manually replace `YOUR_USERNAME` with your actual GitHub username in:
- `winget/Ashish.AshishCLI.installer.yaml`
- `winget/Ashish.AshishCLI.locale.en-US.yaml`

### Step 4: Submit to Winget (Choose One Method)

#### Method A: Using WinGet Create Tool (Easiest)

```powershell
# Install the tool
winget install Microsoft.WingetCreate

# Generate and submit (replace with your actual URL)
wingetcreate new https://github.com/YOUR_USERNAME/ashish-cli/releases/download/v1.0.0/ashish.exe
```

#### Method B: Manual GitHub Pull Request

1. **Fork the repository**: https://github.com/microsoft/winget-pkgs
2. **Create folder structure**:
   ```
   manifests/a/Ashish/AshishCLI/1.0.0/
   ```
3. **Copy your manifest files** to this folder
4. **Create Pull Request** with title: "Add Ashish.AshishCLI version 1.0.0"

## 📋 Manifest Validation

Before submission, validate your manifests:

```powershell
# Install WinGet CLI (if not already installed)
# Then validate manifests
winget validate winget/
```

## 🎯 What Happens After Submission

1. **Automated Tests**: Microsoft runs automated validation
2. **Review Process**: Usually takes 1-7 days
3. **Publication**: Once approved, available via `winget install Ashish.AshishCLI`
4. **Usage**: Users can install with:
   ```cmd
   winget install Ashish.AshishCLI
   ```

## 🔧 Your Manifest Configuration

### Package Details:
- **Package ID**: `Ashish.AshishCLI`
- **Publisher**: Ashish
- **License**: MIT
- **Architecture**: x64 (Windows 10+)
- **Install Type**: Portable (no admin required)
- **Command**: `ashish` (available in PATH)

### Features Configured:
- ✅ Silent installation support
- ✅ Automatic updates via Winget
- ✅ File association with supported extensions
- ✅ Portable installation (no system changes)
- ✅ Command-line availability after install

## 📊 Expected Timeline

- **Submission**: Immediate (once you have GitHub release)
- **Initial Review**: 1-3 days (automated checks)
- **Manual Review**: 3-7 days (if needed)
- **Publication**: Available immediately after approval
- **Discovery**: Users can find it via `winget search ashish`

## 🎉 After Publication

Once approved, users can install your CLI with:

```cmd
# Install
winget install Ashish.AshishCLI

# Use immediately
ashish hello.py
ashish --help

# Update (when you release new versions)
winget upgrade Ashish.AshishCLI
```

## 📈 Marketing Your Winget Package

Add these installation methods to your README:

```markdown
## Installation

### Windows (Winget)
```cmd
winget install Ashish.AshishCLI
```

### npm (All platforms)
```bash
npm install -g ashish-cli
```
```

## 🔄 Updating Your Package

For future releases:

1. Update version in all manifest files
2. Build new executable
3. Create new GitHub release
4. Calculate new SHA256 hash
5. Update installer manifest
6. Submit updated manifests to winget-pkgs

## 🎯 Quick Checklist

Before submitting to Winget:

- ✅ GitHub repository created and public
- ✅ GitHub release v1.0.0 with ashish.exe uploaded
- ✅ Manifest files updated with your GitHub username
- ✅ SHA256 hash verified: `49399D3ECF14169513B5750FA0F0366D0AC6F4AD870065BA73244D1C346E1D39`
- ✅ Manifests validated (optional but recommended)
- ⏳ Submission to microsoft/winget-pkgs

---

**Your Ashish CLI is ready for Windows Package Manager! 🚀**

This will give Windows users a professional, one-command installation experience for your multi-language compiler tool.
