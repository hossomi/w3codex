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

  checkEqual = function(value, expected, message)
    if (value ~= expected) then
      error(message .. '\n Expected: ' .. expected .. '\n Got: ' .. value)
    end
    return value
  end,

  filterNot = function(value, except)
    if (value ~= except) then
      return value
    end
  end
}
