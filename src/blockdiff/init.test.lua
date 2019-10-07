local BlockDiff = require 'src.blockdiff'
local util = require 'src.util'
local colors = require 'term.colors'
local x2b = util.format.x2b

local colormap = setmetatable({
    ['['] = tostring(colors.red),
    ['{'] = tostring(colors.green),
    ['<'] = tostring(colors.cyan),
    ['!'] = tostring(colors.onwhite),
    [']'] = tostring(colors.clear),
    ['}'] = tostring(colors.clear),
    ['>'] = tostring(colors.clear)
  }, {
    __index = function(self, key)
      return key
    end,
    __call = function(self, data)
      return data:gsub('.', function(c) return self[c] end)
    end
  })

describe('BlockDiff', function()

  assert.hex_blockdiff = function(size, original, new)
    local diff = BlockDiff(x2b(original), x2b(new), size)
    return {
      original_equals = function(expected)
        assert.are.equals('\n' .. diff:format(4).original, '\n' .. colormap(expected))
      end,

      new_equals = function(expected)
        assert.are.equals('\n' .. diff:format(4).new, '\n' .. colormap(expected))
      end,
    }
  end

  it('should color changes', function()
    local a = assert.hex_blockdiff(2,
      'AAAABBBBCCCCDDDD',
      'AAAA0000CCCCDDDD')
    a.original_equals(
      '0x00000000  AAAA [BBBB] CCCC DDDD  ..[..]....\n')
    a.new_equals(
      '0x00000000  AAAA {0000} CCCC DDDD  ..{..}....\n')
  end)

  it('should color multiple changes', function()
    local a = assert.hex_blockdiff(2,
      'AAAABBBBCCCCDDDD',
      'AAAA0000CCCC')
    a.original_equals(
      '0x00000000  AAAA [BBBB] CCCC [DDDD]  ..[..]..[..]\n')
    a.new_equals(
      '0x00000000  AAAA {0000} CCCC       ..{..}..\n')
  end)

  it('should color multiple lines', function()
    local a = assert.hex_blockdiff(2,
      'AAAABBBBCCCCDDDDAAAABBBBCCCCDDDD',
      'AAAABBBBCCCC00001111BBBBCCCCDDDD')
    a.original_equals(
      '0x00000000  AAAA BBBB CCCC [DDDD]  ......[..]\n'
    ..'0x00000008  [AAAA] BBBB CCCC DDDD  [..]......\n')
    a.new_equals(
      '0x00000000  AAAA BBBB CCCC {0000}  ......{..}\n'
    ..'0x00000008  {1111} BBBB CCCC DDDD  {..}......\n')
  end)
end)
