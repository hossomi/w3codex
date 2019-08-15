# Map samples

## Sample #1

The player forces sample.

| Player | Race      | Type      |
| ------ | --------- | --------- |
| 1      | Human     | User      |
| 2      | Human     | User      |
| 3      | Human     | User      |
| 7      | Orc       | Computer  |
| 8      | Orc       | Computer  |
| 9      | Orc       | Computer  |
| 13     | Undead    | Neutral   |
| 14     | Undead    | Neutral   |
| 15     | Undead    | Neutral   |
| 22     | Night Elf | Rescuable |
| 23     | Night Elf | Rescuable |
| 24     | Night Elf | Rescuable |

| Force   | Players          | Allied         | Shared                       |
| ------- | ---------------- | -------------- | ---------------------------- |
| Force 1 | 1, 2, 3, 7, 8, 9 | Allied victory | Shared advanced unit control |
| Force 2 | 13, 15, 24       | Allied         | Shared vision                |
| Force 3 | 14, 22, 23       | None           | None                         |

## Sample #2

The ally priorities, upgrades and techtree sample.

| Player | Race  | Type |
| ------ | ----- | ---- |
| 1      | Human | User |
| 2      | Human | User |
| 3      | Human | User |

| Priorities | 1   | 2    | 3    |
| ---------- | --- | ---- | ---- |
| 1          | -   | Low  | None |
| 2          | Low | -    | High |
| 3          | Low | High | -    |

| Upgrade | Players | 1          | 2           | 3           |
| ------- | ------- | ---------- | ----------- | ----------- |
| `Rhme`  | 1       | Researched | Available   | Unavailable |
| `Rhme`  | 2, 3    | Available  | Unavailable | Unavailable |
| `Rhra`  | 1, 2, 3 | Researched | Researched  | Researched  |

| Tech   | Players |
| ------ | ------- |
| `AHav` | 1, 2, 3 |
| `AHbn` | 1, 2, 3 |
| `hpea` | 1       |
| `hfoo` | 2, 3    |
| `hkni` | 1, 2, 3 |

### Sample #3

The random groups and item tables sample.

#### Group 1:
| Chance | 1 (Unit) | 2 (Building) | 3 (Item) |
| ------ | -------- | ------------ | -------- |
| 34%    | `nanb`   | `ngme`       | `ratf`   |
| 33%    | `YYU/`   | `YYB/`       | `YYI/`   |
| 33%    | `YYU:`   | None         | `YlI5`   |

#### Group 2:
| Chance | Unit   |
| ------ | ------ |
| 75%    | `nplb` |

#### Group 3:
| Chance | 1 (Unit) | 2 (Item) |
| ------ | -------- | -------- |
| 100%   | `nbsp`   | `ckng`   |

#### Table 1:
| Set 1      | Set 2      | Set 3                  |
| ---------- | ---------- | ---------------------- |
| 50% `ratf` | 50% `YkI4` | 40% `0x02 0x00 0x00 Q` |
| 50% `ckng` | 50% None   | 60% `0x01 0x02 0x00 Q` |

#### Table 2:
| Set 1     |
| --------- |
| 1% `YYI/` |
| 2% `YiI/` |
| 3% `YjI/` |
| 4% `YkI/` |
| 5% `YlI/` |
| 6% `YmI/` |
| 7% `YnI/` |
| 8% `YoI/` |

## Sample #2

The map options sample.

Fog, water, weather and some flags changed.