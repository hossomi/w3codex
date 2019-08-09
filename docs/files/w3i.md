[< Back](../index.md)

# _war3map.w3i_

This file holds many properties of the map itself, as well as general player settings.
Most of its information is available in the World Editor under the _Scenario_ menu.

- [_war3map.w3i_](#war3mapw3i)
    - [`MapArea`](#maparea)
    - [`MapSettings`](#mapsettings)
    - [`MapLoadingScreen`](#maploadingscreen)
    - [`MapFog`](#mapfog)
    - [`MapWeather`](#mapweather)
    - [`MapWater`](#mapwater)
    - [`Player`](#player)
    - [`Force`](#force)
    - [`UpgradeAvailability`](#upgradeavailability)
    - [`TechAvailability`](#techavailability)
    - [`RandomGroupTable`](#randomgrouptable)
    - [`RandomGroupEntry`](#randomgroupentry)
    - [`RandomItemTable`](#randomitemtable)
    - [`RandomItemSet`](#randomitemset)
    - [`RandomItemEntry`](#randomitementry)
  

| Type                                     | Field                                                                 |
| ---------------------------------------- | --------------------------------------------------------------------- |
| `int`                                    | Format version. Always `28` as of patch 1.31.1.                       |
| `int`                                    | Map version. Equivalent to the number of times the map was saved.     |
| `int`                                    | Editor version that saved this map. Always `6072` as of patch 1.31.1. |
| `string`                                 | Map name.                                                             |
| `string`                                 | Map author.                                                           |
| `string`                                 | Map description.                                                      |
| `string`                                 | Map recommended players.                                              |
| [`MapArea`](#map-area)                   | Map area and camera bounds.                                           |
| [`MapSettings`](#map-settings)           | Map flags.                                                            |
| `char`                                   | Map base tileset.                                                     |
| [`MapLoadingScreen`](map-loading-screen) | Map loading screen.                                                   |
| `int`                                    | Map dataset:<br/>`0` - Default<br/>`1` - Custom<br/>`2` - Melee       |
| `string[4]`                              | Unknown!                                                              |
| [`MapFog`](#map-fog)                     | Map fog.                                                              |
| [`MapWeather`](#map-weather)             | Map weather.                                                          |
| [`MapWater`](#map-water)                 | Map water.                                                            |
| `int`                                    | Unknown!                                                              |
| `int`                                    | Number of players `P`.                                                |
| `Player[P]`                              | Players data.                                                         |
| `int`                                    | Number of forces `F`.                                                 |
| `Force[F]`                               | Forces data.                                                          |
| `int`                                    | Number of upgrades availability `U`.                                  |
| `UpgradeAvailability[U]`                 | Upgrades availability.                                                |
| `int`                                    | Number of techs availability `T`.                                     |
| `TechAvailability[T]`                    | Techs availability.                                                   |
| `int`                                    | Number of random group tables `G`.                                    |
| `RandomGroupTable[G]`                    | Random groups.                                                        |
| `int`                                    | Number of random item tables `I`.                                     |
| `RandomItemTable[I]`                     | Random item tables.                                                   |

### `MapArea`

| Type           | Field                                                            |
| -------------- | ---------------------------------------------------------------- |
| `Bounds[real]` | Camera bounds.<br/>**Order:** left, bottom, right, top           |
| `Bounds[real]` | Camera bounds again!<br/>**Order:** left, top, right, bottom     |
| `Bounds[int]`  | Unplayable border width.<br/>**Order:** left, right, bottom, top |
| `Rect[int]`    | Playable area.<br/>**Order:** width, height                      |

### `MapSettings`

| Type    | Field                                                    |
| ------- | -------------------------------------------------------- |
| `Flags` | Map flags.                                               |
| &nbsp;  | `0x0000 0001` - Hide minimap.                            |
| &nbsp;  | `0x0000 0002` - Custom ally priorities.                  |
| &nbsp;  | `0x0000 0004` - Is a melee map.                          |
| &nbsp;  | `0x0000 0010` - Masked areas are partially visible.      |
| &nbsp;  | `0x0000 0020` - Fixed player settings for custom forces. |
| &nbsp;  | `0x0000 0040` - Use custom forces.                       |
| &nbsp;  | `0x0000 0080` - Use custom units.                        |
| &nbsp;  | `0x0000 0100` - Use custom abilities.                    |
| &nbsp;  | `0x0000 0200` - Use custom upgrades.                     |
| &nbsp;  | `0x0000 0800` - Show waves on cliff shores.              |
| &nbsp;  | `0x0000 1000` - Show waves on rolling sho.               |

### `MapLoadingScreen`

| Type     | Description                                                                              |
| -------- | ---------------------------------------------------------------------------------------- |
| `int`    | Loading screen preset:<br/>`-1` - No preset selected<br/>`0+` - Index in the preset list |
| `string` | Loading screen imported file path. Empty if not selected.                                |
| `string` | Loading screen text.                                                                     |
| `string` | Loading screen title.                                                                    |
| `string` | Loading screen subtitle.                                                                 |

### `MapFog`

| Type    | Description                                                                                |
| ------- | ------------------------------------------------------------------------------------------ |
| `int`   | Fog style:<br/>`0` - None<br/>`1` - Linear<br/>`2` - Exponential 1<br/>`3` - Exponential 2 |
| `real`  | Fog Z start.                                                                               |
| `real`  | Fog Z end.                                                                                 |
| `real`  | Fog density.                                                                               |
| `Color` | Fog color.                                                                                 |

### `MapWeather`

| Type     | Description                                                                                             |
| -------- | ------------------------------------------------------------------------------------------------------- |
| `4CC`    | Weather code. `0000` if disabled.                                                                       |
| `string` | Environment sound label. Empty if disabled.<br/>**Values:** `mountains`, `lake`, `psychotic`, `dungeon` |
| `char`   | Tileset of custom lighting. `\0` if disabled.                                                           |

### `MapWater`

| Type    | Description  |
| ------- | ------------ |
| `Color` | Water color. |

### `Player`

| Type          | Description                                                                          |
| ------------- | ------------------------------------------------------------------------------------ |
| `int`         | Player ID as defined in the World Editor.                                            |
| `int`         | Player type:<br/>`1` - User<br/>`2` - Computer<br/>`3` - Neutral<br/>`4` - Rescuable |
| `int`         | Player race:<br/>`1` - Human<br/>`2` - Orc<br/>`3` - Undead<br/>`4` - Night Elf      |
| `Flags`       | Player flags.                                                                        |
| &nbsp;        | `0x00000001` - Fixed starting location                                               |
| `string`      | Player name.                                                                         |
| `real`        | Starting location X.                                                                 |
| `real`        | Starting location Y.                                                                 |
| `PlayerFlags` | Players with low ally priority.                                                      |
| `PlayerFlags` | Players with high ally priority.                                                     |

### `Force`

| Type          | Description                                 |
| ------------- | ------------------------------------------- |
| `Flags`       | Force flags.                                |
| &nbsp;        | `0x00000001` - Allied                       |
| &nbsp;        | `0x00000002` - Allied victory               |
| &nbsp;        | `0x00000008` - Shared vision                |
| &nbsp;        | `0x00000010` - Shared unit control          |
| &nbsp;        | `0x00000020` - Shared advanced unit control |
| `PlayerFlags` | Players in this force.                      |
| `string`      | Force name.                                 |

### `UpgradeAvailability`

Each entry modifies the availability of a specific upgrade level for a set of players.
If a upgrade level is not specified in this list, then it is available by default. This is why availability value `1` is often not seen.

| Type          | Description                                                                          |
| ------------- | ------------------------------------------------------------------------------------ |
| `PlayerFlags` | Affected players.                                                                    |
| `4CC`         | Upgrade ID.                                                                          |
| `int`         | Upgrade level.                                                                       |
| `int`         | Upgrade availability:<br/>`0` - Unavailable<br/>`1` - Available<br/>`2` - Researched |

### `TechAvailability`

Each entry modifies the availability of a tech (unit, item or ability) for a set of players.
If the tech is present in this list, then it is disabled.

| Type          | Description                      |
| ------------- | -------------------------------- |
| `PlayerFlags` | Affected players.                |
| `4CC`         | Tech ID (unit, item or ability). |

### `RandomGroupTable`

In a random group table, each column is a pool which will be randomly rolled, and each row is an entry.
It is called "group" because it contains multiple pools of different types but sharing rolling chances.

Each pool has a type (unit, building or item) and each entry has a chance of being rolled.

_Example:_ when placing a random building in the World Editor, the user can select a table and a pool of type "building".
The building in that spot will be randomly rolled among all the entries in that pool.

| Type                  | Description                                                  |
| --------------------- | ------------------------------------------------------------ |
| `int`                 | Table ID.                                                    |
| `string`              | Table name.                                                  |
| `int`                 | Number of pools `N`.                                         |
| `int[N]`              | Pool types:<br/>`0` - Unit<br/>`1` - Building<br/>`2` - Item |
| `int`                 | Number of entries `E`.                                       |
| `RandomGroupEntry[E]` | Table entries.                                               |

### `RandomGroupEntry`

| Type     | Description                             |
| -------- | --------------------------------------- |
| `int`    | Chance to roll.                         |
| `4CC[N]` | Object IDs for each pool in this entry. |

The object type must match the corresponding pool type.

Object IDs may be `0x00000000` (no object) or a random unit/item ID.

The sum of all chances in the same table cannot be greater than 100%. If lower, the roll may yield nothing.

### `RandomItemTable`

A random item table contains multiple sets that roll independently (but not individually), and each set contains an item pool from which one item will be randomly rolled.

Each set may yield one item in a roll.
Sets cannot be rolled individually, the entire table is always rolled and yields each of its set results.

_Example:_ when selecting the dropped items for a pre-placed unit in the World Editor, the user can select a table.
When that unit dies, the entire table is rolled and the result of each set is dropped.

| Type               | Description         |
| ------------------ | ------------------- |
| `int`              | Table ID.           |
| `string`           | Table Name.         |
| `int`              | Number of sets `N`. |
| `RandomItemSet[N]` | Table sets.         |

### `RandomItemSet`

| Type                 | Description            |
| -------------------- | ---------------------- |
| `int`                | Number of entries `E`. |
| `RandomItemEntry[E]` | Set entries.           |

### `RandomItemEntry`

| Type  | Description     |
| ----- | --------------- |
| `int` | Chance to roll. |
| `4CC` | Item ID.        |

The item ID may be `0x00000000` (no item) or a random item ID.

The sum of all chances in the same set cannot be greater than 100%. If lower, the roll may yield nothing.