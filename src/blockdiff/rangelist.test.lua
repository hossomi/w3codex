local RangeList = require 'src.blockdiff.rangelist'

describe('RangeList', function()
  it('should iterate added ranges', function()
    local list = RangeList()
    list:add(1, 2)
    list:add(3, 4)
    list:add(5, 6)

    result = {}
    for from, to in pairs(list) do
      table.insert(result, {from, to})
    end

    assert.are.same(result, {{1, 2}, {3, 4}, {5, 6}})
  end)

  it('should ignore ranges with no from', function()
    local list = RangeList()
    list:add(1, 2)
    list:add(nil, 4)
    list:add(5, 6)

    result = {}
    for from, to in pairs(list) do
      table.insert(result, {from, to})
    end

    assert.are.same(result, {{1, 2}, {5, 6}})
  end)

  it('should ignore ranges with no to', function()
    local list = RangeList()
    list:add(1, 2)
    list:add(3, nil)
    list:add(5, 6)

    result = {}
    for from, to in pairs(list) do
      table.insert(result, {from, to})
    end

    assert.are.same(result, {{1, 2}, {5, 6}})
  end)

  it('should get length', function()
    local list = RangeList()
    list:add(1, 2)
    list:add(3, 4)
    list:add(5, 6)

    assert.are.equal(#list, 3)
  end)

end)
