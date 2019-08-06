local function juxtapose(table)
  for i, v in ipairs(table) do
    table[v] = i
  end
  return table
end

MAX_PLAYERS = 24

PRIORITY_NONE = 0
PRIORITY_LOW = 1
PRIORITY_HIGH = 2

RACES = juxtapose({'Human', 'Orc', 'Undead', 'Night Elf'})
RACE_HUMAN = RACES[1]
RACE_ORC = RACES[2]
RACE_UNDEAD = RACES[3]
RACE_NIGHT_ELF = RACES[4]

PLAYER_TYPES = juxtapose({'User', 'Computer', 'Neutral', 'Rescuable'})
PLAYER_TYPE_USER = PLAYER_TYPES[1]
PLAYER_TYPE_COMPUTER = PLAYER_TYPES[2]
PLAYER_TYPE_NEUTRAL = PLAYER_TYPES[3]
PLAYER_TYPE_RESCUABLE = PLAYER_TYPES[4]

RANDOM_TYPES = juxtapose({'Unit', 'Building', 'Item'})
RANDOM_TYPE_UNIT = RANDOM_TYPES[1]
RANDOM_TYPE_BUILDING = RANDOM_TYPES[2]
RANDOM_TYPE_ITEM = RANDOM_TYPES[3]

FOG_TYPES = juxtapose({'Linear', 'Exponential 1', 'Exponential 2'})
FOG_TYPE_LINEAR = FOG_TYPES[1]
FOG_TYPE_EXPONENTIAL_1 = FOG_TYPES[2]
FOG_TYPE_EXPONENTIAL_2 = FOG_TYPES[3]
