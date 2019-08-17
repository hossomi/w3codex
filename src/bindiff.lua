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

local function bindiff(original, new)

end

local util = require 'src.util'
local a = util.format.b2x(assert(io.open('test/maps/sample-1.w3x/war3map.w3i')):read('*all'))
local b = util.format.b2x(assert(io.open('test/maps/sample-2.w3x/war3map.w3i')):read('*all'))
print((lcs(a, b, 2)))
-- print(lcs('abcdefgh', 'abcfghkjlgh', 3) .. '.', calcs, hits)
-- print(lcs('abc', 'bdf'))
