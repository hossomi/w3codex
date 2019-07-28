describe('Util:', function()
  local util = require 'util'

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
end)
