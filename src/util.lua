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

  i2x = function(int)
    local bin = (string.pack('<I4', int))
    return '0x' .. (bin:gsub('.', charBinToHex))
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

  parse = function(data, mapping)
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

  players = function(data, playerIndex)
    local players = {

      _playerIndex = playerIndex,

      int = function(self)
        local data = 0x0
        for id, p in ipairs(self) do
          data = data + math.pow(2, id)
        end
        return data
      end
    }

    local mask = 0x1
    for i = 0, 31 do
      players[i] = data & mask ~= 0
      mask = mask << 1
    end

    return setmetatable(players, {
      __ipairs = function(self)
        local function valid(id)
          return not self._playerIndex or self._playerIndex[id]
        end

        local function nextTrue(table, id)
          local indexed = false
          repeat
            id = id + 1
            indexed = not self._playerIndex or self._playerIndex[id]
          until table[id] == nil or (table[id] == true and (indexed))

          if table[id] then
            return id, self._playerIndex and self._playerIndex[id] or nil
          end
        end

        return nextTrue, self, -1
      end,

      __tostring = function(self)
        return format.i2x(self:int())
      end
    })
  end
}

return {format = format, check = check, filter = filter, flags = flags}
