[< Back](../index.md)

# _war3map.w3i_

This file holds many properties of the map itself, as well as general player settings.
Most of its information is available in the World Editor under the _Scenario_ menu.

| Type                                             | Field                                                                 |
| ------------------------------------------------ | --------------------------------------------------------------------- |
| `int`                                            | Format version. Always `28` as of patch 1.31.1.                       |
| `int`                                            | Map version. Equivalent to the number of times the map was saved.     |
| `int`                                            | Editor version that saved this map. Always `6072` as of patch 1.31.1. |
| `string`                                         | Map name.                                                             |
| `string`                                         | Map author.                                                           |
| `string`                                         | Map description.                                                      |
| `string`                                         | Map recommended players.                                              |
| [`MapArea`](#maparea)                            | Map area and camera bounds.                                           |
| [`MapSettings`](#mapsettings)                    | Map flags.                                                            |
| `char`                                           | Map base tileset.                                                     |
| [`MapLoadingScreen`](#maploadingscreen)          | Map loading screen.                                                   |
| `int`                                            | Map dataset:<br/>`0` - Default<br/>`1` - Custom<br/>`2` - Melee       |
| `string[4]`                                      | Unknown!                                                              |
| [`MapFog`](#mapfog)                              | Map fog.                                                              |
| [`MapWeather`](#mapweather)                      | Map weather.                                                          |
| [`MapWater`](#mapwater)                          | Map water.                                                            |
| `int`                                            | Unknown!                                                              |
| `int`                                            | Number of players `P`.                                                |
| [`Player[P]`](#player)                           | Players data.                                                         |
| `int`                                            | Number of forces `F`.                                                 |
| [`Force[F]`](#force)                             | Forces data.                                                          |
| `int`                                            | Number of upgrades availability `U`.                                  |
| [`UpgradeAvailability[U]`](#upgradeavailability) | Upgrades availability.                                                |
| `int`                                            | Number of techs availability `T`.                                     |
| [`TechAvailability[T]`](#techavailability)       | Techs availability.                                                   |
| `int`                                            | Number of random group tables `G`.                                    |
| [`RandomGroup[G]`](#randomgroup)                 | Random groups.                                                        |
| `int`                                            | Number of random item tables `I`.                                     |
| [`RandomItemTable[I]`](#randomitemtable)         | Random item tables.                                                   |

### `MapArea`

| Type           | Field                                                            |
| -------------- | ---------------------------------------------------------------- |
| `Bounds[real]` | Camera bounds.<br/>**Order:** left, bottom, right, top           |
| `Bounds[real]` | Camera bounds again!<br/>**Order:** left, top, right, bottom     |
| `Bounds[int]`  | Unplayable border width.<br/>**Order:** left, right, bottom, top |
| `Rect[int]`    | Playable area.<br/>**Order:** width, height                      |

### `MapSettings`

| Type    | Field                                                   |
| ------- | ------------------------------------------------------- |
| `Flags` | Map flags.                                              |
| &nbsp;  | `0x00000001` - Hide minimap.                            |
| &nbsp;  | `0x00000002` - Custom ally priorities.                  |
| &nbsp;  | `0x00000004` - Is a melee map.                          |
| &nbsp;  | `0x00000010` - Masked areas are partially visible.      |
| &nbsp;  | `0x00000020` - Fixed player settings for custom forces. |
| &nbsp;  | `0x00000040` - Use custom forces.                       |
| &nbsp;  | `0x00000080` - Use custom units.                        |
| &nbsp;  | `0x00000100` - Use custom abilities.                    |
| &nbsp;  | `0x00000200` - Use custom upgrades.                     |
| &nbsp;  | `0x00000800` - Show waves on cliff shores.              |
| &nbsp;  | `0x00001000` - Show waves on rolling sho.               |

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
| `string` | Environment sound label. Empty if disabled.<br/>**Values:** `Default`, `lake`, `psychotic`, `dungeon` |
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

### `RandomGroup`

A random group is a weird structure.
Each column is a pool of a certain type (units, buildings or items) which will be randomly rolled.
Each row is a set with a rolling chance.

Each pool is completely independent except for the set chances that are shared.
When referring to a random group, a pool of acceptable type must also be chosen.

| Type                | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| `int`               | Group ID. Used in references to this group.                  |
| `string`            | Group name.                                                  |
| `int`               | Number of pools `N`.                                         |
| `int[N]`            | Pool types:<br/>`0` - Unit<br/>`1` - Building<br/>`2` - Item |
| `int`               | Number of entries `S`.                                       |
| `RandomGroupSet[S]` | Group sets.                                                  |

### `RandomGroupSet`

| Type     | Description                           |
| -------- | ------------------------------------- |
| `int`    | Chance to roll.                       |
| `4CC[N]` | Object IDs for each pool in this set. |

The object type must match the corresponding pool type.

Object IDs may be `0x00000000` (no object) or a random unit/item ID.

The sum of all chances in the same table cannot be greater than 100%. If lower, the roll may yield nothing.

### `RandomItemTable`

A random item table contains multiple sets, each containing an item pool from which one item will be randomly rolled.

Each set rolls independently, but all sets in a table are always rolled together.
The table yields the result of each of its sets (if any).

| Type               | Description                                 |
| ------------------ | ------------------------------------------- |
| `int`              | Table ID. Used in references to this table. |
| `string`           | Table Name.                                 |
| `int`              | Number of sets `N`.                         |
| `RandomItemSet[N]` | Table sets.                                 |

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