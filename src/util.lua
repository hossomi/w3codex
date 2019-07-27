local function charHexToBin(hex)
  return string.char(tonumber(hex, 16))
end

local function charBinToHex(bin)
  return string.format('%02X', bin:byte())
end

local function hexToBin(hex)
  return (hex:gsub('..', charHexToBin))
end

local function binToHex(bin)
  return (bin:gsub('.', charBinToHex))
end

return {hexToBin = hexToBin, binToHex = binToHex}
