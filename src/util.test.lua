local util = require 'util'

describe('Util:', function()

  describe('hexToBin():', function()
    it('should work', function()
      assert.are.equals(util.hexToBin('4D415243454C4F20484F53534F4D49'),
          'MARCELO HOSSOMI')
    end)
  end)

  describe('binToHex():', function()
    it('should work', function()
      assert.are.equals(util.binToHex('MARCELO HOSSOMI'),
          '4D415243454C4F20484F53534F4D49')
    end)
  end)

  describe('Flags:', function()

    describe('forEachMap(flags, map, callback):', function()
  
      local map = {}
      map[0] = 'A'
      map[1] = 'B'
  
      local function doNothing()
      end
  
      it('should call callback for mapped bits', function()
        local callback = spy.new(doNothing)
  
        util.flags.forEachMap(10, map, callback)
        assert.spy(callback).was.called(1)
        assert.spy(callback).was.called_with('B')
        assert.spy(callback).was.not_called_with('A')
      end)
    end)
  
    describe('msb(flags):', function()
      it('should get MSB', function()
        assert.are.equals(util.flags.msb(10), 4)
      end)
  
      it('should get 0 for 0', function()
        assert.are.equals(util.flags.msb(0), 0)
      end)
  
      it('should get 1 for 1', function()
        assert.are.equals(util.flags.msb(1), 1)
      end)
    end)
  end)
end)
