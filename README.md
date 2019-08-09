# WC3 Codex

A Lua library to convert Warcraft III files to and from JSON.

[Documentation](docs/index.md)

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