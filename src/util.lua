-- ==============================
-- Binary and hexadecimal
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
    local bin = (string.pack('<i4', int))
    return '0x' .. (bin:gsub('.', charBinToHex))
  end
}

-- ==============================
-- Filters and checks
-- ==============================

local check = {
  equal = function(value, expected, message)
    if (value ~= expected) then
      error(message .. '\n Expected: ' .. expected .. '\n Got: ' .. value)
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

local function nextMapping(table)
  return function(mapping, index)
    local k, v = next(mapping, index)
    return k, table[v]
  end
end

local function nextNumeric(table, k)
  local v
  repeat
    k, v = next(table, k)
  until type(k) == 'number' or k == nil
  return k, v
end

flags = {

  forEachMap = function(flags, map, callback)
    local i = 0
    while flags ~= 0 do
      if flags & 0x1 ~= 0 and map[i] then
        callback(map[i])
      end
      i = i + 1
      flags = flags >> 1
    end
  end,

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

    setmetatable(flags, {
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
        return nextMapping(self), mapping, nil
      end,

      __ipairs = function(self)
        return nextNumeric, self, nil
      end,

      __tostring = function(self)
        return format.i2x(self:int())
      end
    })

    return flags
  end
}

return {format = format, check = check, filter = filter, flags = flags}
