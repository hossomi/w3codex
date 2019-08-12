local wio = require 'src.wio'
local util = require 'src.util'
local log = require 'src.log'
require 'src.constants'

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

    unknown1 = reader:bytes(16),

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
    unknown = reader:bounds('LTRB', 'f'), -- Repeat camera bounds counter-clockwise?
    complements = reader:bounds('LRBT', 'i4'),
    playable = reader:rect('WH', 'i4')
  }

  map.area.width = map.area.complements.left + map.area.complements.right
                       + map.area.playable.width
  map.area.height = map.area.complements.top + map.area.complements.bottom
                        + map.area.playable.height

  local flags = reader:int()
  map.settings = {
    hideMinimap = flags & 0x0001 ~= 0,
    isMeleeMap = flags & 0x0004 ~= 0,
    isMaskedAreaVisible = flags & 0x0010 ~= 0,
    showWavesOnCliffShores = flags & 0x0800 ~= 0,
    showWavesOnRollingShores = flags & 0x1000 ~= 0
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

  map.unknown2 = reader:string(4)

  map.fog = {
    type = FOG_TYPES[reader:int()],
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

  map.unknown3 = reader:int()

  -- ====================
  -- PLAYERS
  -- 
  -- Player ID
  --  In-game player ID, ranges from 0 to MAX_PLAYERS - 1 and may contain holes.
  --
  -- Player index
  --  Index in the player list, ranges from 1 to number of players in the map.
  -- ====================

  local playerId = {} -- Player index to player ID map
  local playerIndex = {} -- Player ID to player index map

  for p = 1, reader:int() do
    local player = {start = {}, allyPriorities = {}, techtree = {}}

    player.id = reader:int()
    player.type = PLAYER_TYPES[reader:int()]
    player.race = RACES[reader:int()]
    player.start.fixed = reader:int() == 1
    player.name = reader:string()
    player.start.x = reader:real()
    player.start.y = reader:real()

    local low = reader:int()
    local high = reader:int()
    for a = 1, MAX_PLAYERS do
      player.allyPriorities[a - 1] = (low & 0x1 ~= 0 and PRIORITY_LOW)
                                         or (high & 0x1 ~= 0 and PRIORITY_HIGH)
                                         or PRIORITY_NONE
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
    force.allied = util.flags.msb(settings & 0x3)
    force.shared = util.flags.msb(settings >> 3 & 0x7)

    util.flags.forEachMap(reader:int() & MAX_PLAYERS_MASK, playerIndex,
        function(p)
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

    util.flags.forEachMap(players, playerIndex, function(p)
      if not map.players[p].techtree[id] then
        map.players[p].techtree[id] = {}
      end
      local upgrade = map.players[p].techtree[id]

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

    util.flags.forEachMap(players, playerIndex, function(p)
      map.players[p].techtree[id] = false
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
      group.types[p] = RANDOM_TYPES[reader:int() + 1]
    end

    for s = 1, reader:int() do
      group.sets[s] = {chance = reader:int(), objects = {}}
      for p = 1, #group.types do
        group.sets[s].objects[p] = util.filterNot(reader:bytes(4), EMPTY_ID, '')
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
        group.sets[s][i] = {
          chance = reader:int(),
          item = util.filterNot(reader:bytes(4), EMPTY_ID, '')
        }
      end
    end

    map.randomItems[g] = group
  end

  reader:close()
  return map
end

local function encode(map, path)
  local writer = wio.FileWriter(path)

  writer:int(28, map.version, map.editorVersion)
  writer:bytes(map.unknown1)
  writer:string(map.name, map.author, map.description, map.recommendedPlayers)

  writer:real(map.area.cameraBounds.left, map.area.cameraBounds.bottom,
      map.area.cameraBounds.right, map.area.cameraBounds.top)

  writer:real(map.area.cameraBounds.left, map.area.cameraBounds.top,
      map.area.cameraBounds.right, map.area.cameraBounds.bottom)

  writer:int(map.area.complements.left, map.area.complements.right,
      map.area.complements.bottom, map.area.complements.top,
      map.area.playable.width, map.area.playable.height)

  writer:int((map.settings.hideMinimap and 0x0001 or 0)
                 + (map.settings.isMeleeMap and 0x0004 or 0)
                 + (map.settings.isMaskedAreaVisible and 0x0010 or 0)
                 + (map.settings.showWavesOnCliffShores and 0x0800 or 0)
                 + (map.settings.showWavesOnRollingShores and 0x1000 or 0))

  writer:bytes(map.tileset)

  writer:int(map.loadingScreen.preset or -1)
  writer:string(map.loadingScreen.custom or '')
  writer:string(map.loadingScreen.text, map.loadingScreen.title,
      map.loadingScreen.subtitle)

  writer:int(map.dataset)
  writer:string(map.unknown2)

  writer:int(FOG_TYPES[map.fog.type])
  writer:real(map.fog.min, map.fog.max, map.fog.density)
  writer:color(map.fog.color)

  writer:bytes(map.weather.global or EMPTY_ID)
  writer:string(map.weather.sound or '')
  writer:bytes(map.weather.light or '\0')

  writer:color(map.water.color)
  writer:int(map.unknown3)

  -- ====================
  -- PLAYERS
  -- ====================

  writer:int(#map.players)
  for p = 1, #map.players do
    local player = map.players[p]
    writer:int(player.id, PLAYER_TYPES[player.type], RACES[player.race],
        player.start.fixed and 1 or 0)
    writer:string(player.name)
    writer:real(player.start.x, player.start.y)

    local low = 0x00000000
    local high = 0x00000000
    for a = 1, #player.allyPriorities do
      if player.allyPriorities[a] < 0 then
        low = low + math.pow(2, map.players[a].id)
      elseif player.allyPriorities[a] > 0 then
        high = high + math.pow(2, map.players[a].id)
      end
    end

    writer:int(low, high)
  end

  -- ====================
  -- FORCES
  -- ====================

  writer:int(#map.forces)
  for f = 1, #map.forces do
    local force = map.forces[f]
    writer:int((force.allied > 0 and 0x01 or 0)
                   + (force.allied > 1 and 0x02 or 0)
                   + (force.shared > 0 and 0x08 or 0)
                   + (force.shared > 1 and 0x10 or 0)
                   + (force.shared > 2 and 0x20 or 0))

    local players = 0x00000000
    for p = #map.players, 1, -1 do
      if map.players[p].force == f then
        players = players + 1
      end
      players = players << 1
    end
    writer:int(players)
    writer:string(force.name)
  end

  -- ====================
  -- UPGRADES
  -- ====================

  local upgrades = {}
  local techtree = {}

  local pmask = 0x00000001
  for p = 1, #map.players do
    local player = map.players[p]

    for id, u in pairs(player.techtree) do
      if type(u) == 'boolean' then
        techtree[#techtree + 1] = {player = pmask, id = id}
      else
        if u.researched then
          for l = 0, u.researched - 1 do
            upgrades[#upgrades + 1] = {
              player = pmask,
              id = id,
              level = l,
              availability = 2
            }
          end
        end
        if u.available then
          for l = u.available, u.levels - 1 do
            upgrades[#upgrades + 1] = {
              player = pmask,
              id = id,
              level = l,
              availability = 0
            }
          end
        end
      end
    end

    pmask = pmask << 1
  end

  writer:int(#upgrades)
  for u = 1, #upgrades do
    local upgrade = upgrades[u]
    writer:int(upgrade.player)
    writer:bytes(upgrade.id)
    writer:int(upgrade.level, upgrade.availability)
  end

  writer:int(#techtree)
  for t = 1, #techtree do
    local tech = techtree[t]
    writer:int(tech.player)
    writer:bytes(tech.id)
  end

  -- ====================
  -- RANDOM UNIT TABLES
  -- ====================

  writer:int(#map.randomGroups)
  for g = 1, #map.randomGroups do
    local group = map.randomGroups[g]
    writer:int(group.id)
    writer:string(group.name)

    writer:int(#group.types)
    for t = 1, #group.types do
      writer:int(RANDOM_TYPES[group.types[t]] - 1)
    end

    writer:int(#group.sets)
    for s = 1, #group.sets do
      writer:int(group.sets[s].chance)
      for t = 1, #group.types do
        writer:bytes(util.filterNot(group.sets[s].objects[t], '', EMPTY_ID))
      end
    end
  end

  -- ====================
  -- RANDOM ITEM TABLES
  -- ====================

  writer:int(#map.randomItems)
  for i = 1, #map.randomItems do
    local group = map.randomItems[i]
    writer:int(group.id)
    writer:string(group.name)
    writer:int(#group.sets)
    for s = 1, #group.sets do
      for i = 1, #group.sets[s] do
        writer:int(group.sets[s][i].chance)
        writer:bytes(util.filterNot(group.sets[s][i].item, '', EMPTY_ID))
      end
    end
  end

  writer:close()
end

map = decode('test/maps/' .. arg[1] .. '.w3x/war3map.w3i')
-- if arg[2] then
--   print(json.encode(map[arg[2]], {pretty = true}))
-- else
--   print(json.encode(map, {pretty = true}))
-- end

local yaml = require 'lyaml'
local file = assert(io.open('out/' .. arg[1] .. '.yml', 'w'))
file:write(yaml.dump({map}))
print(yaml.dump({map}))
file:close()

encode(map, 'out/' .. arg[1] .. '.w3i')
