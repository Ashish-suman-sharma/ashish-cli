# GitHub Repository Setup Guide

## Step 1: Create GitHub Repository

1. Go to [GitHub](https://github.com) and sign in to your account
2. Click the "+" icon in the top right corner
3. Select "New repository"
4. Fill in the repository details:
   - **Repository name**: `ashish-cli`
   - **Description**: `Universal multi-language code compiler and executor CLI tool`
   - **Visibility**: Public
   - **Initialize repository**: Leave unchecked (we have local repository)
5. Click "Create repository"

## Step 2: Connect Local Repository to GitHub

After creating the GitHub repository, run these commands in your terminal:

```bash
# Add GitHub remote origin
git remote add origin https://github.com/YOUR_USERNAME/ashish-cli.git

# Verify remote was added
git remote -v

# Push all local commits to GitHub
git push -u origin main
```

Replace `YOUR_USERNAME` with your actual GitHub username.

## Step 3: Configure Repository Settings

### Branch Protection
1. Go to repository Settings → Branches
2. Add branch protection rule for `main` branch:
   - Require pull request reviews before merging
   - Require status checks to pass before merging

### Topics and Description
1. Go to repository main page
2. Click the gear icon next to "About"
3. Add topics: `cli`, `compiler`, `multi-language`, `nodejs`, `javascript`, `automation`
4. Add website: `https://www.npmjs.com/package/ashish-cli`

### README Badges
Update the GitHub repository URL in README.md badges:
- Replace `yourusername` with your actual GitHub username
- Update issue links and support email

## Step 4: Create First Release

1. Go to repository → Releases
2. Click "Create a new release"
3. Tag version: `v1.0.0`
4. Release title: `Ashish CLI v1.0.0 - Initial Release`
5. Description:
   ```markdown
   🎉 **First stable release of Ashish CLI!**
   
   ## Features
   - ✅ Support for 19+ programming languages
   - ✅ Automatic language detection
   - ✅ Remote code execution (no local compilers needed)
   - ✅ Cross-platform compatibility (Windows, macOS, Linux)
   - ✅ Input file support for interactive programs
   - ✅ Beautiful colored terminal output
   - ✅ JSON output format option
   - ✅ Configurable API endpoints and timeouts
   
   ## Installation
   ```bash
   npm install -g ashish-cli
   ```
   
   ## Quick Start
   ```bash
   ashish hello.py
   ashish program.cpp -i input.txt
   ```
   
   See the [README](https://github.com/YOUR_USERNAME/ashish-cli#readme) for complete documentation.
   ```
6. Attach binary file: Upload `dist/ashish.exe` as release asset
7. Click "Publish release"

## Step 5: Update Package.json

Make sure the repository URL in package.json is correct:

```json
{
  "repository": {
    "type": "git",
    "url": "git+https://github.com/YOUR_USERNAME/ashish-cli.git"
  },
  "bugs": {
    "url": "https://github.com/YOUR_USERNAME/ashish-cli/issues"
  },
  "homepage": "https://github.com/YOUR_USERNAME/ashish-cli#readme"
}
```

Then update the npm package:
```bash
npm version patch
npm publish
```

## Step 6: Set up GitHub Actions (Optional)

Create `.github/workflows/ci.yml` for automated testing and releases:

```yaml
name: CI/CD

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Use Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    - run: npm ci
    - run: npm test
    
  release:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
    - uses: actions/checkout@v3
    - name: Use Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        registry-url: 'https://registry.npmjs.org'
    - run: npm ci
    - run: npm run build
    - name: Publish to npm
      run: npm publish
      env:
        NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

## Next Steps

1. **Documentation**: Keep README.md updated with new features
2. **Issues**: Monitor and respond to GitHub issues
3. **Contributions**: Review and merge pull requests
4. **Releases**: Create new releases for major updates
5. **Promotion**: Share on social media, dev communities

## Quick Commands Reference

```bash
# Check status
git status

# Add all changes
git add .

# Commit changes
git commit -m "feat: add new feature"

# Push to GitHub
git push origin main

# Create and push new tag
git tag v1.0.1
git push origin v1.0.1

# Update npm package
npm version patch
npm publish
```

---

**Note**: Replace `YOUR_USERNAME` with your actual GitHub username throughout this guide.
