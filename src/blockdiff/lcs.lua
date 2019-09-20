
-- Fills a string with \0 up to the requested size.
local function normalize(s, size)
  local r = #s % size
  return r ~= 0 and (s .. string.rep('\0', size - r)) or s
end

-- Longest common subsequence (LCS)
-- Modified to consider data by blocks of given size.
-- https://en.wikipedia.org/wiki/Longest_common_subsequence_problem
local function lcs(x, y, size, px, py, cache)
  if px == 0 or py == 0 then
    return ''
  end

  -- Memoized!
  if cache[px][py] then
    return cache[px][py]
  end

  local i = -size
  repeat
    i = i + size
  until px - i == 0
    or py - i == 0
    or x:sub(px - i - (size - 1), px) ~= y:sub(py - i - (size - 1), py)

  if i == 0 then
    local lcsx = lcs(x, y, size, px - size, py, cache)
    local lcsy = lcs(x, y, size, px, py - size, cache)
    cache[px][py] = #lcsx >= #lcsy and lcsx or lcsy
  else
    cache[px][py] = lcs(x, y, size, px - i, py - i, cache) .. x:sub(px - i + 1, px)
  end

  return cache[px][py]
end

return function(original, new, size)
  local cache = setmetatable({}, {
    __index = function(cache, key)
      cache[key] = {}
      return cache[key]
    end
  })

  local x = normalize(original, size)
  local y = normalize(new, size)
  return lcs(x, y, size, #x, #y, cache)
end
