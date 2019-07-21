local function reader(data)
  return {
    cursor = 1,
    remaining = function(self)
      return #data - self.cursor + 1
    end,
    unpack = function(self, n, format)
      if self:remaining() < n then
        return nil
      end
      return (string.unpack(format, self:bytes(n)))
    end,
    bytes = function(self, n)
      local from = self.cursor
      self.cursor = math.min(#data + 1, self.cursor + n)
      return data:sub(from, self.cursor - 1)
    end,
    string = function(self)
      local from = self.cursor
      self.cursor = (data:find('\0', self.cursor))

      if not self.cursor then
        self.cursor = #data + 1
        return data:sub(from, self.cursor - 1)
      end

      self.cursor = self.cursor + 1
      return data:sub(from, self.cursor - 2)
    end,
    int = function(self)
      return self:unpack(4, '<I4')
    end,
    short = function(self)
      return self:unpack(2, '<I2')
    end,
    real = function(self)
      return self:unpack(4, '<f')
    end
  }
end

local function open(path)
  local file = assert(io.open(path, 'rb'))
  local data = file:read('*all')
  return reader(data)
end

return {
  open = open,
  read = reader
}
