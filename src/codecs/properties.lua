local wio = require 'src.wio'
local util = require 'src.util'
local json = require 'rapidjson'

local MAX_PLAYERS = 24

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
    recommendedPlayers = reader:string(),

    players = {},
    forces = {}
  }

  map.area = {
    cameraBounds = reader:bounds('LBRT', 'f'),

    -- Repeat camera bounds counter-clockwise?
    reader:skip(16),

    complements = reader:bounds('LRBT'),

    playable = {width = reader:int(), height = reader:int()}
  }

  map.area.width = map.area.complements.left + map.area.complements.right
                       + map.area.playable.width
  map.area.height = map.area.complements.top + map.area.complements.bottom
                        + map.area.playable.height

  local flags = reader:int()
  map.settings = {
    isMeleeMap = flags & 0x0004 ~= 0,
    isMaskedAreaVisible = flags & 0x0010 ~= 0,
    hideMinimap = flags & 0x0001 ~= 0,
    showWavesOnCliffShores = flags & 0x0800 ~= 0,
    showWavesOnRollingShores = flags & 0x1000 ~= 0,
    allyPriorities = {custom = flags & 0x0002 ~= 0},
    forces = {
      custom = flags & 0x0040 ~= 1,
      fixedPlayerSettings = flags & 0x0020 ~= 1
    },
    techtree = {custom = flags & 0x0080 ~= 1},
    abilities = {custom = flags & 0x0100 ~= 1},
    upgrades = {custom = flags & 0x0200 ~= 1}
  }

  map.tileset = reader:bytes(1)

  map.loadingScreen = {
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
    global = util.filterNot(reader:bytes(4), '\0\0\0\0'),
    sound = util.filterNot(reader:string(), ''),
    light = util.filterNot(reader:bytes(1), '\0')
  }

  map.water = {color = reader:color()}

  -- Unknown!
  reader:int()

  local playerIndex = {}
  local P = reader:int()
  for p = 1, P do
    local player = {
      start = {},
      allyPriorities = {},
      techtree = {},
      upgrades = {}
    }

    player.id = reader:int()
    player.type = reader:int()
    player.race = reader:int()
    player.start.fixed = reader:int() == 1
    player.name = reader:string()
    player.start.x = reader:real()
    player.start.y = reader:real()

    local low = reader:int()
    local high = reader:int()
    for a = 1, MAX_PLAYERS do
      if low & 0x0001 == 1 then
        player.allyPriorities[a] = -1
      elseif high & 0x0001 == 1 then
        player.allyPriorities[a] = 1
      else
        player.allyPriorities[a] = 0
      end

      low = low >> 1
      high = high >> 1
    end

    playerIndex[p] = player.id + 1
    map.players[p] = player
  end

  -- Now that we know all players, filter ally priorities
  for p = 1, #map.players do
    local allyPriorities = {}
    for a = 1, #map.players do
      allyPriorities[a] = map.players[p].allyPriorities[playerIndex[a]]
    end
    map.players[p].allyPriorities = allyPriorities
  end

  for f = 1, reader:int() do
    local force = {}

    local flags = reader:int()
    force.allied = flags & 0x0001 ~= 0
    force.alliedVictory = flags & 0x0002 ~= 0
    force.sharedVision = flags & 0x0008 ~= 0
    force.sharedUnitControl = flags & 0x0010 ~= 0
    force.shareAdvancedUnitControl = flags & 0x0020 ~= 0

    local players = reader:int()
    for p = 1, MAX_PLAYERS do
      if map.players[p] and players & 0x0001 == 1 then
        map.players[p].force = f
      end
      players = players >> 1
    end

    force.name = reader:string()
    map.forces[f] = force
  end

  for u = 1, reader:int() do
    local players = reader:int()
    local id = reader:bytes(4)
    local level = reader:int()
    local availability = reader:int()

    for p = 1, MAX_PLAYERS do
      if map.players[p] and players & 0x0001 == 1 then
        local upgrade = map.players[p].upgrades[id]
        if not upgrade then
          upgrade = {}
          map.players[p].upgrades[id] = upgrade
        end

        if availability == 0 then
          upgrade.available = upgrade.available
                                  and math.min(upgrade.available, level) or level
          upgrade.levels =
              upgrade.levels and math.max(upgrade.levels, level + 1) or level + 1
        elseif availability == 2 then
          upgrade.researched = upgrade.researched
                                   and math.max(upgrade.researched, level + 1)
                                   or level + 1
        end
      end

      players = players >> 1
    end

  end

  for t = 1, reader:int() do
    local players = reader:int()
    local id = reader:bytes(4)

    for p = 1, MAX_PLAYERS do
      if map.players[p] and players & 0x0001 == 1 then
        map.players[p].techtree[id] = false
        players = players >> 1
      end
    end
  end

  return map
end

map = decode('test/maps/sample-2.w3x/war3map.w3i')
-- writer = wio.FileWriter('test/json/map.json')
print(json.encode(map, {pretty = true}))
-- writer:close()
