import {describe, it, expect} from '@jest/globals'
import {getVersion} from '../../src/pnpm-version-util.js'

describe('pnpm-version-util (it)', () => {
  it('should get version from package.json', () => {
    const version = getVersion()
    expect(version).toBe('1.0.0')
  })

  it('should throw error for directory without package.json', () => {
    expect(() => {
      getVersion({cwd: '/tmp'})
    }).toThrow()
  })
})
