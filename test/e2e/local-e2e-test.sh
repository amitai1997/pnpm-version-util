#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Running Local E2E Tests (No Docker)${NC}"

# Get to project root
cd "$(dirname "$0")/../.."

# Build the package
echo -e "${BLUE}📦 Building package...${NC}"
pnpm run build

# Create a temporary directory for testing
TEST_DIR=$(mktemp -d)
trap "rm -rf $TEST_DIR" EXIT

echo -e "${BLUE}📁 Test directory: $TEST_DIR${NC}"

# Pack the package
echo -e "${BLUE}📦 Creating package tarball...${NC}"
TARBALL=$(npm pack --silent)
echo -e "${GREEN}✓ Created: $TARBALL${NC}"

# Test 1: CLI with valid package.json
echo -e "${BLUE}Test 1: CLI with valid package.json${NC}"
cp "$TARBALL" "$TEST_DIR/"
cd "$TEST_DIR"
echo '{"name":"test-app","version":"5.6.7"}' > package.json
npm install -g "./$TARBALL" > /dev/null 2>&1
OUTPUT=$(pnpm-version)
if [ "$OUTPUT" = "5.6.7" ]; then
  echo -e "${GREEN}✓ Test 1 passed: CLI outputs correct version${NC}"
else
  echo -e "${RED}✗ Test 1 failed: Expected '5.6.7', got '$OUTPUT'${NC}"
  exit 1
fi

# Test 2: CLI with missing package.json
echo -e "${BLUE}Test 2: CLI with missing package.json${NC}"
mkdir -p "$TEST_DIR/no-package"
cd "$TEST_DIR/no-package"
if pnpm-version 2>&1 | grep -q "No package.json found"; then
  echo -e "${GREEN}✓ Test 2 passed: Correct error for missing package.json${NC}"
else
  echo -e "${RED}✗ Test 2 failed: Expected error message not found${NC}"
  exit 1
fi

# Test 3: CLI with package.json without version
echo -e "${BLUE}Test 3: CLI with package.json without version${NC}"
mkdir -p "$TEST_DIR/no-version"
cd "$TEST_DIR/no-version"
echo '{"name":"test"}' > package.json
if pnpm-version 2>&1 | grep -q "No version field found"; then
  echo -e "${GREEN}✓ Test 3 passed: Correct error for missing version${NC}"
else
  echo -e "${RED}✗ Test 3 failed: Expected error message not found${NC}"
  exit 1
fi

# Test 4: Programmatic API
echo -e "${BLUE}Test 4: Programmatic API${NC}"
mkdir -p "$TEST_DIR/api-test"
cd "$TEST_DIR/api-test"
echo '{"name":"api-test","version":"3.2.1"}' > package.json
npm install --silent "$TEST_DIR/$TARBALL" > /dev/null 2>&1
node -e "
const {getVersion} = require('pnpm-version-util');
const v = getVersion();
if (v !== '3.2.1') {
  console.error('ERROR: Expected 3.2.1, got', v);
  process.exit(1);
}
"
echo -e "${GREEN}✓ Test 4 passed: Programmatic API works${NC}"

# Test 5: Programmatic API with custom cwd
echo -e "${BLUE}Test 5: Programmatic API with custom cwd${NC}"
cd "$TEST_DIR/api-test"
node -e "
const {getVersion} = require('pnpm-version-util');
const v = getVersion({cwd: '$TEST_DIR/api-test'});
if (v !== '3.2.1') {
  console.error('ERROR: Expected 3.2.1, got', v);
  process.exit(1);
}
"
echo -e "${GREEN}✓ Test 5 passed: API with custom cwd works${NC}"

# Test 6: Test in monorepo-like structure
echo -e "${BLUE}Test 6: Different package versions${NC}"
mkdir -p "$TEST_DIR/packages/app1"
mkdir -p "$TEST_DIR/packages/app2"
echo '{"name":"app1","version":"1.0.0"}' > "$TEST_DIR/packages/app1/package.json"
echo '{"name":"app2","version":"2.0.0"}' > "$TEST_DIR/packages/app2/package.json"

cd "$TEST_DIR/packages/app1"
OUTPUT=$(pnpm-version)
if [ "$OUTPUT" = "1.0.0" ]; then
  echo -e "${GREEN}✓ Test 6a passed: app1 version correct${NC}"
else
  echo -e "${RED}✗ Test 6a failed: Expected '1.0.0', got '$OUTPUT'${NC}"
  exit 1
fi

cd "$TEST_DIR/packages/app2"
OUTPUT=$(pnpm-version)
if [ "$OUTPUT" = "2.0.0" ]; then
  echo -e "${GREEN}✓ Test 6b passed: app2 version correct${NC}"
else
  echo -e "${RED}✗ Test 6b failed: Expected '2.0.0', got '$OUTPUT'${NC}"
  exit 1
fi

# Uninstall global package
npm uninstall -g pnpm-version-util > /dev/null 2>&1 || true

# Clean up in project root
cd - > /dev/null
rm -f pnpm-version-util-*.tgz

echo ""
echo -e "${GREEN}🎉 All local E2E tests passed!${NC}"
echo -e "${BLUE}💡 To run full Docker tests: ./test/e2e/run-e2e-tests.sh${NC}"

