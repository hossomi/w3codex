local wio = require 'src.wio'
local util = require 'src.util'
local flags = require 'src.flags'
local json = require 'rapidjson'

local MAX_PLAYERS = 24
local MAX_PLAYERS_MASK = 0x00FFFFFF
local EMPTY_ID = '\0\0\0\0'

local function min(a, b)
  if not a then
    return b
  elseif not b then
    return a
  end
  return math.min(a, b)
end

local function max(a, b)
  if not a then
    return b
  elseif not b then
    return a
  end
  return math.max(a, b)
end

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
    forces = {},
    randomGroups = {},
    randomItems = {}
  }

  map.area = {
    cameraBounds = reader:bounds('LBRT', 'f'),
    -- Repeat camera bounds counter-clockwise?
    reader:skip(16),
    complements = reader:bounds('LRBT', 'i4'),
    playable = reader:rect('WH', 'i4')
  }

  map.area.width = map.area.complements.left + map.area.complements.right
                       + map.area.playable.width
  map.area.height = map.area.complements.top + map.area.complements.bottom
                        + map.area.playable.height

  local mapFlags = reader:int()
  map.settings = {
    hideMinimap = mapFlags & 0x0001 ~= 0,
    isMeleeMap = mapFlags & 0x0004 ~= 0,
    isMaskedAreaVisible = mapFlags & 0x0010 ~= 0,
    showWavesOnCliffShores = mapFlags & 0x0800 ~= 0,
    showWavesOnRollingShores = mapFlags & 0x1000 ~= 0
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
    global = util.filterNot(reader:bytes(4), EMPTY_ID),
    sound = util.filterNot(reader:string(), ''),
    light = util.filterNot(reader:bytes(1), '\0')
  }

  map.water = {color = reader:color()}

  -- Unknown!
  reader:int()

  -- ====================
  -- PLAYERS
  -- ====================

  local playerId = {}
  local playerIndex = {}

  for p = 1, reader:int() do
    local player = {
      start = {},
      allyPriorities = {},
      disabled = {},
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
      player.allyPriorities[a - 1] = (low & 0x1 ~= 0 and -1)
                                         or (high & 0x1 ~= 0 and 1) or 0
      low = low >> 1
      high = high >> 1
    end

    map.players[p] = player
    playerId[p] = player.id
    playerIndex[player.id] = p
  end

  -- Remap ally priorities
  for p = 1, #map.players do
    local allyPriorities = {}
    for a = 1, #map.players do
      allyPriorities[a] = map.players[p].allyPriorities[playerId[a]]
    end
    map.players[p].allyPriorities = allyPriorities
  end

  -- ====================
  -- FORCES
  -- ====================

  for f = 1, reader:int() do
    local force = {}

    local settings = reader:int()
    force.allied = flags.msb(settings & 0x3)
    force.shared = flags.msb(settings >> 3 & 0x7)

    flags.forEachMap(reader:int() & MAX_PLAYERS_MASK, playerIndex, function(p)
      map.players[p].force = f
    end)

    force.name = reader:string()
    map.forces[f] = force
  end

  -- ====================
  -- UPGRADES
  -- ====================

  for u = 1, reader:int() do
    local players = reader:int() & MAX_PLAYERS_MASK
    local id = reader:bytes(4)
    local level = reader:int()
    local availability = reader:int()

    flags.forEachMap(players, playerIndex, function(p)
      if not map.players[p].upgrades[id] then
        map.players[p].upgrades[id] = {}
      end
      local upgrade = map.players[p].upgrades[id]

      if availability == 0 then
        upgrade.available = min(upgrade.available, level)
        upgrade.levels = max(upgrade.levels, level + 1)
      elseif availability == 2 then
        upgrade.researched = max(upgrade.researched, level + 1)
      end
    end)
  end

  -- ====================
  -- DISABLED TECHTREE
  -- ====================

  for t = 1, reader:int() do
    local players = reader:int() & MAX_PLAYERS_MASK
    local id = reader:bytes(4)

    flags.forEachMap(players, playerIndex, function(p)
      map.players[p].disabled[id] = true
    end)
  end

  -- ====================
  -- RANDOM UNIT TABLES
  -- ====================

  for g = 1, reader:int() do
    local group = {
      id = reader:int(),
      name = reader:string(),
      types = {},
      sets = {}
    }

    for p = 1, reader:int() do
      group.types[p] = reader:int()
    end

    for s = 1, reader:int() do
      group.sets[s] = {chance = reader:int(), entries = {}}
      for p = 1, #group.types do
        group.sets[s].entries[p] = util.filterNot(reader:bytes(4), EMPTY_ID, '')
      end
    end

    map.randomGroups[g] = group
  end

  -- ====================
  -- RANDOM ITEM TABLES
  -- ====================

  for g = 1, reader:int() do
    local group = {id = reader:int(), name = reader:string(), sets = {}}

    for s = 1, reader:int() do
      group.sets[s] = {}
      for i = 1, reader:int() do
        local chance = reader:int()
        local id = util.filterNot(reader:bytes(4), EMPTY_ID, '')
        group.sets[s][id] = chance
      end
    end

    map.randomItems[g] = group
  end

  reader:close()
  return map
end

map = decode('test/maps/' .. arg[1] .. '.w3x/war3map.w3i')
if arg[2] then
  print(json.encode(map[arg[2]], {pretty = true}))
else
  print(json.encode(map, {pretty = true}))
end
