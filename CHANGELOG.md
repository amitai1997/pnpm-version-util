# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive E2E (end-to-end) testing with Docker support
- Local E2E tests for quick development feedback
- Docker-based E2E tests across Node.js 18, 20, and 22
- Test coverage for installation, CLI, and programmatic API usage
- Enhanced package.json exports for better CJS/ESM compatibility
- Automated E2E testing in CI/CD pipeline
- Detailed E2E testing documentation

### Changed
- Updated `prepublishOnly` script to run all tests including E2E
- Improved package exports to support both CommonJS and ESM
- Enhanced CI workflow with dedicated Docker testing job

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

