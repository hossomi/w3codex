require 'src.constants'

-- ==============================
-- Formatting
-- ==============================

local function charHexToBin(hex)
  return string.char(tonumber(hex, 16))
end

local function charBinToHex(bin)
  return string.format('%02X', bin:byte())
end

local format = {

  x2b = function(hex)
    return (hex:gsub('..', charHexToBin))
  end,

  b2x = function(bin)
    return (bin:gsub('.', charBinToHex))
  end,

  i2x = function(int, big)
    local bin = (string.pack(big and '>I4' or '<I4', int))
    return '0x' .. (bin:gsub('.', charBinToHex))
  end
}

local tables = {

  spairs = function(t)
    local keys = {}
    for k in pairs(t) do
      keys[#keys + 1] = k
    end
    table.sort(keys)

    local i = 0
    local function nextSorted(table)
      i = i + 1
      if keys[i] ~= nil then
        return keys[i], t[keys[i]]
      end
    end

    return nextSorted, t, nil
  end
}

-- ==============================
-- Filters and checks
-- ==============================

local check = {

  equal = function(value, expected, message)
    if value ~= expected then
      error(message .. '\n Expected: ' .. expected .. '\n Got: ' .. value)
    end
    return value
  end,

  defined = function(value, message)
    if value == nil then
      error(message)
    end
    return value
  end
}

local filter = {
  except = function(value, except, replace)
    return value ~= except and value or replace
  end
}

-- ==============================
-- Flags
-- ==============================

local function transpose(table)
  for i, v in ipairs(table) do
    table[v] = i
  end
  return table
end

flags = {

  msb = function(data)
    local msb = 0
    while data > 0 do
      msb = msb + 1
      data = data >> 1
    end
    return msb
  end,

  map = function(data, mapping)
    local flags = {
      int = function(self)
        local data = 0
        for bit, value in ipairs(self) do
          data = data + (value and bit or 0)
        end
        return data
      end
    }

    local mask = 0x1
    for i = 1, 32 do
      flags[mask] = data & mask ~= 0
      mask = mask << 1
    end

    mapping = mapping and transpose(mapping) or {}

    return setmetatable(flags, {
      __index = function(self, key)
        if type(key) == 'string' then
          return rawget(self, mapping[key])
        end
      end,

      __newindex = function(self, key, value)
        if type(key) == 'string' then
          return rawset(self, mapping[key], value)
        end
      end,

      __pairs = function(self)
        local function nextMapping(mapping, k)
          local v
          k, v = next(mapping, k)
          return k, self[v]
        end

        return nextMapping, mapping, nil
      end,

      __ipairs = function(self)
        local function nextBit(table, n)
          n = (n == 0) and 0x1 or n << 1
          if table[n] ~= nil then
            return n, table[n]
          end
        end

        return nextBit, self, 0
      end,

      __tostring = function(self)
        return format.i2x(self:int())
      end
    })
  end,

  players = function(data)
    local players = {

      int = function(self)
        local data = 0x0
        for id, present in ipairs(self) do
          if present then
            data = data + math.pow(2, id)
          end
        end
        return data
      end
    }

    for i = 0, 31 do
      players[i] = data & 0x1 ~= 0
      data = data >> 1
    end

    return setmetatable(players, {
      __ipairs = function(self)
        local function nextIndex(table, id)
          id = id + 1
          if table[id] ~= nil then
            return id, table[id]
          end
        end

        return nextIndex, self, -1
      end,

      __tostring = function(self)
        return format.i2x(self:int())
      end
    })
  end
}

return {
  format = format,
  tables = tables,
  check = check,
  filter = filter,
  flags = flags
}
