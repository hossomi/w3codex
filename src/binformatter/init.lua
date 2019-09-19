local util = require 'src.util'
local colors = require 'term.colors'

local function d2b(block)
  return util.format.b2x(block) .. ' '
end

local function BinFormatter(columns, bsize)
  return function(data, dataColors)
    local out = {}
    dataColors = dataColors or {}

    local nextColor = util.tables.snext(dataColors)
    local c, color = nextColor()
    local lastColor

    local lsize = columns * bsize
    local pattern = '(' .. string.rep('.', bsize) .. ')'

    local binprint = function(segment, color, blocks, chars)
      if #segment > 0 then
        table.insert(blocks, (segment:gsub(pattern, d2b)):sub(1, -2))
        if lastColor then
          table.insert(blocks, tostring(colors.clear))
        end
        table.insert(blocks, ' ')
        table.insert(chars, (segment:gsub('[\x00-\x1F\x7F-\xFF]', '.')))
        if lastColor then
          table.insert(chars, tostring(colors.clear))
        end
      end
      if color and color ~= colors.clear then
        table.insert(blocks, tostring(color))
        table.insert(chars, tostring(color))
      end
    end

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
        local send = math.floor((c - 1) / bsize) * bsize
        binprint(data:sub(sstart, send), color, blocks, chars)

        sstart = send + 1
        lastColor = color
        c, color = nextColor()

        if color == colors.clear then
          color = nil
        end
      end

      binprint(data:sub(sstart, lend), nil, blocks, chars)

      table.insert(out, string.format('0x%08X  ', l - 1))
      table.insert(out, table.concat(blocks))
      table.insert(out, string.rep(' ', lfill * 2 + math.floor(lfill / bsize) + 1))
      table.insert(out, table.concat(chars))
      table.insert(out, '\n')
    end

    return table.concat(out)
  end
end

return BinFormatter