local util = require 'src.util'
local colors = require 'term.colors'

-- Longest common sequence (LCS)

local function normalize(s, size)
  local r = #s % size
  return r ~= 0 and (s .. string.rep('\0', size - r)) or s
end

local function lcs(x, y, size, px, py, cache)
  if not cache then
    cache = setmetatable({}, {
      __index = function(cache, key)
        cache[key] = {}
        return cache[key]
      end
    })

    x = normalize(x, size)
    y = normalize(y, size)
    return lcs(x, y, size, #x, #y, cache)
  end

  if px == 0 or py == 0 then
    return ''
  end

  if cache[px][py] then
    return cache[px][py]
  end

  local i = -size
  repeat
    i = i + size
  until px - i == 0 or py - i == 0 or x:sub(px - i - (size - 1), px)
      ~= y:sub(py - i - (size - 1), py)

  if i == 0 then
    local lcsx = lcs(x, y, size, px - size, py, cache)
    local lcsy = lcs(x, y, size, px, py - size, cache)
    cache[px][py] = #lcsx >= #lcsy and lcsx or lcsy
  else
    cache[px][py] = lcs(x, y, size, px - i, py - i, cache)
                        .. x:sub(px - i + 1, px)
  end
  return cache[px][py]
end

-- Block diff

local function find(source, block, start)
  if #block > 0 then
    local bstart, bend = source:find(block, start)
    if bstart > start then
      return bend + 1, {from = start, to = bstart - 1}
    end
    return bend + 1
  end

  return #source + 1, {from = start, to = #source}
end

local function blockdiff(original, new, bsize)
  local common = lcs(original, new, bsize)

  local o, n, c = 1, 1, 1
  local removed, added = {}, {}
  local cblock, jump

  repeat
    cblock = common:sub(c, c + bsize - 1)

    o, jump = find(original, cblock, o)
    table.insert(removed, jump)

    n, jump = find(new, cblock, n)
    table.insert(added, jump)

    c = c + bsize
  until #cblock == 0

  return {added = added, removed = removed}
end

local util = require 'src.util'
local a = util.format.b2x(
              assert(io.open('test/maps/sample-1.w3x/war3map.w3i')):read('*all'))
local b = util.format.b2x(
              assert(io.open('test/maps/sample-2.w3x/war3map.w3i')):read('*all'))
local diff = blockdiff(a, b, 2)

for i, v in ipairs(diff.removed) do
  print('R', v.from, v.to)
end

for i, v in ipairs(diff.added) do
  print('A', v.from, v.to)
end