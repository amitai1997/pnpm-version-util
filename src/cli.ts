#!/usr/bin/env node

/**
 * CLI utility to get the version from package.json in the current directory
 * This provides a clean alternative to `npm version` that works with pnpm
 */

import {readFileSync} from 'node:fs'
import {resolve} from 'node:path'

interface PackageJson {
  version?: string
  name?: string
}

function getVersion(): void {
  try {
    const packageJsonPath = resolve(process.cwd(), 'package.json')
    const packageJsonContent = readFileSync(packageJsonPath, 'utf-8')
    const packageJson: PackageJson = JSON.parse(packageJsonContent)

    if (!packageJson.version) {
      console.error('Error: No version field found in package.json')
      process.exit(1)
    }

    console.log(packageJson.version)
  } catch (error) {
    if ((error as {code?: string}).code === 'ENOENT') {
      console.error('Error: No package.json found in current directory')
    } else {
      console.error(`Error reading package.json: ${(error as Error).message}`)
    }
    process.exit(1)
  }
}

getVersion()
