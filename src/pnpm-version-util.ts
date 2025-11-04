/**
 * Utility to get package version from package.json
 */

import {readFileSync} from 'node:fs'
import {resolve} from 'node:path'

export interface PackageJson {
  version?: string
  name?: string
  [key: string]: unknown
}

export interface GetVersionOptions {
  /** Path to the directory containing package.json. Defaults to current working directory. */
  cwd?: string
}

/**
 * Gets the version from package.json in the specified directory
 * @param options - Options for getting the version
 * @returns The version string from package.json
 * @throws Error if package.json is not found or has no version field
 */
export function getVersion(options: GetVersionOptions = {}): string {
  const {cwd = process.cwd()} = options

  const packageJsonPath = resolve(cwd, 'package.json')

  try {
    const packageJsonContent = readFileSync(packageJsonPath, 'utf-8')
    const packageJson: PackageJson = JSON.parse(packageJsonContent)

    if (!packageJson.version) {
      throw new Error('No version field found in package.json')
    }

    return packageJson.version
  } catch (error) {
    if ((error as {code?: string}).code === 'ENOENT') {
      throw new Error(`No package.json found at ${packageJsonPath}`)
    }
    throw error
  }
}
