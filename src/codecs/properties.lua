local wio = require 'src.wio'
local util = require 'src.util'
local log = require 'src.log'
local yaml = require 'lyaml'
require 'src.constants'

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

return {

  decode = function(self, path)
    local reader = wio.FileReader(path)

    local properties = {
      formatVersion = util.check.equal(reader:int(), 28,
          'Unsupported format version.'),
      version = reader:int(),
      editorVersion = reader:int(),

      -- No idea what these 16 bytes are.
      unknown1 = util.format.b2x(reader:bytes(16)),

      name = reader:string(),
      author = reader:string(),
      description = reader:string(),
      recommendedPlayers = reader:string(),

      players = {},
      forces = {},
      upgrades = {},
      techtree = {},
      randomGroups = {},
      randomItems = {}
    }

    reader:tag('properties.area')
    properties.area = {
      cameraBounds = reader:bounds('LBRT', 'f'),
      -- Repeat camera bounds counter-clockwise?
      unknown2 = reader:bounds('LTRB', 'f'),
      complements = reader:bounds('LRBT', 'i4'),
      playable = reader:rect('WH', 'i4')
    }

    reader:tag('properties.settings')
    properties.settings = reader:flags({
      hideMinimap = 0x00000001,
      customAllyPriorities = 0x00000002,
      isMeleeMap = 0x00000004,
      isMaskedAreaVisible = 0x00000010,
      fixedPlayerSettings = 0x00000020,
      customForces = 0x00000040,
      customTechtree = 0x00000080,
      customAbilities = 0x00000100,
      customUpgrades = 0x00000200,
      showWavesOnCliffShores = 0x00000800,
      showWavesOnRollingShores = 0x00001000
    })

    properties.tileset = reader:bytes(1)

    reader:tag('properties.loadingScreen')
    properties.loadingScreen = {
      preset = reader:int(),
      custom = reader:string(),
      text = reader:string(),
      title = reader:string(),
      subtitle = reader:string()
    }

    properties.dataset = reader:int()

    -- Supposedly prologue screen data, but seems unreachable.
    properties.unknown3 = {reader:string(4)}

    reader:tag('properties.fog')
    properties.fog = {
      type = reader:int(),
      min = reader:real(),
      max = reader:real(),
      density = reader:real(),
      color = reader:color()
    }

    reader:tag('properties.weather')
    properties.weather = {
      global = reader:bytes(4),
      sound = reader:string(),
      light = reader:bytes(1)
    }

    reader:tag('properties.water')
    properties.water = {color = reader:color()}

    -- Really no idea what this is.
    properties.unknown4 = reader:int()

    -- ====================
    -- PLAYERS
    -- ====================

    reader:tag('properties.players')
    for p = 1, reader:int() do
      reader:tag('properties.players[' .. p .. ']')
      properties.players[p] = {
        id = reader:int(),
        type = reader:int(),
        race = reader:int(),
        fixedStartLocation = reader:int() == 1,
        name = reader:string(),
        startLocationX = reader:real(),
        startLocationY = reader:real(),
        lowAllyPriorities = reader:players(),
        highAllyPriorities = reader:players()
      }
    end

    -- ====================
    -- FORCES
    -- ====================

    reader:tag('properties.forces')
    for f = 1, reader:int() do
      reader:tag('properties.forces[' .. f .. ']')
      properties.forces[f] = {
        settings = reader:flags({
          allied = 0x00000001,
          alliedVictory = 0x00000002,
          sharedVision = 0x00000008,
          sharedControl = 0x00000010,
          sharedAdvancedControl = 0x00000020
        }),
        players = reader:players(),
        name = reader:string()
      }
    end

    -- ====================
    -- UPGRADES
    -- ====================

    reader:tag('properties.upgrades')
    for u = 1, reader:int() do
      reader:tag('properties.upgrades[' .. u .. ']')
      properties.upgrades[u] = {
        players = reader:players(playerIndex),
        id = reader:bytes(4),
        level = reader:int(),
        availability = reader:int()
      }
    end

    -- ====================
    -- DISABLED TECHTREE
    -- ====================

    reader:tag('properties.techtree')
    for t = 1, reader:int() do
      reader:tag('properties.techtree[' .. t .. ']')
      properties.techtree[t] = {
        players = reader:players(playerIndex),
        id = reader:bytes(4)
      }
    end

    -- ====================
    -- RANDOM GROUPS
    -- ====================

    reader:tag('properties.randomGroups')
    for g = 1, reader:int() do
      reader:tag('properties.randomGroups[' .. g .. ']')
      properties.randomGroups[g] = {
        id = reader:int(),
        name = reader:string(),
        types = {},
        sets = {}
      }

      for p = 1, reader:int() do
        properties.randomGroups[g].types[p] = reader:int()
      end

      for s = 1, reader:int() do
        properties.randomGroups[g].sets[s] =
            {chance = reader:int(), objects = {}}

        for p = 1, #properties.randomGroups[g].types do
          properties.randomGroups[g].sets[s].objects[p] = reader:bytes(4)
        end
      end
    end

    -- ====================
    -- RANDOM ITEM TABLES
    -- ====================

    reader:tag('properties.randomItems')
    for g = 1, reader:int() do
      reader:tag('properties.randomItems[' .. g .. ']')
      properties.randomItems[g] = {
        id = reader:int(),
        name = reader:string(),
        sets = {}
      }

      for s = 1, reader:int() do
        properties.randomItems[g].sets[s] = {}
        for i = 1, reader:int() do
          properties.randomItems[g].sets[s][i] =
              {chance = reader:int(), item = reader:bytes(4)}
        end
      end
    end

    reader:close()
    return properties, reader.tags
  end,

  encode = function(self, properties, path)
    local writer = wio.FileWriter(path)

    writer:int(properties.formatVersion, properties.version,
        properties.editorVersion)
    writer:bytes(util.format.x2b(properties.unknown1))
    writer:string(properties.name, properties.author, properties.description,
        properties.recommendedPlayers)

    writer:tag('properties.area')
    writer:real(properties.area.cameraBounds.left,
        properties.area.cameraBounds.bottom, properties.area.cameraBounds.right,
        properties.area.cameraBounds.top)

    writer:real(properties.area.unknown2.left, properties.area.unknown2.top,
        properties.area.unknown2.right, properties.area.unknown2.bottom)

    writer:int(properties.area.complements.left,
        properties.area.complements.right, properties.area.complements.bottom,
        properties.area.complements.top, properties.area.playable.width,
        properties.area.playable.height)

    writer:tag('properties.settings')
    properties.settings = writer:flags(properties.settings)

    writer:bytes(properties.tileset)

    writer:tag('properties.loadingScreen')
    writer:int(properties.loadingScreen.preset)
    writer:string(properties.loadingScreen.custom)
    writer:string(properties.loadingScreen.text, properties.loadingScreen.title,
        properties.loadingScreen.subtitle)

    writer:int(properties.dataset)
    writer:string(table.unpack(properties.unknown3))

    writer:tag('properties.fog')
    writer:int(properties.fog.type)
    writer:real(properties.fog.min, properties.fog.max, properties.fog.density)
    writer:color(properties.fog.color)

    writer:tag('properties.weather')
    writer:bytes(properties.weather.global)
    writer:string(properties.weather.sound)
    writer:bytes(properties.weather.light)

    writer:tag('properties.water')
    writer:color(properties.water.color)
    writer:int(properties.unknown4)

    -- ====================
    -- PLAYERS
    -- ====================

    writer:tag('properties.players')
    writer:int(#properties.players)
    for p = 1, #properties.players do
      writer:tag('properties.players[' .. p .. ']')
      local player = properties.players[p]
      writer:int(player.id, player.type, player.race,
          player.fixedStartLocation and 1 or 0)
      writer:string(player.name)
      writer:real(player.startLocationX, player.startLocationY)
      writer:players(player.lowAllyPriorities)
      writer:players(player.highAllyPriorities)
    end

    -- ====================
    -- FORCES
    -- ====================

    writer:tag('properties.forces')
    writer:int(#properties.forces)
    for f = 1, #properties.forces do
      writer:tag('properties.forces[' .. f .. ']')
      local force = properties.forces[f]
      writer:flags(force.settings)
      writer:players(force.players)
      writer:string(force.name)
    end

    -- ====================
    -- UPGRADES
    -- ====================

    writer:tag('properties.upgrades')
    writer:int(#properties.upgrades)
    for u = 1, #properties.upgrades do
      writer:tag('properties.upgrades[' .. u .. ']')
      local upgrade = properties.upgrades[u]
      writer:players(upgrade.players)
      writer:bytes(upgrade.id)
      writer:int(upgrade.level, upgrade.availability)
    end

    writer:tag('properties.techtree')
    writer:int(#properties.techtree)
    for t = 1, #properties.techtree do
      writer:tag('properties.techtree[' .. t .. ']')
      local tech = properties.techtree[t]
      writer:players(tech.players)
      writer:bytes(tech.id)
    end

    -- ====================
    -- RANDOM GROUPS
    -- ====================

    writer:tag('properties.randomGroups')
    writer:int(#properties.randomGroups)
    for g = 1, #properties.randomGroups do
      writer:tag('properties.randomGroups[' .. g .. ']')
      local group = properties.randomGroups[g]
      writer:int(group.id)
      writer:string(group.name)

      writer:int(#group.types)
      for t = 1, #group.types do
        writer:int(group.types[t])
      end

      writer:int(#group.sets)
      for s = 1, #group.sets do
        writer:int(group.sets[s].chance)
        for t = 1, #group.types do
          writer:bytes(group.sets[s].objects[t])
        end
      end
    end

    -- ====================
    -- RANDOM ITEM TABLES
    -- ====================

    writer:tag('properties.randomItems')
    writer:int(#properties.randomItems)
    for i = 1, #properties.randomItems do
      writer:tag('properties.randomItems[' .. i .. ']')
      local group = properties.randomItems[i]
      writer:int(group.id)
      writer:string(group.name)
      writer:int(#group.sets)
      for s = 1, #group.sets do
        writer:int(#group.sets[s])
        for i = 1, #group.sets[s] do
          writer:int(group.sets[s][i].chance)
          writer:bytes(group.sets[s][i].item)
        end
      end
    end

    writer:close()
    return writer.tags
  end
}