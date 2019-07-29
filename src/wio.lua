local function unpack(data, format)
  if data then
    return format:unpack(data)
  end
end

local function pack(data, format)
  if data then
    return format:pack(data)
  end
end

local function size(file)
  local current = file:seek()
  local size = file:seek('end')
  file:seek('set', current)
  return size
end

local function FileReader(file, bsize)
  return {
    _file = file,

    _buffer = file:read(bsize) or '',

    _cursor = 1,

    _bremaining = function(self)
      return #self._buffer - self._cursor + 1
    end,

    _fsize = size(file),

    _fremaining = function(self)
      return self._fsize - self._file:seek() + 1
    end,

    readBytes = function(self, n)
      if self:_bremaining() >= n then
        self._cursor = self._cursor + n
        return self._buffer:sub(self._cursor - n, self._cursor - 1)
      elseif self:_fremaining() + self:_bremaining() >= n then
        local load = n - self:_bremaining()
        local data = self._buffer:sub(self._cursor) .. self._file:read(load)
        self._buffer = self._file:read(math.ceil(load / bsize) * bsize - load)
        self._cursor = 1
        return data
      end
    end,

    readUntil = function(self, pattern, options)
      local left, right = self._buffer:find(pattern, self._cursor)
      if left then
        local data
        if options and options.inclusive then
          data = self._buffer:sub(self._cursor, right)
        else
          data = self._buffer:sub(self._cursor, left - 1)
        end
        self._cursor = right + 1
        return data
      end

      local data = self._buffer
      local current = self._file:seek()
      while self._file:seek() < self._fsize do
        self._buffer = self._file:read(bsize) or ''
        left, right = self._buffer:find(pattern)
        if left then
          if options and options.inclusive then
            data = data .. self._buffer:sub(1, right)
          else
            data = data .. self._buffer:sub(1, left - 1)
          end
          self._cursor = right + 1
          return data
        end
        data = data .. self._buffer
      end
      self._file:seek('set', current)
    end,

    skip = function(self, n)
      if self:_bremaining() >= n then
        self._cursor = self._cursor + n
      elseif self:_fremaining() + self:_bremaining() >= n then
        local load = n - self:_bremaining()
        self._file:seek('set', self._file:seek() + load)
        self._buffer = self._file:read(math.ceil(load / bsize) * bsize - load)
        self._cursor = 1
      else
        self._buffer = ''
        self._cursor = 1
        self._file:seek('end')
      end
    end,

    close = function(self)
      self._file:close()
    end,

    read = function(self, arg, options)
      if type(arg) == 'number' then
        return self:readBytes(arg, options)
      elseif type(arg) == 'string' then
        return self:readUntil(arg, options)
      end
    end,

    bytes = function(self, n)
      return self:read(n)
    end,

    string = function(self)
      return self:read('\0')
    end,

    int = function(self)
      return (unpack(self:read(4), '<i4'))
    end,

    short = function(self)
      return (unpack(self:read(2), '<i2'))
    end,

    real = function(self)
      return (unpack(self:read(4), '<f'))
    end,

    color = function(self)
      local data = self:read(4)
      if data then
        local red, green, blue, alpha = unpack(data, 'BBBB')
        return {red = red, green = green, blue = blue, alpha = alpha}
      end
    end
  }
end

local function FileWriter(file, bsize)
  return {
    _file = file,

    _buffer = '',

    write = function(self, data)
      self._buffer = self._buffer .. data
      if #self._buffer >= bsize then
        self._file:write(self._buffer)
        self._buffer = ''
      end
    end,

    close = function(self)
      if #self._buffer > 0 then
        self._file:write(self._buffer)
      end
      self._file:close()
    end,

    bytes = function(self, data)
      self:write(data)
    end,

    string = function(self, data)
      self:write(data .. '\0')
    end,

    int = function(self, data)
      self:write((pack(data, '<i4')))
    end,

    short = function(self, data)
      self:write((pack(data, '<i2')))
    end,

    real = function(self, data)
      self:write((pack(data, '<f')))
    end,

    color = function(self, data)
      if data then
        self:write(string.pack('BBBB', data.red or 0, data.green or 0,
                       data.blue or 0, data.alpha or 0))
      end
    end
  }
end

return {
  FileReader = function(path, bsize)
    local file = assert(io.open(path, 'rb'))
    return FileReader(file, bsize or 2 ^ 13)
  end,
  FileWriter = function(path, bsize)
    local file = assert(io.open(path, 'wb'))
    return FileWriter(file, bsize or 2 ^ 2 ^ 10)
  end
}
