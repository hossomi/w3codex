# WC3 Codex

A Lua library to convert Warcraft III files to and from JSON.

- [WC3 Codex](#wc3-codex)
  - [Usage](#usage)
  - [Build](#build)
  - [Common types and formats](#common-types-and-formats)
    - [`Color`](#color)
    - [`Bounds[T]`](#boundst)
    - [`Rect[T]`](#rectt)
  - [File formats](#file-formats)
    - [_war3map.w3i_ - Map properties](#war3map-w3i-map-properties)
      - [Map area](#map-area)
      - [Map settings](#map-settings)
      - [Map loading screen](#map-loading-screen)
      - [Map fog](#map-fog)
      - [Map weather](#map-weather)
      - [Map water](#map-water)

## Usage

*No usage yet!*

## Build

Requirements:
- [`luarocks`](https://luarocks.org/) to build project
- `cmake` to build some dependencies

Install dependencies in global tree:
```
luarocks make
```

Install dependencies in user tree:
```
luarocks --tree local make
```

Install dependencies in project tree:
```
luarocks --tree .luarocks make
```
> **Note:** you need to include this folder in `LUA_PATH` and `LUA_CPATH` to be
> able to execute the project.
> Check [.luarc](https://gist.github.com/hossomi/ef5f36c38af9c8689df3de5a4bc1d193)

## Common types and formats

| Type     | Description                                        |
| -------- | -------------------------------------------------- |
| `int`    | 4 bytes signed integer.                            |
| `uint`   | 1 byte unsigned integer.                           |
| `char`   | 1 byte character.                                  |
| `real`   | 4 byte floating point.                             |
| `string` | Variable size string terminated by `\0`            |
| `T[n]`   | Array of `T` of size `n`.                          |
| `4CC`    | 4 bytes forming a 4-char code.                     |
| `UID`    | 32 bytes integer, usually shown as a 32-char code. |

### `Color`

A color code. Order is always the same.

| Field   | Type   | Description |
| ------- | ------ | ----------- |
| `red`   | `uint` |             |
| `green` | `uint` |             |
| `blue`  | `uint` |             |
| `alpha` | `uint` |             |

### `Bounds[T]`

A rectangle of `real` or `int`, specified by its bounds.
Order may vary, always specified in the description.

| Field    | Type | Description |
| -------- | ---- | ----------- |
| `left`   | `T`  |             |
| `bottom` | `T`  |             |
| `right`  | `T`  |             |
| `top`    | `T`  |             |

### `Rect[T]`

A rectangle of `real` or `int`, specified by its dimensions.
Order may vary, always specified in the description.

| Field    | Type | Description |
| -------- | ---- | ----------- |
| `width`  | `T`  |             |
| `height` | `T`  |             |

## File formats

### _war3map.w3i_ - Map properties

| Field                | Type                                     | Description       |
| -------------------- | ---------------------------------------- | ----------------- |
| Format version       | `int`                                    | Always `28`.      |
| `version`            | `int`                                    | Number of saves.  |
| `editorVersion`      | `int`                                    |                   |
| `name`               | `string`                                 |                   |
| `author`             | `string`                                 |                   |
| `description`        | `string`                                 |                   |
| `recommendedPlayers` | `string`                                 |                   |
| `area`               | [`MapArea`](#map-area)                   |                   |
| `settings`           | [`MapSettings`](#map-settings)           |                   |
| `tileset`            | `char`                                   | Map base tileset. |
| `loadingScreen`      | [`MapLoadingScreen`](map-loading-screen) |                   |
| `dataset`            | `int`                                    |                   |
| `fog`                | [`MapFog`](#map-fog)                     |                   |
| `weather`            | [`MapWeather`](#map-weather)             |                   |
| `water`              | [`MapWater`](#map-water)                 |                   |

#### Map area

| Field          | Type           | Description                                                                  |
| -------------- | -------------- | ---------------------------------------------------------------------------- |
| `cameraBounds` | `Bounds[real]` | (`left, bottom, right, top`) Camera bounds.                                  |
| ?              | `Bounds[real]` | Seems to be the camera bounds again in other direction.                      |
| `complements`  | `Bounds[int]`  | (`left, right, bottom top`) Unplayable border width. Not really a rectangle! |
| `playable`     | `Rect[int]`    | (`width, height`) Playable area.                                             |

#### Map settings

Map settings is 4 bytes, each bit is a flag:

| Field                        | Flag bit | Description                              |
| ---------------------------- | -------- | ---------------------------------------- |
| `hideMinimap`                | `0x0001` |                                          |
| `allyPriorities.custom`      | `0x0002` |                                          |
| `isMeleeMap`                 | `0x0004` |                                          |
| ?                            | `0x0008` |                                          |
| `isMaskedAreaVisible`        | `0x0010` |                                          |
| `forces.fixedPlayerSettings` | `0x0020` | Always true if `forces.custom` is false. |
| `forces.custom`              | `0x0040` |                                          |
| `techtree.custom`            | `0x0080` |                                          |
| `abilities.custom`           | `0x0100` |                                          |
| `upgrades.custom`            | `0x0200` |                                          |
| ?                            | `0x0400` |                                          |
| `showWavesOnCliffShores`     | `0x0800` |                                          |
| `showWavesOnRollingShores`   | `0x1000` |                                          |
| ?                            | `0x2000` |                                          |
| ?                            | `0x4000` |                                          |
| ?                            | `0x8000` |                                          |

#### Map loading screen

| Field      | Type     | Description                                               |
| ---------- | -------- | --------------------------------------------------------- |
| `preset`   | `int`    | The index in the preset list if selected; `-1` otherwise. |
| `custom`   | `string` | The custom model path if selected; empty otherwise.       |
| `text`     | `string` |                                                           |
| `title`    | `string` |                                                           |
| `subtitle` | `string` |                                                           |

#### Map fog

| Field     | Type    | Description                                                |
| --------- | ------- | ---------------------------------------------------------- |
| `type`    | `int`   | The index in the fog style list if enabled; `0` otherwise. |
| `min`     | `real`  | Fog Z start.                                               |
| `max`     | `real`  | Fog Z end.                                                 |
| `density` | `real`  |                                                            |
| `color`   | `Color` |                                                            |

#### Map weather

| Field    | Type     | Description                                              |
| -------- | -------- | -------------------------------------------------------- |
| `global` | `4CC`    | The weather code if enabled; `0000` otherwise.           |
| `sound`  | `string` | The environment sound label if enabled; empty otherwise. |
| `light`  | `char`   | Tileset of custom lighting if enabled; `\0` otherwise.   |

#### Map water

| Field   | Type    | Description |
| ------- | ------- | ----------- |
| `color` | `Color` |             |