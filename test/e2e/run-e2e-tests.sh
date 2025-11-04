#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting E2E Tests${NC}"

# Get to project root
cd "$(dirname "$0")/../.."

# Build the package
echo -e "${BLUE}📦 Building package...${NC}"
pnpm run build

# Pack the package
echo -e "${BLUE}📦 Creating package tarball...${NC}"
npm pack

# Get the tarball name
TARBALL=$(ls pnpm-version-util-*.tgz | head -n 1)
echo -e "${GREEN}✓ Created: $TARBALL${NC}"

# Node versions to test
NODE_VERSIONS=("18" "20" "22")

# Run tests for each Node version
for NODE_VERSION in "${NODE_VERSIONS[@]}"; do
  echo ""
  echo -e "${BLUE}🐳 Testing on Node.js v$NODE_VERSION...${NC}"
  
  docker build \
    --build-arg NODE_VERSION=$NODE_VERSION \
    -t pnpm-version-util-test:node$NODE_VERSION \
    -f test/e2e/Dockerfile \
    .
  
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Node.js v$NODE_VERSION: All tests passed!${NC}"
  else
    echo -e "${RED}❌ Node.js v$NODE_VERSION: Tests failed!${NC}"
    exit 1
  fi
done

# Clean up
echo ""
echo -e "${BLUE}🧹 Cleaning up...${NC}"
rm -f pnpm-version-util-*.tgz

echo ""
echo -e "${GREEN}🎉 All E2E tests passed across all Node versions!${NC}"

