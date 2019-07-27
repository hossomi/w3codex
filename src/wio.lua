local function unpack(data, format) if data then return (format:unpack(data)) end end

local function size(file)
    local current = file:seek()
    local size = file:seek('end')
    file:seek('set', current)
    return size
end

local function StringReader(data)
    return {
        _cursor = 1,

        _remaining = function(self) return #data - self._cursor + 1 end,

        nextBytes = function(self, n)
            if self:_remaining() >= n then
                self._cursor = self._cursor + n
                return data:sub(self._cursor - n, self._cursor - 1)
            end
        end,

        nextUntil = function(self, pattern, options)
            local left, right = data:find(pattern, self._cursor)
            if left then
                local from = self._cursor
                self._cursor = right + 1
                if options and options.inclusive then
                    return data:sub(from, right)
                else
                    return data:sub(from, left - 1)
                end
            end
        end,

        skip = function(self, n)
            self._cursor = math.min(self._cursor + n, #data + 1)
        end
    }
end

local function FileReader(file, bsize)
    return {
        _buffer = file:read(bsize) or '',

        _cursor = 1,

        _bremaining = function(self)
            return #self._buffer - self._cursor + 1
        end,

        _fsize = size(file),

        _fremaining = function(self) return self._fsize - file:seek() + 1 end,

        nextBytes = function(self, n)
            if self:_bremaining() >= n then
                self._cursor = self._cursor + n
                return self._buffer:sub(self._cursor - n, self._cursor - 1)
            elseif self:_fremaining() + self:_bremaining() >= n then
                local load = n - self:_bremaining()
                local data = self._buffer:sub(self._cursor) .. file:read(load)
                self._buffer = file:read(math.ceil(load / bsize) * bsize - load)
                self._cursor = 1
                return data
            end
        end,

        nextUntil = function(self, pattern, options)
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
            local current = file:seek()
            while file:seek() < self._fsize do
                self._buffer = file:read(bsize) or ''
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
            file:seek('set', current)
        end,
        
        skip = function(self, n)
            if self:_bremaining() >= n then
                self._cursor = self._cursor + n
            elseif self:_fremaining() + self:_bremaining() >= n then
                local load = n - self:_bremaining()
                file:seek('set', file:seek() + load)
                self._buffer = file:read(math.ceil(load / bsize) * bsize - load)
                self._cursor = 1
            else
                self._buffer = ''
                self._cursor = 1
                file:seek('end')
            end
        end
    }
end

local function withFormatters(reader)
    reader.next = function(self, arg, options)
        if type(arg) == 'number' then
            return self:nextBytes(arg, options)
        elseif type(arg) == 'string' then
            return self:nextUntil(arg, options)
        end
    end
    reader.bytes = function(self, n) return self:next(n) end
    reader.string = function(self) return self:next('\0') end
    reader.int = function(self) return unpack(self:next(4), '<I4') end
    reader.short = function(self) return unpack(self:next(2), '<I2') end
    reader.real = function(self) return unpack(self:next(4), '<f') end
    return reader
end

return {
    StringReader = function(data) return withFormatters(StringReader(data)) end,
    FileReader = function(file, bsize)
        return withFormatters(FileReader(file, bsize or 2 ^ 13))
    end
}
