local util = require 'src.util'
local colors = require 'term.colors'

local function d2b(block)
  return util.format.b2x(block) .. ' '
end

local function BinFormatter(columns, bsize)
  return function(data, dataColors)
    local out = {}

    local lsize = columns * bsize
    local bpattern = '(' .. string.rep('.', bsize) .. ')'
    local blockTotalSize = lsize * 2 + columns - 1

    local nextColor = util.tables.snext(dataColors)
    local c, color = nextColor()

    for l = 1, #data, lsize do
      local lend = l + lsize - 1
      local sstart = l

      local blocks = {}
      local chars = {}

      while c and c < lend do
        local send = math.floor(c / bsize) * bsize
        table.insert(blocks, (data:sub(sstart, send):gsub(bpattern, d2b)))
        table.insert(blocks, tostring(colors[color]))

        sstart = send + 1
        c, color = nextColor()
      end

      table.insert(blocks, (data:sub(sstart, lend):gsub(bpattern, d2b)))
      
      table.insert(out, string.format('0x%08X: ', l - 1))

      table.insert(out, table.concat(blocks))
      -- table.insert(out, string.rep(' ', blockTotalSize - #blocks + 2))
      -- table.insert(out, (line:gsub('[\x00-\x1F\x7F-\xFF]', '.')))
      table.insert(out, '\n')
    end

    return table.concat(out)
  end
end

local data = ''
for i = 0x00, 0xFF do
  data = data .. string.char(i)
end

local formatter = BinFormatter(8, 2)
print(formatter(data, {
  [9] = 'green',
  [1] = 'red',
  [25] = 'clear',
  [37] = 'yellow',
  [76] = 'cyan',
  [128] = 'clear',
  [126] = 'red'
}))

formatter = BinFormatter(9, 2)
print(formatter(data, {
  [9] = 'green',
  [1] = 'red',
  [25] = 'clear',
  [37] = 'yellow',
  [76] = 'cyan',
  [128] = 'clear',
  [126] = 'red'
}))
