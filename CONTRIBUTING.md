# Contributing to pnpm-version-util

First off, thank you for considering contributing to pnpm-version-util! 🎉

## Code of Conduct

By participating in this project, you are expected to uphold respectful and constructive communication.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples** (code snippets, commands, etc.)
- **Describe the behavior you observed and what you expected**
- **Include your environment details** (Node.js version, OS, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **Provide examples of how it would work**

### Pull Requests

1. Fork the repository
2. Create a new branch from `main`: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Write or update tests as needed
5. Ensure all tests pass: `pnpm test`
6. Update documentation if needed
7. Commit your changes with a clear commit message
8. Push to your fork: `git push origin feature/your-feature-name`
9. Open a Pull Request

## Development Setup

```bash
# Clone your fork
git clone https://github.com/amitai1997/pnpm-version-util.git
cd pnpm-version-util

# Install dependencies
pnpm install

# Run tests
pnpm test

# Build the project
pnpm run build

# Test the CLI locally
./build/cli.js
```

## Coding Standards

- **TypeScript**: This project uses TypeScript with strict mode enabled
- **Linting**: Run `pnpm run lint` before committing
- **Testing**: All new features should include tests
- **Formatting**: Code is formatted with Prettier (automatically via ESLint)

## Test Guidelines

- Write unit tests for all new functionality
- Ensure existing tests still pass
- Tests should be clear and well-documented
- Test both success and error cases

```bash
# Run all tests
pnpm test

# Run only unit tests
pnpm run test:jest -- test/unit

# Run only integration tests
pnpm run test:jest -- test/it
```

## Commit Messages

- Use clear and meaningful commit messages
- Start with a verb in the present tense (e.g., "Add", "Fix", "Update")
- Keep the first line under 72 characters
- Reference issues when applicable (e.g., "Fix #123")

Examples:
```
Add support for custom package.json paths
Fix error handling for missing version field
Update README with new installation instructions
```

## Project Structure

```
pnpm-version-util/
├── src/
│   ├── pnpm-version-util.ts  # Main library code
│   └── cli.ts                # CLI entry point
├── test/
│   ├── unit/                 # Unit tests
│   ├── it/                   # Integration tests
│   └── fixtures/             # Test fixtures
├── build/                    # Compiled output (git-ignored)
└── ...config files
```

## Questions?

Feel free to open an issue with your question, or reach out to the maintainer.

Thank you for contributing! 🙌

