local util = require 'src.util'

local function multiunpack(format, n, data)
  if data then
    format = '<' .. string.rep(format, n)
    return format:unpack(data)
  end
end

local function multipack(format, ...)
  if ... then
    format = '<' .. string.rep(format, #{...})
    return format:pack(...)
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

    _bcursor = 1,

    _bremaining = function(self)
      return #self._buffer - self._bcursor + 1
    end,

    _fsize = size(file),

    _fremaining = function(self)
      return self._fsize - self._file:seek()
    end,

    tags = {},

    tag = function(self, label)
      self.tags[util.format.i2x(self._cursor - 1, true)] = label
    end,

    totalRead = function(self)
      return self._cursor - 1
    end,

    readBytes = function(self, n)
      if self:_bremaining() >= n then
        self._cursor = self._cursor + n
        self._bcursor = self._bcursor + n
        return self._buffer:sub(self._bcursor - n, self._bcursor - 1)
      elseif self:_fremaining() + self:_bremaining() >= n then
        local load = n - self:_bremaining()
        local data = self._buffer:sub(self._bcursor) .. self._file:read(load)
        self._buffer = self._file:read(math.ceil(load / bsize) * bsize - load)
        self._cursor = self._cursor + n
        self._bcursor = 1
        return data
      end
    end,

    readUntil = function(self, pattern, options)
      local left, right = self._buffer:find(pattern, self._bcursor)
      if left then
        local data
        if options and options.inclusive then
          data = self._buffer:sub(self._bcursor, right)
        else
          data = self._buffer:sub(self._bcursor, left - 1)
        end
        self._cursor = self._cursor + right - self._bcursor + 1
        self._bcursor = right + 1
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
          self._cursor = self._cursor + right - self._bcursor + 1
          self._bcursor = right + 1
          return data
        end
        data = data .. self._buffer
      end
      self._file:seek('set', current)
    end,

    skip = function(self, n)
      if self:_bremaining() >= n then
        self._cursor = self._cursor + n
        self._bcursor = self._bcursor + n
      elseif self:_fremaining() + self:_bremaining() >= n then
        local load = n - self:_bremaining()
        self._file:seek('set', self._file:seek() + load)
        self._buffer = self._file:read(math.ceil(load / bsize) * bsize - load)
        self._cursor = self._cursor + n
        self._bcursor = 1
      else
        self._buffer = ''
        self._bcursor = 1
        self._cursor = self._fsize
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

    string = function(self, n)
      if not n or n == 1 then
        return self:read('\0')
      end

      results = {}
      for i = 1, n do
        results[#results + 1] = self:read('\0')
      end
      return table.unpack(results)
    end,

    int = function(self, n)
      n = n or 1
      return multiunpack('i4', n, self:read(4 * n))
    end,

    short = function(self, n)
      n = n or 1
      return multiunpack('i2', n, self:read(2 * n))
    end,

    real = function(self, n)
      n = n or 1
      return multiunpack('f', n, self:read(4 * n))
    end,

    flags = function(self, mapping)
      local data = multiunpack('I4', 1, self:read(4))
      if data then
        return util.flags.map(data, mapping)
      end
    end,

    players = function(self)
      local data = multiunpack('I4', 1, self:read(4))
      if data then
        return util.flags.players(data)
      end
    end,

    color = function(self)
      local data = self:read(4)
      if data then
        local values = {string.unpack('BBBB', data)}
        return {
          red = values[3],
          green = values[2],
          blue = values[1],
          alpha = values[4]
        }
      end
    end,

    preformatted = function(self, format, type, mapping)
      local data = self:read(4 * #format)
      if data then
        local object = {}
        local values = {string.unpack(string.rep(type, #format), data)}

        for i = 1, #format do
          local f = format:sub(i, i)
          local m = mapping[f]

          if not m then
            error('Unknown format: ' .. f)
          end

          object[m] = values[i]
        end
        return object
      end
    end,

    bounds = function(self, format, type)
      return self:preformatted(format, type, {
        L = 'left',
        R = 'right',
        T = 'top',
        B = 'bottom'
      })
    end,

    rect = function(self, format, type)
      return self:preformatted(format, type, {W = 'width', H = 'height'})
    end
  }
end

local function FileWriter(file, bsize)
  return {
    _file = file,

    _buffer = '',

    _cursor = 1,

    tags = {},

    tag = function(self, label)
      self.tags[util.format.i2x(self._cursor - 1, true)] = label
    end,

    write = function(self, data)
      self._buffer = self._buffer .. data
      self._cursor = self._cursor + #data
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

    string = function(self, ...)
      data = {...}
      for i = 1, #data do
        self:write(data[i] .. '\0')
      end
    end,

    int = function(self, ...)
      self:write(multipack('i4', ...))
    end,

    short = function(self, ...)
      self:write(multipack('i2', ...))
    end,

    real = function(self, ...)
      self:write(multipack('f', ...))
    end,

    flags = function(self, flags)
      util.check.defined(flags.int, 'Not a Flags object!')
      self:write(multipack('I4', flags:int()))
    end,

    players = function(self, players)
      util.check.defined(players.int, 'Not a PlayerFlags object!')
      self:write(multipack('I4', players:int()))
    end,

    color = function(self, data)
      if data then
        self:write(string.pack('BBBB', data.blue or 0, data.green or 0,
                       data.red or 0, data.alpha or 0))
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
