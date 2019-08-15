local util = require 'util'

describe('Util:', function()

  describe('format', function()

    describe('x2b(hex)', function()
      it('should work', function()
        assert.are.equals(util.format.x2b('4D415243454C4F'), 'MARCELO')
      end)
    end)

    describe('b2x(data)', function()
      it('should work', function()
        assert.are.equals(util.format.b2x('MARCELO'), '4D415243454C4F')
      end)
    end)

    describe('i2x(int)', function()
      it('should work (4 bytes little endian)', function()
        assert.are.equals(util.format.i2x(0x1020), '0x20100000')
      end)
    end)
  end)

  describe('flags', function()

    describe('msb(int)', function()
      it('should work', function()
        assert.are.equals(util.flags.msb(10), 4)
      end)

      it('should get 0 for 0', function()
        assert.are.equals(util.flags.msb(0), 0)
      end)

      it('should get 1 for 1', function()
        assert.are.equals(util.flags.msb(1), 1)
      end)
    end)

    describe('players(data)', function()
      it('should work', function()
        local players = util.flags.players(0x00000321)
        assert.are.same(players, {
          [0] = true,
          [1] = false,
          [2] = false,
          [3] = false,
          [4] = false,
          [5] = true,
          [6] = false,
          [7] = false,
          [8] = true,
          [9] = true,
          [10] = false,
          [11] = false,
          [12] = false,
          [13] = false,
          [14] = false,
          [15] = false,
          [16] = false,
          [17] = false,
          [18] = false,
          [19] = false,
          [20] = false,
          [21] = false,
          [22] = false,
          [23] = false,
          [24] = false,
          [25] = false,
          [26] = false,
          [27] = false,
          [28] = false,
          [29] = false,
          [30] = false,
          [31] = false,
          int = players.int
        })
      end)

      it('int() should work', function()
        local players = util.flags.players(0x00000101)
        assert.are.equals(players:int(), 0x00000101)
      end)

      it('tostring(players) should work', function()
        local players = util.flags.players(0x00000101)
        assert.are.equals(tostring(players), '0x01010000')
      end)

      it('ipairs(players) should iterate all', function()
        local players = util.flags.players(0x00000101)

        local calls = spy.new()
        for k, v in ipairs(players) do
          calls(k, v)
        end

        assert.spy(calls).called(32)
        assert.spy(calls).called_with(0, true)
        assert.spy(calls).called_with(1, false)
        assert.spy(calls).called_with(8, true)
        assert.spy(calls).called_with(9, false)
        -- Lazy...
      end)
    end)

    describe('map(int, mapping)', function()
      it('should work without mappings', function()
        local flags = util.flags.map(0xC0010103)
        assert.is_true(flags[0x00000001])
        assert.is_true(flags[0x00000002])
        assert.is_false(flags[0x00000004])
        assert.is_false(flags[0x00000008])
        assert.is_false(flags[0x00000010])
        assert.is_false(flags[0x00000020])
        assert.is_false(flags[0x00000040])
        assert.is_false(flags[0x00000080])
        assert.is_true(flags[0x00000100])
        assert.is_false(flags[0x00000200])
        assert.is_false(flags[0x00000400])
        assert.is_false(flags[0x00000800])
        assert.is_false(flags[0x00001000])
        assert.is_false(flags[0x00002000])
        assert.is_false(flags[0x00004000])
        assert.is_false(flags[0x00008000])
        assert.is_true(flags[0x00010000])
        assert.is_false(flags[0x00020000])
        assert.is_false(flags[0x00040000])
        assert.is_false(flags[0x00080000])
        assert.is_false(flags[0x00100000])
        assert.is_false(flags[0x00200000])
        assert.is_false(flags[0x00400000])
        assert.is_false(flags[0x00800000])
        assert.is_false(flags[0x01000000])
        assert.is_false(flags[0x02000000])
        assert.is_false(flags[0x04000000])
        assert.is_false(flags[0x08000000])
        assert.is_false(flags[0x10000000])
        assert.is_false(flags[0x20000000])
        assert.is_true(flags[0x40000000])
        assert.is_true(flags[0x80000000])
      end)

      it('should work with mappings', function()
        local flags = util.flags.map(0xC0010103, {
          a = 0x00000001,
          b = 0x00000004,
          c = 0x00010000,
          d = 0x00020000,
          e = 0x80000000
        })

        assert.is_true(flags.a)
        assert.is_false(flags.b)
        assert.is_true(flags.c)
        assert.is_false(flags.d)
        assert.is_true(flags.e)
      end)

      it('int() should work', function()
        local flags = util.flags.map(0x00000101)
        assert.are.equals(flags:int(), 0x00000101)
      end)

      it('tostring(flags) should work', function()
        local flags = util.flags.map(0x00000101)
        assert.are.equals(tostring(flags), '0x01010000')
      end)

      it('should reflect mapping change', function()
        local flags = util.flags.map(0x00000001,
                          {a = 0x00000001, b = 0x00000002})
        assert.are.equals(flags.a, flags[0x00000001])
        assert.are.equals(flags.b, flags[0x00000002])

        flags.a = false
        flags.b = true
        assert.are.equals(flags.a, flags[0x00000001])
        assert.are.equals(flags.b, flags[0x00000002])
      end)

      it('should reflect change to mapping', function()
        local flags = util.flags.map(0x00000001,
                          {a = 0x00000001, b = 0x00000002})

        assert.are.equals(flags.a, flags[0x00000001])
        assert.are.equals(flags.b, flags[0x00000002])

        flags[0x00000001] = false
        flags[0x00000002] = true
        assert.are.equals(flags.a, flags[0x00000001])
        assert.are.equals(flags.b, flags[0x00000002])
      end)

      it('pairs(flags) should iterate mappings', function()
        local flags = util.flags.map(0x00000001,
                          {a = 0x00000001, b = 0x00000002})

        local calls = spy.new()
        for k, v in pairs(flags) do
          calls(k, v)
        end

        assert.spy(calls).called(2)
        assert.spy(calls).called_with('a', true)
        assert.spy(calls).called_with('b', false)
      end)

      it('ipairs(flags) should iterate bits', function()
        local flags = util.flags.map(0x00000001,
                          {a = 0x00000001, b = 0x00000002})

        local calls = spy.new()
        for k, v in ipairs(flags) do
          calls(k, v)
        end

        assert.spy(calls).called(32)
        assert.spy(calls).called_with(0x00000001, true)
        assert.spy(calls).called_with(0x00000002, false)
        -- Too lazy to check all others
      end)
    end)
  end)
end)
