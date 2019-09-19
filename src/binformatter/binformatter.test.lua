local BinFormatter = require 'src.binformatter'
local util = require 'src.util'
local colors = require 'term.colors'

local colormap = setmetatable({
    ['['] = tostring(colors.red),
    ['{'] = tostring(colors.green),
    ['!'] = tostring(colors.onwhite),
    [']'] = tostring(colors.clear),
    ['}'] = tostring(colors.clear)
  }, {
    __index = function(self, key)
      return key
    end,
    __call = function(self, data)
      return data:gsub('.', function(c) return self[c] end)
    end
  })

describe('BinFormatter', function()

  assert.binformat = function(formatter)
    return {
      equals = function(actual, expected)
        assert.are.equals(formatter(actual), expected)
      end,

      hex_equals = function(actual, expected)
        assert.are.equals('\n' .. formatter(util.format.x2b(actual)), '\n' .. expected)
      end,

      colors = function(colors)
        return {
          equals = function(actual, expected)
            assert.are.equals(formatter(actual, colors), colormap(expected))
          end,

          hex_equals = function(actual, expected)
            assert.are.equals('\n' .. formatter(util.format.x2b(actual), colors), '\n' .. colormap(expected))
          end
        }
      end
    }
  end

  it('should return formatter function', function()
    local formatter = BinFormatter(8, 2)
    assert.are.equals(type(formatter), 'function')
  end)

  it('should format full line', function()
    local formatter = BinFormatter(4, 2)
    assert.binformat(formatter).hex_equals(
        'AAAABBBBCCCCDDDD',
        '0x00000000  AAAA BBBB CCCC DDDD  ........\n')
  end)

  it('should format partial line', function()
    local formatter = BinFormatter(4, 2)
    assert.binformat(formatter).hex_equals(
        'AAAABBBBCCCC',
        '0x00000000  AAAA BBBB CCCC       ......\n')
  end)

  it('should format multiple lines', function()
    local formatter = BinFormatter(4, 2)
    assert.binformat(formatter).hex_equals(
        '0123ABCD0123ABCD0123ABCD0123ABCD0123ABCD0123',
        '0x00000000  0123 ABCD 0123 ABCD  .#...#..\n'
      ..'0x00000008  0123 ABCD 0123 ABCD  .#...#..\n'
      ..'0x00000010  0123 ABCD 0123       .#...#\n')
  end)

  it('should format different block sizes', function()
    local formatter = BinFormatter(4, 3)
    assert.binformat(formatter).hex_equals(
        '0123ABCD0123ABCD0123ABCD0123AB',
        '0x00000000  0123AB CD0123 ABCD01 23ABCD  .#...#...#..\n'
      ..'0x0000000C  0123AB                       .#.\n')
  end)

  -- it('should format partial block', function()
  --   local formatter = BinFormatter(2, 3)
  --   assert.binformat(formatter).hex_equals(
  --       'AAAAAABBBB',
  --       '0x00000000  AAAAAA BBBB    .....\n')
  -- end)

  it('should show only visible characters', function()
    local data = ''
    for i = 0x00, 0xFF do
      data = data .. string.char(i)
    end

    local formatter = BinFormatter(4, 2)
    assert.binformat(formatter).equals(data,
        '0x00000000  0001 0203 0405 0607  ........\n'
      ..'0x00000008  0809 0A0B 0C0D 0E0F  ........\n'
      ..'0x00000010  1011 1213 1415 1617  ........\n'
      ..'0x00000018  1819 1A1B 1C1D 1E1F  ........\n'
      ..'0x00000020  2021 2223 2425 2627   !"#$%&\'\n'
      ..'0x00000028  2829 2A2B 2C2D 2E2F  ()*+,-./\n'
      ..'0x00000030  3031 3233 3435 3637  01234567\n'
      ..'0x00000038  3839 3A3B 3C3D 3E3F  89:;<=>?\n'
      ..'0x00000040  4041 4243 4445 4647  @ABCDEFG\n'
      ..'0x00000048  4849 4A4B 4C4D 4E4F  HIJKLMNO\n'
      ..'0x00000050  5051 5253 5455 5657  PQRSTUVW\n'
      ..'0x00000058  5859 5A5B 5C5D 5E5F  XYZ[\\]^_\n'
      ..'0x00000060  6061 6263 6465 6667  `abcdefg\n'
      ..'0x00000068  6869 6A6B 6C6D 6E6F  hijklmno\n'
      ..'0x00000070  7071 7273 7475 7677  pqrstuvw\n'
      ..'0x00000078  7879 7A7B 7C7D 7E7F  xyz{|}~.\n'
      ..'0x00000080  8081 8283 8485 8687  ........\n'
      ..'0x00000088  8889 8A8B 8C8D 8E8F  ........\n'
      ..'0x00000090  9091 9293 9495 9697  ........\n'
      ..'0x00000098  9899 9A9B 9C9D 9E9F  ........\n'
      ..'0x000000A0  A0A1 A2A3 A4A5 A6A7  ........\n'
      ..'0x000000A8  A8A9 AAAB ACAD AEAF  ........\n'
      ..'0x000000B0  B0B1 B2B3 B4B5 B6B7  ........\n'
      ..'0x000000B8  B8B9 BABB BCBD BEBF  ........\n'
      ..'0x000000C0  C0C1 C2C3 C4C5 C6C7  ........\n'
      ..'0x000000C8  C8C9 CACB CCCD CECF  ........\n'
      ..'0x000000D0  D0D1 D2D3 D4D5 D6D7  ........\n'
      ..'0x000000D8  D8D9 DADB DCDD DEDF  ........\n'
      ..'0x000000E0  E0E1 E2E3 E4E5 E6E7  ........\n'
      ..'0x000000E8  E8E9 EAEB ECED EEEF  ........\n'
      ..'0x000000F0  F0F1 F2F3 F4F5 F6F7  ........\n'
      ..'0x000000F8  F8F9 FAFB FCFD FEFF  ........\n')
  end)

  it('should color from 1', function()
    local formatter = BinFormatter(4, 1)
    assert.binformat(formatter)
      .colors({[1] = colors.red})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  [AA AA BB BB]  [....]\n'
        ..'0x00000004  [CC CC DD DD]  [....]\n')
  end)

  it('should color from middle', function()
    local formatter = BinFormatter(4, 1)
    assert.binformat(formatter)
      .colors({[3] = colors.red})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  AA AA [BB BB]  ..[..]\n'
        ..'0x00000004  [CC CC DD DD]  [....]\n')
  end)

  it('should color last', function()
    local formatter = BinFormatter(4, 1)
    assert.binformat(formatter)
      .colors({[8] = colors.red})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  AA AA BB BB  ....\n'
        ..'0x00000004  CC CC DD [DD]  ...[.]\n')
  end)

  it('should color single block', function()
    local formatter = BinFormatter(1, 1)
    assert.binformat(formatter)
      .colors({[1] = colors.red})
      .hex_equals(
          'AA',
          '0x00000000  [AA]  [.]\n')
  end)

  it('should color whole containing block', function()
    local formatter = BinFormatter(4, 3)
    assert.binformat(formatter)
      .colors({[5] = colors.red})
      .hex_equals(
          'AAABBBCCCDDDEEEFFF',
          '0x00000000  AAABBB [CCCDDD EEEFFF]         ...[......]\n')
  end)

  it('should color multiple lines', function()
    local formatter = BinFormatter(2, 2)
    assert.binformat(formatter)
      .colors({[3] = colors.red})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  AAAA [BBBB]  ..[..]\n'
        ..'0x00000004  [CCCC DDDD]  [....]\n')
  end)

  it('should switch color', function()
    local formatter = BinFormatter(4, 1)
    assert.binformat(formatter)
      .colors({[1] = colors.red, [3] = colors.green})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  [AA AA] {BB BB}  [..]{..}\n'
        ..'0x00000004  {CC CC DD DD}  {....}\n')
  end)
  
  it('should clear color', function()
    local formatter = BinFormatter(4, 1)
    assert.binformat(formatter)
      .colors({[1] = colors.red, [3] = colors.clear})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  [AA AA] BB BB  [..]..\n'
        ..'0x00000004  CC CC DD DD  ....\n')
  end)
  
  it('should sort colors', function()
    local formatter = BinFormatter(4, 1)
    assert.binformat(formatter)
      .colors({[3] = colors.green, [1] = colors.red})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  [AA AA] {BB BB}  [..]{..}\n'
        ..'0x00000004  {CC CC DD DD}  {....}\n')
  end)
  
  it('should allow mixed colors', function()
    local formatter = BinFormatter(4, 1)
    assert.binformat(formatter)
      .colors({[3] = colors.red .. colors.onwhite})
      .hex_equals(
          'AAAABBBBCCCCDDDD',
          '0x00000000  AA AA [!BB BB]  ..[!..]\n'
        ..'0x00000004  [!CC CC DD DD]  [!....]\n')
  end)
end)
