local util = require 'src.util'
local colors = require 'term.colors'

local function linePrefix(line)
  return string.format('%08X', line - 1)
end

local function lineBlocks(line, bsize)
  local blocks = ''
  for c = 1, #line, bsize do
    blocks = blocks .. util.format.b2x(line:sub(c, c + bsize - 1)) .. ' '
  end
  return blocks
end

local function BinFormat(columns, bsize)
  return function(data)
    local out = {}

    local lsize = columns * bsize
    local bwidth = lsize * 2 + columns - 1
    local line, blocks

    for l = 1, #data, lsize do
      line = data:sub(l, l + lsize - 1)
      table.insert(out, string.format('%08X', l - 1))
      table.insert(out, '  ')

      blocks = lineBlocks(line, bsize)
      table.insert(out, blocks)
      table.insert(out, string.rep(' ', bwidth - #blocks + 2))

      table.insert(out, (line:gsub('[\x00-\x1F\x7F-\xFF]', '.')))
      table.insert(out, '\n')
    end

    return table.concat(out)
  end
end

local data = ''
for i = 0x00, 0xFF do
  data = data .. string.char(i)
end
print(BinFormat(8, 2)(data))
