local wio = require 'src.wio'
local json = require 'rapidjson'

local function decode(path)
    reader = wio.open(path)
    if not reader:read(4) == 'W3E!' then
        error('Not a tileset file!')
    end

    if not reader:readInteger() == 11 then
        error('Incompatible version!')
    end

    terrain = {}

    terrain.baseTileset = reader:read(1)
    terrain.isCustomTileset = reader:readInteger() == 1

    terrain.tileCount = reader:readInteger()
    terrain.tiles = {}
    
    for i = 1, terrain.tileCount do
        terrain.tiles[i] = reader:read(4)
    end

    terrain.cliffCount = reader:readInteger()
    terrain.cliffs = {}
    
    for i = 1, terrain.cliffCount do
        terrain.cliffs[i] = reader:read(4)
    end

    print(json.encode(terrain, {pretty = true}))
end

decode('./test/map/war3map.w3e')