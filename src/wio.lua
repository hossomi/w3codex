local function open(path)
  local file = assert(io.open(path, 'rb'))
  local data = file:read('*all')

  return {
    cursor = 1,
    
    read = function(self, n)
      self.cursor = self.cursor + n
      return string.sub(data, self.cursor - n, self.cursor - 1)
    end,

    readInteger = function(self)
      return (string.unpack('<I4', self:read(4)))
    end
  }
end

return {
  open = open
}