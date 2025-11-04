# pnpm-version-util

[![npm version](https://img.shields.io/npm/v/pnpm-version-util.svg)](https://www.npmjs.com/package/pnpm-version-util)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A simple CLI utility to read package version from `package.json` - a pnpm-friendly alternative to `npm version`.

## 🎯 Problem

Running `pnpm version` doesn't work because pnpm doesn't have a native `version` command. When it falls back to npm, it often fails due to package manager constraints or workspace configurations.

## ✨ Solution

This package provides a simple CLI that reads the version from `package.json` in the current directory. No configuration needed, just works!

## 📦 Installation

### Global Installation (Recommended)

```bash
npm install -g pnpm-version-util
# or
pnpm add -g pnpm-version-util
```

### Local Installation (For Monorepos)

```bash
pnpm add -D pnpm-version-util
```

## 🚀 Usage

### Method 1: Direct Command

After global installation:

```bash
pnpm-version
# Output: 1.0.0
```

### Method 2: Using pnpm exec (Local installation)

```bash
pnpm exec pnpm-version
# Output: 1.0.0
```

### Method 3: Add to package.json scripts

```json
{
  "scripts": {
    "version": "pnpm-version"
  }
}
```

Then run:
```bash
pnpm run version
# Output: 1.0.0
```

### Optional: Create an alias

For even shorter commands, add to your `~/.zshrc` or `~/.bashrc`:

```bash
alias pv='pnpm-version'
```

Then simply run:
```bash
pv
# Output: 1.0.0
```

## 📖 Output

Always outputs just the version number with no extra noise:
```
1.0.0
```

Clean output makes it perfect for:
- Quick version checks during development
- Scripting and automation
- CI/CD pipelines
- Git tags and release workflows

### Example: Use in scripts

```bash
# Create git tag from package version
git tag "v$(pnpm-version)"

# Use in release script
VERSION=$(pnpm-version)
echo "Releasing version $VERSION"
```

## 🔌 Programmatic API

You can also use this package programmatically in your Node.js code:

```typescript
import { getVersion } from 'pnpm-version-util';

// Get version from current directory
const version = getVersion();
console.log(version); // "1.0.0"

// Get version from specific directory
const version = getVersion({ cwd: '/path/to/package' });
console.log(version); // "2.3.4"
```

### API Types

```typescript
interface GetVersionOptions {
  /** Path to the directory containing package.json. Defaults to current working directory. */
  cwd?: string;
}

function getVersion(options?: GetVersionOptions): string
```

## 💡 Use Cases

- **Monorepo Management**: Quickly check versions of different packages
- **Release Automation**: Get version for tagging and changelog generation
- **CI/CD Pipelines**: Integrate into build and deployment scripts
- **Development**: Quick version checks without opening files

## ✅ Benefits

✅ **Zero Configuration** - Works out of the box  
✅ **Clean Output** - Just the version number, nothing else  
✅ **Fast** - Synchronous file read, instant results  
✅ **Reliable** - Comprehensive test coverage  
✅ **Flexible** - CLI + programmatic API  
✅ **TypeScript** - Full type definitions included  

## 🛠️ Requirements

- Node.js >= 18
- pnpm (optional, works with npm/yarn too)

## 🧪 Development

```bash
# Install dependencies
pnpm install

# Run tests
pnpm test

# Build
pnpm run build

# Run locally
./build/cli.js
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

MIT © [Amitai Salmon](https://github.com/amitai1997)

## 🐛 Issues

Found a bug or have a suggestion? Please [open an issue](https://github.com/amitai1997/pnpm-version-util/issues).

## ⭐ Show your support

Give a ⭐️ if this project helped you!
