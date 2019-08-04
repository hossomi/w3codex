local function charHexToBin(hex)
  return string.char(tonumber(hex, 16))
end

local function charBinToHex(bin)
  return string.format('%02X', bin:byte())
end

return {
  hexToBin = function(hex)
    return (hex:gsub('..', charHexToBin))
  end,

  binToHex = function(bin)
    return (bin:gsub('.', charBinToHex))
  end,

  intToHex = function(int)
    return charBinToHex(string.pack('<i4', int))
  end,

  checkEqual = function(value, expected, message)
    if (value ~= expected) then
      error(message .. '\n Expected: ' .. expected .. '\n Got: ' .. value)
    end
    return value
  end,

  filterNot = function(value, except, replace)
    return value ~= except and value or replace
  end,

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
    end
  }
}
