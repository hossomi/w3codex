local wio = require 'src.wio'
local util = require 'src.util'
local json = require 'rapidjson'

local function decode(path)
  local reader = wio.FileReader(path)
  util.checkEqual(reader:int(), 28, 'Unsupported format version.')

  local map = {
    version = reader:int(),
    editorVersion = reader:int(),

    -- Unknown!
    reader:skip(16),

    name = reader:string(),
    author = reader:string(),
    description = reader:string(),
    recommendedPlayers = reader:string()
  }

  map.area = {
    cameraBounds = {
      left = reader:real(),
      bottom = reader:real(),
      right = reader:real(),
      top = reader:real()
    },

    -- Repeat camera bounds counter-clockwise?
    reader:skip(16),

    complements = {
      left = reader:int(),
      right = reader:int(),
      bottom = reader:int(),
      top = reader:int()
    },

    playable = {width = reader:int(), height = reader:int()}
  }

  map.area.width = map.area.complements.left + map.area.complements.right
                       + map.area.playable.width
  map.area.height = map.area.complements.top + map.area.complements.bottom
                        + map.area.playable.height

  local flags = reader:int()
  map.settings = {
    isMeleeMap = flags & 0x0004 == 1,
    isMaskedAreaVisible = flags & 0x0010 == 1,
    hideMinimap = flags & 0x0001 == 1,
    showWavesOnCliffShores = flags & 0x0800 == 1,
    showWavesOnRollingShores = flags & 0x1000 == 1,
    allyPriorities = {custom = flags & 0x0002 == 1},
    forces = {
      custom = flags & 0x0040 == 1,
      fixedPlayerSettings = flags & 0x0020 == 1
    },
    techtree = {custom = flags & 0x0080 == 1},
    abilities = {custom = flags & 0x0100 == 1},
    upgrades = {custom = flags & 0x0200 == 1}
  }

  map.tileset = reader:bytes(1)

  map.loading = {
    preset = util.filterNot(reader:int(), -1),
    custom = util.filterNot(reader:string(), ''),
    text = reader:string(),
    title = reader:string(),
    subtitle = reader:string()
  }

  map.dataset = reader:int()

  -- Unknown!
  reader:string()
  reader:string()
  reader:string()
  reader:string()

  map.fog = {
    type = reader:int(),
    min = reader:real(),
    max = reader:real(),
    density = reader:real(),
    color = reader:color()
  }

  map.weather = {
    global = util.filterNot(reader:int(), 0),
    sound = util.filterNot(reader:string(), ''),
    light = util.filterNot(reader:bytes(1), '\0')
  }

  map.water = {
    color = reader:color()
  }
  
  return map
end

map = decode('test/maps/sample-1.w3x/war3map.w3i')
-- writer = wio.FileWriter('test/json/map.json')
print(json.encode(map, {pretty = true}))
-- writer:close()
