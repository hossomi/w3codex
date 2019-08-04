return {
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
