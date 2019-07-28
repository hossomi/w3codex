local wio = require 'wio'
local util = require 'util'

describe('WIO', function()

  describe('FileReader', function()

    it('should start at 1', function()
      local reader = wio.FileReader('test/wio/bytes.bin', 2)
      assert.are.equals(reader._cursor, 1)
      assert.are.equals(reader._file:seek(), 2)
    end)

    describe('readBytes(n)', function()

      it('should return data and advance', function()
        local reader = wio.FileReader('test/wio/bytes.bin', 2)
        assert.are.equals(reader:readBytes(7), 'MARCELO')
        assert.are.equals(reader._cursor, 1)
        assert.are.equals(reader._file:seek(), 8)
      end)

      it('should return nil and not advance if not enough data', function()
        local reader = wio.FileReader('test/wio/bytes.bin', 2)
        assert.is_nil(reader:readBytes(666))
        assert.are.equals(reader._cursor, 1)
        assert.are.equals(reader._file:seek(), 2)
      end)
    end)

    describe('readUntil(d)', function()

      it('should return data without delimiter and advance', function()
        local reader = wio.FileReader('test/wio/bytes.bin', 2)
        assert.are.equals(reader:readUntil(' '), 'MARCELO')
        assert.are.equals(reader._cursor, 3)
        assert.are.equals(reader._file:seek(), 8)
      end)

      it('should return data with delimiter and advance', function()
        local reader = wio.FileReader('test/wio/bytes.bin', 2)
        assert.are.equals(reader:readUntil(' ', {inclusive = true}), 'MARCELO ')
        assert.are.equals(reader._cursor, 3)
        assert.are.equals(reader._file:seek(), 8)
      end)

      it('should return nil and not advance if not found', function()
        local reader = wio.FileReader('test/wio/bytes.bin', 2)
        assert.is_nil(reader:readUntil('XABLAU'))
        assert.are.equals(reader._cursor, 1)
        assert.are.equals(reader._file:seek(), 2)
      end)
    end)

    describe('skip(n)', function()

      it('should advance', function()
        local reader = wio.FileReader('test/wio/bytes.bin', 2)
        reader:skip(5)
        assert.are.equals(reader._cursor, 1)
        assert.are.equals(reader._file:seek(), 6)
      end)

      it('should stop at end', function()
        local reader = wio.FileReader('test/wio/bytes.bin', 2)
        reader:skip(666)
        assert.are.equals(reader._cursor, 1)
        assert.are.equals(reader._file:seek(), 15)
      end)
    end)

    describe('bytes(n)', function()

      it('should return data if enough data', function()
        local reader = wio.FileReader('test/wio/bytes.bin')
        assert.are.equals(reader:bytes(4), 'MARC')
      end)

      it('should return data if just enough data', function()
        local reader = wio.FileReader('test/wio/bytes.bin')
        assert.are.equals(reader:bytes(7), 'MARCELO')
      end)

      it('should return nil if not enough data', function()
        local reader = wio.FileReader('test/wio/bytes.bin')
        assert.is_nil(reader:bytes(50))
      end)
    end)

    describe('string()', function()

      it('should return data up to terminator', function()
        local reader = wio.FileReader('test/wio/string.bin')
        assert.are.equals(reader:string(), 'MARCELO HOSSOMI')
      end)

      it('should return nil if no terminator', function()
        local reader = wio.FileReader('test/wio/bytes.bin')
        assert.is_nil(reader:string())
      end)
    end)

    describe('int()', function()

      it('should read little endian', function()
        local reader = wio.FileReader('test/wio/integer.bin')
        assert.are.equals(reader:int(), 1)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/empty.bin')
        assert.are.is_nil(reader:int())
      end)
    end)

    describe('short()', function()

      it('should read little endian', function()
        local reader = wio.FileReader('test/wio/short.bin')
        assert.are.equals(reader:short(), 1)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/empty.bin')
        assert.are.is_nil(reader:short())
      end)
    end)

    describe('real()', function()

      it('should read little endian', function()
        local reader = wio.FileReader('test/wio/real.bin')
        assert.is_true(math.abs(reader:real() - 1.23) < 1E-6)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/empty.bin')
        assert.are.is_nil(reader:real())
      end)
    end)
  end)

  describe('FileWriter', function()

    before_each(function()
      writer = wio.FileWriter('test/wio/out.bin', 4)

      assert.data = function(expected)
        writer:close()
        local file = assert(io.open('test/wio/out.bin', 'rb'))
        assert.are.equals(expected, file:read('*all'))
      end
    end)

    after_each(function()
      os.remove('test/wio/out.bin')
    end)

    it('should flush buffer on write', function()
      writer:write('ABCDEF')
      assert.data('ABCDEF')
    end)

    it('should flush buffer on close', function()
      writer:write('AB')
      assert.data('AB')
    end)

    it('should write bytes', function()
      writer:bytes('MARCELO HOSSOMI')
      assert.data('MARCELO HOSSOMI')
    end)

    it('should write string with terminator', function()
      writer:string('MARCELO HOSSOMI')
      assert.data('MARCELO HOSSOMI' .. '\0')
    end)

    it('should write integer little endian', function()
      writer:int(1)
      assert.data(util.hexToBin('01000000'))
    end)

    it('should write short little endian', function()
      writer:short(1)
      assert.data(util.hexToBin('0100'))
    end)

    it('should write real little endian', function()
      writer:real(1.23)
      assert.data(util.hexToBin('A4709D3F'))
    end)
  end)

  it('should write and read', function()
    local writer = wio.FileWriter('test/wio/out.bin')
    writer:bytes('ABCD')
    writer:string('MARCELO HOSSOMI')
    writer:int(1)
    writer:short(10)
    writer:real(1.23)
    writer:close()

    local reader = wio.FileReader('test/wio/out.bin')
    assert.are.equals(reader:bytes(4), 'ABCD')
    assert.are.equals(reader:string(), 'MARCELO HOSSOMI')
    assert.are.equals(reader:int(), 1)
    assert.are.equals(reader:short(), 10)
    assert.is_true(math.abs(reader:real() - 1.23) < 1E-6)
    reader:close()

    os.remove('test/wio/out.bin')
  end)
end)
