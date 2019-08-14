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

      it('should read multiple', function()
        local reader = wio.FileReader('test/wio/string-two.bin')
        local a, b = reader:string(2)
        assert.are.equals(a, 'MARCELO YUKIO')
        assert.are.equals(b, 'BRESSAN HOSSOMI')
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

      it('should read multiple', function()
        local reader = wio.FileReader('test/wio/bounds-integer.bin')
        local a, b = reader:int(2)
        assert.are.equals(a, 1)
        assert.are.equals(b, 2)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/empty.bin')
        assert.is_nil(reader:int())
      end)
    end)

    describe('short()', function()

      it('should read little endian', function()
        local reader = wio.FileReader('test/wio/short.bin')
        assert.are.equals(reader:short(), 1)
      end)

      it('should read multiple', function()
        local reader = wio.FileReader('test/wio/integer.bin')
        local a, b = reader:short(2)
        assert.are.equals(a, 1)
        assert.are.equals(b, 0)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/empty.bin')
        assert.is_nil(reader:short())
      end)
    end)

    describe('real()', function()

      it('should read little endian', function()
        local reader = wio.FileReader('test/wio/real.bin')
        assert.is_true(math.abs(reader:real() - 1.23) < 1E-6)
      end)

      it('should read multiple', function()
        local reader = wio.FileReader('test/wio/bounds-real.bin')
        local a, b = reader:real(2)
        assert.is_true(math.abs(a - 1.1) < 1E-6)
        assert.is_true(math.abs(b - 1.2) < 1E-6)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/empty.bin')
        assert.is_nil(reader:real())
      end)
    end)

    describe('color()', function()

      it('should read in order', function()
        local reader = wio.FileReader('test/wio/color.bin')
        assert.are.same(reader:color(),
            {red = 160, green = 176, blue = 192, alpha = 208})
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/short.bin')
        assert.is_nil(reader:color())
      end)
    end)

    describe('bounds(format, type)', function()

      it('should read with i4', function()
        local reader = wio.FileReader('test/wio/bounds-integer.bin')
        assert.are.same(reader:bounds('LTRB', 'i4'),
            {left = 1, top = 2, right = 3, bottom = 4})
      end)

      it('should read with f', function()
        local reader = wio.FileReader('test/wio/bounds-real.bin')
        local bounds = reader:bounds('LTRB', 'f')
        assert.is_true(math.abs(bounds.left - 1.1) < 1E-6)
        assert.is_true(math.abs(bounds.top - 1.2) < 1E-6)
        assert.is_true(math.abs(bounds.right - 1.3) < 1E-6)
        assert.is_true(math.abs(bounds.bottom - 1.4) < 1E-6)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/integer.bin')
        assert.is_nil(reader:bounds('LTRB', 'i4'))
      end)
    end)

    describe('rect(format, type)', function()

      it('should read with i4', function()
        local reader = wio.FileReader('test/wio/bounds-integer.bin')
        assert.are.same(reader:rect('WH', 'i4'), {width = 1, height = 2})
      end)

      it('should read with f', function()
        local reader = wio.FileReader('test/wio/bounds-real.bin')
        local rect = reader:rect('WH', 'f')
        assert.is_true(math.abs(rect.width - 1.1) < 1E-6)
        assert.is_true(math.abs(rect.height - 1.2) < 1E-6)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/integer.bin')
        assert.is_nil(reader:rect('WH', 'i4'))
      end)
    end)

    describe('flags()', function()

      it('should read as booleans', function()
        local reader = wio.FileReader('test/wio/real.bin')
        local flags = reader:flags({
          a = 0x00000001,
          b = 0x00000002,
          c = 0x00001000,
          d = 0x00800000,
          e = 0x20000000,
          f = 0x80000000
        })
        assert.is_false(flags.a)
        assert.is_false(flags.b)
        assert.is_true(flags.c)
        assert.is_true(flags.d)
        assert.is_true(flags.e)
        assert.is_false(flags.f)
      end)

      it('should return nil if no more data', function()
        local reader = wio.FileReader('test/wio/short.bin')
        assert.is_nil(reader:flags({}))
      end)
    end)
  end)

  describe('FileWriter', function()

    before_each(function()
      writer = wio.FileWriter('test/wio/out.bin', 4)

      assert.data = function(expected)
        writer:close()
        local file = assert(io.open('test/wio/out.bin', 'rb'))
        assert.are.equals(file:read('*all'), expected)
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

    describe('string()', function()

      it('should write string with terminator', function()
        writer:string('MARCELO HOSSOMI')
        assert.data('MARCELO HOSSOMI\0')
      end)

      it('should write multiple', function()
        writer:string('MARCELO YUKIO', 'BRESSAN HOSSOMI')
        assert.data('MARCELO YUKIO\0BRESSAN HOSSOMI\0')
      end)
    end)

    describe('int()', function()

      it('should write integer little endian', function()
        writer:int(1)
        assert.data(util.format.x2b('01000000'))
      end)

      it('should write multiple', function()
        writer:int(1, 2)
        assert.data(util.format.x2b('0100000002000000'))
      end)
    end)

    describe('short()', function()

      it('should write short little endian', function()
        writer:short(1)
        assert.data(util.format.x2b('0100'))
      end)

      it('should write multiple', function()
        writer:short(1, 2)
        assert.data(util.format.x2b('01000200'))
      end)
    end)

    describe('real()', function()

      it('should write real little endian', function()
        writer:real(1.23)
        assert.data(util.format.x2b('A4709D3F'))
      end)

      it('should write multiple', function()
        writer:real(1.23, 1.23)
        assert.data(util.format.x2b('A4709D3FA4709D3F'))
      end)
    end)

    it('should write color', function()
      writer:color({red = 65, green = 66, blue = 67, alpha = 68})
      assert.data('ABCD')
    end)

    it('should write flags', function ()
      writer:flags(util.flags.parse(0xA0004001))
      assert.data(util.format.x2b('014000A0'))
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
