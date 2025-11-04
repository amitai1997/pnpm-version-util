import {describe, it, expect} from '@jest/globals'
import {getVersion} from '../../src/pnpm-version-util.js'
import {resolve, dirname} from 'node:path'
import {fileURLToPath} from 'node:url'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

describe('getVersion', () => {
  it('should get version from package.json in current directory', () => {
    const version = getVersion()
    expect(version).toBe('1.0.0')
  })

  it('should get version from specified directory', () => {
    // Test from the package root
    const packageRoot = resolve(__dirname, '../..')
    const version = getVersion({cwd: packageRoot})
    expect(version).toBe('1.0.0')
  })

  it('should throw error if package.json is not found', () => {
    const nonExistentDir = '/tmp/nonexistent-dir-' + Date.now()
    expect(() => {
      getVersion({cwd: nonExistentDir})
    }).toThrow(/No package\.json found/)
  })

  it('should throw error if version field is missing', () => {
    const fixturesDir = resolve(__dirname, '../fixtures/no-version')
    expect(() => {
      getVersion({cwd: fixturesDir})
    }).toThrow(/No version field found/)
  })
})
