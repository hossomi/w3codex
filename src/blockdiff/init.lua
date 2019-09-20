local util = require 'src.util'
local RangeList = require 'src.blockdiff.RangeList'
local lcs = require 'src.blockdiff.lcs'
local colors = require 'term.colors'

-- Find a data block starting from given position. The returned values are
-- actually those that defines ranges that EXCLUDE the found block:
--  - The next byte after the found block.
--  - The given start position
--  - The byte before the found block.
-- 
-- If the block starts at the start position, only the first value is returned.
-- If the block is empty, it considers the block with size 0 is at the end.
-- Examples:
-- 
-- find('aaaabbbbccccdddd', 'bbbb', 1)
--   9 1 4
-- find('aaaabbbbccccdddd', 'aaaa', 1)
--   5
-- find('aaaabbbbccccdddd', '', 1)
--   17, 1, 16
local function find(source, block, start)
  if #block > 0 then
    local bstart, bend = source:find(block, start)
    if bstart > start then
      return bend + 1, start, bstart - 1
    end
    return bend + 1
  end

  return #source + 1, start, #source
end

-- Calculates the diff between two data strings by blocks of given size.
-- Returns a table with two RangeLists, 'removed' and 'added', each containing
-- ranges that were removed or added.
-- Examples:
--
-- BlockDiff('aaabbbcccddd', 'bbbccceeefff', 3)
--   removed: [(1, 3), (10, 12)]
--   added:   [(7, 12)]
local function BlockDiff(original, new, bsize)
  local lcs = lcs(original, new, bsize)

  local o, n, c = 1, 1, 1
  local cblock, from, to

  local diff = {
    removed = RangeList(),
    added = RangeList()
  }

  repeat
    cblock = lcs:sub(c, c + bsize - 1)

    o, from, to = find(original, cblock, o)
    diff.removed:add(from, to)

    n, from, to = find(new, cblock, n)
    diff.added:add(from, to)

    c = c + bsize
  until #cblock == 0

  return diff
end

return BlockDiff