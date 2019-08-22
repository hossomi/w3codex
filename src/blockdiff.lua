local util = require 'src.util'
local colors = require 'term.colors'

local function normalize(s, size)
  local r = #s % size
  return r ~= 0 and (s .. string.rep('\0', size - r)) or s
end

local function lcs(x, y, size, px, py, store)
  if not store then
    store = setmetatable({}, {
      __index = function(store, key)
        store[key] = {}
        return store[key]
      end
    })

    x = normalize(x, size)
    y = normalize(y, size)
    return lcs(x, y, size, #x, #y, store)
  end

  if px == 0 or py == 0 then
    return ''
  end

  if store[px][py] then
    return store[px][py]
  end

  local i = -size
  repeat
    i = i + size
  until px - i == 0 or py - i == 0 or x:sub(px - i - (size - 1), px)
      ~= y:sub(py - i - (size - 1), py)

  if i == 0 then
    local lcsx = lcs(x, y, size, px - size, py, store)
    local lcsy = lcs(x, y, size, px, py - size, store)
    store[px][py] = #lcsx >= #lcsy and lcsx or lcsy
  else
    store[px][py] = lcs(x, y, size, px - i, py - i, store)
                        .. x:sub(px - i + 1, px)
  end
  return store[px][py]
end

local function find(source, block, start)
  if #block > 0 then
    local bstart, bend = source:find(block, start)
    local jump = bstart > start and {from = start, to = bstart - 1} or nil
    return jump, bend + 1
  else
    return {from = start, to = #source}
  end

end

local function bindiff(original, new)
  local bsize = 4
  local colored = true
  local common = lcs(original, new, bsize)

  local o, n, c = 1, 1, 1
  local cblock, jump
  local removed, added = {}, {}

  repeat
    cblock = common:sub(c, c + bsize - 1)

    jump, o = find(original, cblock, o)
    table.insert(removed, jump)

    jump, n = find(new, cblock, n)
    table.insert(added, jump)

    c = c + bsize
  until #cblock == 0

  return {added = added, removed = removed}
end

local util = require 'src.util'
-- local a = util.format.b2x(
--               assert(io.open('test/maps/sample-1.w3x/war3map.w3i')):read('*all'))
-- local b = util.format.b2x(
--               assert(io.open('test/maps/sample-2.w3x/war3map.w3i')):read('*all'))
-- print((lcs(a, b, 2)))
-- print(lcs('abcdefgh', 'abcfghkjlgh', 3) .. '.', calcs, hits)
-- print(lcs('abc', 'bdf'))

-- local diff = bindiff('ABCDEFGHIJKLQRST', 'ABCD0123IJKLMNOP')
-- for i, v in ipairs(diff.removed) do
--   print('R', v.from, v.to)
-- end

-- for i, v in ipairs(diff.added) do
--   print('A', v.from, v.to)
-- end

-- local diff = bindiff('aaaaSKDHAKDkshAKHKSHDLhuiFSDTUyiasdgAS', 'aaaahdoISAHIDGFKdsgfDHFKhysdiughfkj')
-- for i, v in ipairs(diff.removed) do
--   print('R', v.from, v.to)
-- end

-- for i, v in ipairs(diff.added) do
--   print('A', v.from, v.to)
-- end
