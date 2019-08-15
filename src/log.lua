local logging = require 'logging'
local colors = require 'term.colors'

local COLORS = {
  DEBUG = colors.bright .. colors.blue,
  INFO = colors.bright .. colors.green,
  WARN = colors.bright .. colors.yellow,
  ERROR = colors.bright .. colors.red,
  FATAL = colors.bright .. colors.magenta
}
local COLOR_RESET = tostring(colors.reset)

local function format(level, message)
  return table.concat({
    tostring(os.date('%d/%m/%Y %H:%M:%S')), ' ', COLORS[level], level,
    string.rep(' ', 6 - #level), COLOR_RESET, message
  })
end

return logging.new(function(self, level, message)
  print(format(level, message))
end)
