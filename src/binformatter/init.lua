local util = require 'src.util'
local colors = require 'term.colors'

local function breplace(block)
  return util.format.b2x(block) .. ' '
end

local function BinFormatter(columns, bsize)
  return function(data)
    local out = {}

    local lsize = columns * bsize
    local bwidth = lsize * 2 + columns - 1
    local bpattern = '(' .. string.rep('.', bsize) .. ')'

    local line, blocks
    for l = 1, #data, lsize do
      line = data:sub(l, l + lsize - 1)
      table.insert(out, string.format('%08X', l - 1))
      table.insert(out, '  ')

      blocks = (line:gsub(bpattern, breplace))
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
print(BinFormatter(8, 2)(data))
