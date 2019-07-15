# File Formats

## Terrain `.w3e`

| Field                | Type         | Description                     |
| -------------------- | ------------ | ------------------------------- |
| File type            | char[4]      | Always `W3E!`.                  |
| File version         | integer      | Always `11`.                    |
| Base tileset         | char         | See the tileset table.          |
| Custom tileset       | byte         | `1` for custom tileset.         |
| `T`: number of tiles | integer      | Number of tiles in the tileset. |
| Tiles                | char[4][`T`] | See the tileset table.          |