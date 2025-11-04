ARG NODE_VERSION=20
FROM node:${NODE_VERSION}-alpine

WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package tarball (will be built before running)
COPY pnpm-version-util-*.tgz /tmp/package.tgz

# Test 1: Install package globally
RUN npm install -g /tmp/package.tgz

# Create a test package.json to test against
RUN echo '{"name":"test-app","version":"9.8.7"}' > package.json

# Test 2: Verify CLI command exists and is executable
RUN which pnpm-version

# Test 3: Run CLI and verify it outputs the version
RUN pnpm-version | grep -q "9.8.7" || (echo "ERROR: CLI output incorrect" && exit 1)

# Test 4: Test with missing package.json
RUN mkdir /tmp/no-package && cd /tmp/no-package && \
    (pnpm-version 2>&1 || true) | grep -q "No package.json found" || \
    (echo "ERROR: Should fail when package.json is missing" && exit 1)

# Test 5: Test with package.json without version
RUN mkdir /tmp/no-version && cd /tmp/no-version && \
    echo '{"name":"test"}' > package.json && \
    (pnpm-version 2>&1 || true) | grep -q "No version field found" || \
    (echo "ERROR: Should fail when version is missing" && exit 1)

# Test 6: Test programmatic API
RUN mkdir /tmp/api-test && cd /tmp/api-test && \
    echo '{"name":"api-test","version":"1.2.3"}' > package.json && \
    npm install /tmp/package.tgz && \
    node -e "const {getVersion} = require('pnpm-version-util'); const v = getVersion(); if (v !== '1.2.3') { console.error('ERROR: API returned wrong version:', v); process.exit(1); } console.log('✓ API test passed');"

# Test 7: Test programmatic API with custom cwd
RUN cd /tmp && \
    node -e "const {getVersion} = require('pnpm-version-util'); const v = getVersion({cwd: '/tmp/api-test'}); if (v !== '1.2.3') { console.error('ERROR: API with cwd returned wrong version:', v); process.exit(1); } console.log('✓ API with cwd test passed');"

# Test 8: Verify package works with pnpm
RUN cd /app && pnpm exec pnpm-version | grep -q "9.8.7" || (echo "ERROR: pnpm exec failed" && exit 1)

# All tests passed!
RUN echo "✅ All e2e tests passed on Node $(node --version)!"

CMD ["echo", "E2E tests completed successfully"]

