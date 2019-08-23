local function RangeList()
  local list = {
    ranges = {},

    add = function(self, from, to)
      if from and to then
        table.insert(self.ranges, {from, to})
      end
    end
  }

  return setmetatable(list, {
    __pairs = function(self)
      local i = 0
      local function nextRange(list)
        i = i + 1
        if list.ranges[i] ~= nil then
          return list.ranges[i][1], list.ranges[i][2]
        end
      end
      return nextRange, self, nil
    end,

    __len = function(self)
      return #self.ranges
    end
  })
end

return RangeList