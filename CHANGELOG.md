# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-04

### Added
- Initial release
- CLI command to read version from package.json
- Programmatic API with `getVersion()` function
- Support for custom working directory via `cwd` option
- Comprehensive test suite (unit + integration tests)
- TypeScript support with full type definitions
- Clean output (version number only)
- Error handling for missing package.json or version field

### Features
- Zero configuration required
- Works with any package manager (npm, pnpm, yarn)
- Perfect for monorepos and CI/CD pipelines
- Node.js 18+ support

