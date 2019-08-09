[< Back](../index.md)

# Common types

This section describes the data types and structures commonly used in all binary files.

All sizes are in bytes.

## Data types

| Type     | Size          | Description                      |
| -------- | ------------- | -------------------------------- |
| `int`    | 4             | A signed integer.                |
| `uint`   | 1             | A unsigned integer.              |
| `char`   | 1             | A character.                     |
| `real`   | 4             | A floating point.                |
| `string` | Variable      | A string terminated by `\0`.     |
| `T[n]`   | `n*sizeof(T)` | An array of `T` of size `n`.     |
| `4CC`    | 4             | A 4-char code.                   |
| `UID`    | 32            | Usually shown as a 32-char code. |

## Structures (size)

A structure is just a group of fields.
Whenever a description shows a structure in the binary format, just replace it with its fields.

### `Color` (4)

A RGBA color. Field order is always the same.

| Type   | Description  |
| ------ | ------------ |
| `uint` | Red value.   |
| `uint` | Green value. |
| `uint` | Blue value.  |
| `uint` | Alpha value. |

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

4 bytes which each bit represent a true (`1`) or false (`0`) value. The following rows should describe each known bit.

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