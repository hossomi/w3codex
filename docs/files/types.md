[< Back](../index.md)

# Common types

This section describes the data types and structures commonly used in all binary files.

All sizes are in bytes.

- [Common types](#common-types)
  - [Data types](#data-types)
  - [Structures (size)](#structures-size)
    - [`Color` (4)](#color-4)
    - [`Bounds[T]` (16)](#boundst-16)
    - [`Rect[T]` (8)](#rectt-8)
    - [`Flags` (4)](#flags-4)
    - [`PlayerFlags` (4)](#playerflags-4)
  - [Random codes](#random-codes)
  
## Data types

| Type     | Size          | Description                       |
| -------- | ------------- | --------------------------------- |
| `int`    | 4             | A signed integer (little endian). |
| `byte`   | 1             | A unsigned integer.               |
| `char`   | 1             | A character.                      |
| `real`   | 4             | A floating point (little endian). |
| `string` | Variable      | A string terminated by `\0`.      |
| `T[n]`   | `n*sizeof(T)` | An array of `T` of size `n`.      |
| `4CC`    | 4             | A 4-char code.                    |
| `UID`    | 32            | Usually shown as a 32-char code.  |

## Structures (size)

A structure is just a group of fields.
Whenever a description shows a structure in the binary format, just replace it with its fields.

### `Color` (4)

A RGBA color. Field order is always the same.

| Type   | Description  |
| ------ | ------------ |
| `byte` | Blue value.  |
| `byte` | Green value. |
| `byte` | Red value.   |
| `byte` | Alpha value. |

### `Bounds[T]` (16)

A rectangle of `real` or `int`, specified by its bounds. May also represent border sizes.

Order may vary and should always specified in the description.

| Type | Description        |
| ---- | ------------------ |
| `T`  | Left side value.   |
| `T`  | Bottom side value. |
| `T`  | Right side value.  |
| `T`  | Top side value.    |

### `Rect[T]` (8)

A rectangle of `real` or `int`, specified by its dimensions.

Order may vary and should always specified in the description.

| Type | Description       |
| ---- | ----------------- |
| `T`  | Rectangle width.  |
| `T`  | Rectangle height. |

### `Flags` (4)

An unsigned, 4 bytes little-endian integer which each bit represent a true (`1`) or false (`0`) value.
The following rows should describe each known bit.

_Example:_

| Type    | Description              |
| ------- | ------------------------ |
| `Flags` | The flags.               |
| &nbsp;  | `0x0001` - First flag.   |
| &nbsp;  | `0x0040` - Another flag. |
| `int`   | Next field.              |

### `PlayerFlags` (4)

Similar to `Flags`, used to represent a list of players. Each bit `n` determines if the corresponding player `n` is (`1`) or not (`0`) in this list, where `n` is the bit order counting from 1.

There are more bits than there can be players, so the last 8 bits will usually remain unused.
Unused bits may be either `0` or `1` and should be specified in the description.

_Example:_ a `PlayerFlags` with value `0x00000005` means the property applies to players 1 and 3.

## Random codes

There are a few special `4CC` codes to represent random objects.
In the tables below:
- Characters in brackets are variables.
- `.` is an unrepresentable character.
- Other characters are constants.

| Format     | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| `YYU{x}`   | Random unit of level `x`.                                    |
| `YYB/`     | Random neutral building.                                     |
| `Y{c}I{x}` | Random item of category code `c` and level code `x`.         |
| `{p}{g}.Q` | Random unit/building/item from pool `p` of random group `g`. |

For random units/items, levels are coded to `x = 0x30 + level`. Use level -1 for any level.
_Examples:_

| Code `x` | Level |
| -------- | ----- |
| `0x2F /` | Any   |
| `0x30 0` | 0     |
| `0x31 1` | 1     |
| `0x3F ?` | 15    |

For random items, categories are coded to `c = 0x69 + index` (in the category list). Use `0x59` for any category.

| Code `c` | Category      |
| -------- | ------------- |
| `0x59 Y` | Any           |
| `0x69 i` | Permanent     |
| `0x6A j` | Charged       |
| `0x6B k` | Powerup       |
| `0x6C l` | Artifact      |
| `0x6D m` | Purchaseable  |
| `0x6E n` | Campaign      |
| `0x6F o` | Miscellaneous |

For random group references, the code always ends with `0x0051 .Q`.
Then, the first two bytes are the pool index and the random group ID, respectively.
_Examples:_

| Code              | Description        |
| ----------------- | ------------------ |
| `0x00000051 ...Q` | Pool 0 of group 0. |
| `0x01030051 ...Q` | Pool 1 of group 3. |
