# Publishing Guide

This document outlines the steps to publish `pnpm-version-util` as an open-source package.

## ✅ Pre-Publishing Checklist

### Repository Setup

- [ ] Create a new GitHub repository: `https://github.com/amitaisalmon/pnpm-version-util`
- [ ] Push the code to GitHub:
  ```bash
  git init
  git add .
  git commit -m "Initial commit"
  git branch -M main
  git remote add origin https://github.com/amitaisalmon/pnpm-version-util.git
  git push -u origin main
  ```

### NPM Account Setup

- [ ] Create an NPM account at https://www.npmjs.com/signup (if you don't have one)
- [ ] Login to NPM locally:
  ```bash
  npm login
  ```
- [ ] Verify you're logged in:
  ```bash
  npm whoami
  ```

### Pre-Publish Verification

- [ ] Run tests: `pnpm test` ✅ (Already passing)
- [ ] Build the project: `pnpm run build` ✅ (Already working)
- [ ] Test the CLI locally: `./build/cli.js` ✅ (Already working)
- [ ] Review `package.json` for correct metadata ✅ (Already updated)
- [ ] Ensure version number is correct (currently 1.0.0) ✅

## 📦 Publishing to NPM

### First Time Publication

```bash
# Make sure everything is built and tested
pnpm run build
pnpm test

# Publish to NPM
pnpm publish

# Or if using npm
npm publish
```

### GitHub Actions Setup (Optional but Recommended)

To enable automatic publishing on releases:

1. Generate an NPM token:
   - Go to https://www.npmjs.com/settings/YOUR_USERNAME/tokens
   - Click "Generate New Token" → "Automation"
   - Copy the token

2. Add the token to GitHub Secrets:
   - Go to your GitHub repo → Settings → Secrets and variables → Actions
   - Click "New repository secret"
   - Name: `NPM_TOKEN`
   - Value: Paste your NPM token

3. Create a release on GitHub:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
   - Or create a release through the GitHub UI
   - The publish workflow will automatically run

## 🚀 Post-Publishing Tasks

- [ ] Verify the package is available on NPM: https://www.npmjs.com/package/pnpm-version-util
- [ ] Test installation globally:
  ```bash
  npm install -g pnpm-version-util
  pnpm-version
  ```
- [ ] Update GitHub repository:
  - Add topics/tags: `pnpm`, `cli`, `version`, `package-json`, `monorepo`
  - Add description: "Simple CLI utility to read package version from package.json"
  - Enable Issues
  - Consider enabling Discussions

## 📝 Future Releases

When releasing new versions:

1. Update `CHANGELOG.md` with new changes
2. Update version in `package.json`:
   ```bash
   npm version patch  # for bug fixes
   npm version minor  # for new features
   npm version major  # for breaking changes
   ```
3. Commit and push changes
4. Create a new GitHub release/tag
5. Publish to NPM (or let GitHub Actions do it automatically)

## 🔍 Verification Commands

After publishing, verify everything works:

```bash
# Install globally
npm install -g pnpm-version-util

# Test the command
pnpm-version

# Test in a project directory with package.json
cd /path/to/some/project
pnpm-version

# Uninstall if needed
npm uninstall -g pnpm-version-util
```

## 📊 Package Statistics

After publishing, you can track your package stats:
- NPM package page: https://www.npmjs.com/package/pnpm-version-util
- NPM stats: https://npm-stat.com/charts.html?package=pnpm-version-util
- GitHub insights: https://github.com/amitaisalmon/pnpm-version-util/pulse

## 🛟 Troubleshooting

### Publishing fails with 403 Forbidden
- Make sure you're logged in: `npm whoami`
- Check that the package name isn't taken: https://www.npmjs.com/package/pnpm-version-util
- Verify you have permission to publish

### Package name is taken
- Choose a different name in `package.json`
- Consider using a scoped package: `@yourusername/pnpm-version-util`

### Build fails
- Clean and rebuild: `pnpm run clean && pnpm run build`
- Delete `node_modules` and reinstall: `rm -rf node_modules && pnpm install`

---

**Note:** All the code is ready to publish! Just follow the checklist above. 🚀

