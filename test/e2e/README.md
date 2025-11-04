# End-to-End (E2E) Tests

This directory contains end-to-end tests that verify the package works correctly in real-world scenarios.

## Why E2E Tests?

E2E tests ensure that:
- ✅ The package installs correctly
- ✅ The CLI command is executable
- ✅ The package works across different Node.js versions
- ✅ The package behaves correctly in various scenarios
- ✅ Both CLI and programmatic API work as expected

## Test Approaches

### 1. Local E2E Tests (Quick & Simple)

**File**: `local-e2e-test.sh`

Runs tests on your local machine without Docker. Fast but only tests your current Node version.

```bash
# Run from project root
./test/e2e/local-e2e-test.sh

# Or via npm script
pnpm run test:e2e:local
```

**Tests:**
- ✓ CLI with valid package.json
- ✓ CLI with missing package.json (error handling)
- ✓ CLI with missing version field (error handling)
- ✓ Programmatic API basic usage
- ✓ Programmatic API with custom `cwd`
- ✓ Multiple packages with different versions (monorepo-like)

### 2. Docker E2E Tests (Comprehensive)

**File**: `run-e2e-tests.sh`

Runs tests in Docker containers across multiple Node.js versions (18, 20, 22). Slower but more thorough.

```bash
# Run from project root
./test/e2e/run-e2e-tests.sh

# Or via npm script
pnpm run test:e2e:docker
```

**Additional tests:**
- ✓ All local tests, plus:
- ✓ Tests on Node.js 18
- ✓ Tests on Node.js 20
- ✓ Tests on Node.js 22
- ✓ Clean environment testing (no pre-installed dependencies)
- ✓ Integration with pnpm

## Best Practices

### Why Docker?

Using Docker for E2E tests is a **best practice** because:

1. **Clean Environment**: Each test runs in a fresh container with no previous state
2. **Version Testing**: Easy to test across multiple Node.js versions
3. **CI/CD Ready**: Same tests work locally and in CI pipelines
4. **Reproducibility**: Tests behave identically across different machines
5. **Isolation**: No pollution of your local environment

### When to Use Each

| Scenario | Recommended Test |
|----------|------------------|
| Quick feedback during development | Local E2E |
| Pre-commit verification | Local E2E |
| Before publishing | Docker E2E |
| CI/CD pipeline | Docker E2E |
| Testing specific Node version | Docker E2E |

## Running in CI/CD

The Docker tests are integrated into the GitHub Actions workflow:

```yaml
# .github/workflows/ci.yml includes:
- name: Run E2E Tests (Docker)
  run: ./test/e2e/run-e2e-tests.sh
```

## What Gets Tested

### Installation Scenarios
- Global installation (`npm install -g`)
- Local installation as dependency
- Package from tarball (simulates npm registry)

### CLI Testing
- Command availability (`which pnpm-version`)
- Version output correctness
- Error handling (missing files, missing version)
- Exit codes

### API Testing
- Default usage (`getVersion()`)
- Custom directory (`getVersion({cwd: '/path'})`)
- Error conditions

### Real-World Scenarios
- Monorepo-like structure
- Different packages with different versions
- Integration with pnpm

## Requirements

### Local Tests
- Node.js 18+
- npm or pnpm
- bash

### Docker Tests
- Docker installed and running
- Sufficient disk space (~500MB for Node images)

## Troubleshooting

### Docker tests fail to start
```bash
# Check if Docker is running
docker ps

# Try pulling images manually
docker pull node:18-alpine
docker pull node:20-alpine
docker pull node:22-alpine
```

### Permission denied
```bash
# Make scripts executable
chmod +x test/e2e/*.sh
```

### Tests fail locally but not in Docker
This usually indicates environment-specific issues. Docker tests are the source of truth.

## Adding New Tests

To add new test scenarios:

1. Add test case to `local-e2e-test.sh` for quick iteration
2. Add corresponding test to `Dockerfile` for cross-version testing
3. Update this README with the new test description
4. Ensure tests clean up after themselves

Example test structure:
```bash
echo -e "${BLUE}Test N: Description${NC}"
# ... test code ...
if [ condition ]; then
  echo -e "${GREEN}✓ Test N passed${NC}"
else
  echo -e "${RED}✗ Test N failed${NC}"
  exit 1
fi
```

