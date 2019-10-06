local util = require 'src.util'
local term = require 'term'
local CLR = term.colors.clear

-- Convenience to convert binary to hexadecimal with a trailing whitespace.
local function d2b(block)
  return util.format.b2x(block) .. ' '
end

local function isColored(color)
  return color and color ~= CLR
end

--- Creates a formatter function(data, colors) that formats binary data.
-- Example output:
--
-- BinFormat(8, 2)('all your base are belong to us')
--   0x00000000  616C 6C20 796F 7572 2062 6173 6520 6172  all your base ar
--   0x00000010  6520 6265 6C6F 6E67 2074 6F20 7573       e belong to us
local function BinFormatter(columns, bsize)
  return function(data, colors)
    local out = {}
    local colors = colors or {}

    local cnext = util.tables.snext(colors)
    local c, color = cnext()
    local clast

    -- Length of data in each line
    local lsize = columns * bsize
    -- Data block pattern
    local pattern = '(' .. string.rep('.', bsize) .. ')'

    -- The output for each line is first stored in two tables:
    -- blocks: the hexadecimal data columns
    -- chars:  the data representation in ASCII
    -- Each line is formed by concatenating these tables.

    -- Data is processed in segments, which are data chunks between each color
    -- change.
    -- This function formats a segment into blocks and chars and put them in the
    -- respective tables. Then, it prints the next color.
    -- Note that printing is "late": it prints a segment and the color for the
    -- NEXT segment.
    -- Color is cleared before printing the next, unless there was/is clear.
    local binprint = function(segment, color, blocks, chars)
      if #segment > 0 then
        -- Cut the last trailing space with sub(1, -2)
        table.insert(blocks, (segment:gsub(pattern, d2b)):sub(1, -2))
        if isColored(clast) then table.insert(blocks, tostring(CLR)) end
    
        table.insert(blocks, ' ')

        -- Replace non-printable characters with .
        table.insert(chars, (segment:gsub('[\x00-\x1F\x7F-\xFF]', '.')))
        if isColored(clast) then table.insert(chars, tostring(CLR)) end
      end

      -- Print next color if any.
      if isColored(color) then
        table.insert(blocks, tostring(color))
        table.insert(chars, tostring(color))
      end
    end

    -- It begins!
    for l = 1, #data, lsize do
      local lend = math.min(l + lsize - 1, #data)
      -- How many bytes to complete a full line
      local lfill = lsize - (lend - l + 1)
      local sstart = l

      local blocks = {}
      local chars = {}

      -- If the last line was colored, continue coloring.
      -- Unless the next color change is at the start of the line.
      if isColored(clast) and (not c or c > l) then
        table.insert(blocks, tostring(clast))
        table.insert(chars, tostring(clast))
      end

      -- Iterate each color change that belongs to this line.
      -- Each color change marks the end of a segment.
      while c and c <= lend do
        -- Round the byte so that the whole block is colored.
        local send = math.floor((c - 1) / bsize) * bsize
        binprint(data:sub(sstart, send), color, blocks, chars)

        sstart = send + 1
        clast = color
        c, color = cnext()
      end

      -- Print the remaining of this line.
      binprint(data:sub(sstart, lend), nil, blocks, chars)

      -- Print the final output for this line.
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