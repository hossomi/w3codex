# WC3 Codex

A Lua library to convert Warcraft III files to and from JSON.

## Usage

*No usage yet!*

## Build

### Requirements:
- `cmake` to build some dependencies

Install dependencies in global tree:
```
luarocks make
```

Install dependencies in user local tree:
```
luarocks --tree local make
```

Install dependencies in project .luarocks folder:
```
luarocks --tree .luarocks make
```
> **Note:** you need to include this folder in `LUA_PATH` and `LUA_CPATH` to be
> able to execute the project.
> Check [.luarc](https://gist.github.com/hossomi/ef5f36c38af9c8689df3de5a4bc1d193)

## Files

### [`.w3e`] Terrain

| Field             | Type                  | Description                           |
| ----------------- | --------------------- | ------------------------------------- |
| File type         | `char[4]`             | Always `W3E!`.                        |
| File version      | `integer`             | Always `11`.                          |
| `baseTileset`     | `char`                | See the tileset table.                |
| `isCustomTileset` | `integer`             | `1` for custom tileset.               |
| `tileCount`       | `integer`             | Number of tiles in the tileset.       |
| `tiles`           | `char[4][tileCount]`  | See the tileset table.                |
| `cliffCount`      | `integer `            | Number of cliff tiles in the tileset. |
| `cliffs`          | `char[4][cliffCount]` | See the tileset table.                |