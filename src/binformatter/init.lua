local util = require 'src.util'
local colors = require 'term.colors'

local function d2b(block)
  return util.format.b2x(block) .. ' '
end

local function BinPrinter(pattern)
  return function(segment, color, blocks, chars)
    if #segment > 0 then
      table.insert(blocks, (segment:gsub(pattern, d2b)):sub(1, -2))
      table.insert(blocks, tostring(colors.clear))
      table.insert(blocks, ' ')
      table.insert(chars, (segment:gsub('[\x00-\x1F\x7F-\xFF]', '.')))
      table.insert(chars, tostring(colors.clear))
    end
    table.insert(blocks, tostring(color))
    table.insert(chars, tostring(color))
  end
end

local function BinFormatter(columns, bsize)
  return function(data, dataColors)
    local out = {}
    dataColors = dataColors or {}

    local lsize = columns * bsize
    local binprint = BinPrinter('(' .. string.rep('.', bsize) .. ')')

    local nextColor = util.tables.snext(dataColors)
    local c, color = nextColor()
    local lastColor

    for l = 1, #data, lsize do
      local lend = math.min(l + lsize - 1, #data)
      local lfill = lsize - (lend - l + 1)
      local sstart = l

      local blocks = {}
      local chars = {}

      if lastColor then
        table.insert(blocks, tostring(lastColor))
        table.insert(chars, tostring(lastColor))
      end

      while c and c <= lend do
        local send = math.floor(c / bsize) * bsize
        binprint(data:sub(sstart, send), color, blocks, chars)

        sstart = send + 1
        lastColor = color
        c, color = nextColor()
      end

      binprint(data:sub(sstart, lend), colors.clear, blocks, chars)

      table.insert(out, string.format('0x%08X  ', l - 1))
      table.insert(out, table.concat(blocks))
      table.insert(out, string.rep(' ', lfill * 2 + (lfill / bsize) + 1))
      table.insert(out, table.concat(chars))
      table.insert(out, '\n')
    end

    return table.concat(out)
  end
end

local data = ''
for i = 0x00, 0xFF do
  data = data .. string.char(i)
end

local formatter = BinFormatter(8, 1)
print(formatter(data, {
  [9] = colors.green,
  [1] = colors.red,
  [25] = colors.clear,
  [37] = colors.yellow,
  [76] = colors.cyan,
  [128] = colors.clear,
  [126] = colors.red,
  [10] = colors.ongreen
}))

formatter = BinFormatter(6, 4)
print(formatter(data, {
  [9] = colors.green,
  [255] = colors.onwhite,
  [1] = colors.red,
  [2] = colors.blue,
  [25] = colors.clear,
  [37] = colors.yellow,
  [76] = colors.cyan,
  [128] = colors.clear,
  [126] = colors.green .. colors.onred
}))
