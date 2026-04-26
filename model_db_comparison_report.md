# 模型与数据库字段一致性对比报告

> 生成日期：2026-04-27
> 对比来源：`lib/model/` 下的 Dart 模型文件 vs MySQL `acore_world` + `foxy` 数据库实际表结构

---

## 1. `creature_template` — 严重不匹配

| 问题类型 | 详情 |
|---------|------|
| **模型中不存在，DB 中存在** | `speed_swim`, `speed_flight`, `detection_range`, `CreatureImmunitiesId` |
| **DB 中不存在，模型中有** | `modelid1`~`modelid4`（已移至 `creature_template_model` 表）、`spell_school_immune_mask`、`mechanic_immune_mask`（已合并为 `CreatureImmunitiesId`）、`inhabitType`、`scale`、`trainer_class`、`trainer_race`、`trainer_spell`、`trainer_type`（已被 AzerothCore 移除） |
| **结论** | 模型严重滞后于 AzerothCore 表结构变更，大量废弃字段未清理，新增字段未补充 |

---

## 2. `item_template` — 有多处类型不匹配

| 问题类型 | 详情 |
|---------|------|
| **类型不匹配** | `dmg_min1/dmg_max1/dmg_min2/dmg_max2`：DB 为 `float`，模型定义为 `int`，会丢失小数精度 |
| **类型不匹配** | `TotemCategory`：DB 为 `int`，模型定义为 `String` |
| **类型不匹配** | `ItemLimitCategory`：DB 为 `smallint`，模型定义为 `String` |
| **类型不匹配** | `BuyPrice`：DB 为 `bigint`（64位），模型定义为 `int`（Dart 中无问题，但 SQL 类型不匹配） |
| **DB 中不存在，模型 toJson 输出** | `localeName`, `localeDescription`, `inventoryIcon` — 标注为 joined 字段，虽然不在 toJson 中但存在于 fromJson 中 |

---

## 3. `gameobject_template` — 基本匹配

| 问题 | 详情 |
|------|------|
| **结论** | 模型字段与 DB 列名一致，无类型不匹配问题 |

---

## 4. `gameobject_template_addon` — 缺少字段

| 问题 | 详情 |
|------|------|
| **DB 中存在，模型中无** | `artkit0`, `artkit1`, `artkit2`, `artkit3`（共 4 个整型字段） |

---

## 5. `page_text` — 缺少字段

| 问题 | 详情 |
|------|------|
| **DB 中存在，模型中无** | `NextPageID`（int unsigned）、`VerifiedBuild`（int） |
| **模型只有** | `id`、`text` 两个字段，缺失重要关联字段 |

---

## 6. `npc_text_locale` — 基本匹配

| 问题 | 详情 |
|------|------|
| **模型字段名** | `texts[n][0]`、`texts[n][1]` 用 List 表示 |
| **DB 列** | `Text0_0`、`Text0_1`、`Text1_0`...`Text7_1`（大写 `T`） |
| **基本匹配** | 模型 fromJson 读 `Text{n}_0` / `Text{n}_1`，toJson 输出 `Text{n}_0` / `Text{n}_1`，命名一致 |

---

## 7. `npc_trainer` — 缺少字段

| 问题 | 详情 |
|------|------|
| **DB 中存在，模型中无** | `ReqSpell`（int unsigned） |

---

## 8. `spell_loot_template` — 有笔误

| 问题 | 详情 |
|------|------|
| **严重笔误** | 模型 fromJson 第 29 行：`groupId = json['GroudId']` — **`GroudId` 应为 `GroupId`** |
| **DB 列名** | `GroupId`（不是 GroudId） |
| **影响** | 当从 DB 读取 `GroupId` 时，`GroudId` 会返回 null，导致 `groupId` 始终为 0 |

---

## 9. `item_enchantment_template` — 模型包含 DB 中不存在的字段

| 问题 | 详情 |
|------|------|
| **DB 中不存在，模型有** | `condition_1`、`condition_2`、`condition_3` |
| **DB 实际只有** | `entry`、`ench`、`chance` 三列 |
| **影响** | `toJson()` 输出 `condition_1`~`condition_3`，**若写入 DB 会报错** |

---

## 10. `item_extended_cost` / `itemextendedcost_dbc` — 模型覆盖严重不足

| 问题 | 详情 |
|------|------|
| **模型只有** | `ID`, `HonorPoints`, `ArenaPoints`, `ArenaBracket` |
| **DB 还有** | `ItemID_1`~`_5`、`ItemCount_1`~`_5`、`RequiredArenaRating`、`ItemPurchaseGroup` |

---

## 11. `creature_display_info` / `creaturedisplayinfo_dbc` — 模型覆盖严重不足

| 问题 | 详情 |
|------|------|
| **模型只有** | `ID`, `ModelID`, `SoundID`, `ExtendedDisplayInfoID`, `CreatureModelScale` |
| **DB 还有** | `CreatureModelAlpha`, `TextureVariation_1`~`_3`, `PortraitTextureName`, `BloodLevel`, `BloodID`, `NPCSoundID`, `ParticleColorID`, `CreatureGeosetData`, `ObjectEffectPackageID` |

---

## 12. `creature_spell_data` / `creaturespelldata_dbc` — 缺少字段

| 问题 | 详情 |
|------|------|
| **DB 中存在，模型中无** | `Availability_1`~`_4` |

---

## 13. `vehicle` / `vehicle_dbc` — 模型覆盖严重不足

| 问题 | 详情 |
|------|------|
| **模型只有 6 个字段** | DB 实际有 **38 列**，模型只覆盖核心的 ID、Flags、速度/角度字段，缺少 SeatID 系列、摄像机参数等 |

---

## 14. `faction_dbc` — 模型覆盖极少但合理

| 问题 | 详情 |
|------|------|
| **模型只有 3 个字段** | DB 实际有 50+ 列，但模型只取 ID + Name/Description 的 zhCN 本地化，是 **有意为之**，用于列表展示 |

---

## 15. `spell_group` — 模型 toJson 包含非 DB 字段

| 问题 | 详情 |
|------|------|
| **DB 中不存在，模型 toJson 有** | `special_flag` — 该字段实际在 `spell_group_stack_rules` 表中 |
| **影响** | `toJson()` 输出 `special_flag`，**若写回 DB 会报错**，需检查使用场景 |

---

## 16. `Spell` 模型（对应 `foxy.dbc_spell`）

| 问题 | 详情 |
|------|------|
| **DB 中存在，模型无** | `AttributesEx2`~`AttributesEx7` 在 DB 中以 `AttributesExB`~`AttributesExG` 为列名 |
| **命名差异** | DB: `EffectBonusMultiplier_{1,2,3}`, 模型: `EffectBonusCoefficient{0,1,2}` |
| **DB 中存在，模型无** | `EffectMultipleValue_1`~`_3` |
| **DB 中存在，模型无** | `unk_320_2`, `unk_320_3` |

---

## 17. `Spell` / `BriefSpell` 模型的跨库问题

| 问题 | 详情 |
|------|------|
| **数据源** | `BriefSpell` 使用 `Name_Lang_zhCN`（大写 `L`，对应 `acore_world.spell_dbc`），`Spell` 使用 `Name_lang_zhCN`（小写 `l`，对应 `foxy.dbc_spell`） |
| **潜在问题** | 两者列名大小写不同，在 Linux MySQL 上可能导致查询失败 |

---

## 18. `feature` 模型 — 数据库表不存在

| 问题 | 详情 |
|------|------|
| **模型中** | `Feature` 类完整定义了 id、name、description 等 11 个字段 |
| **数据库中** | `acore_world` 和 `foxy` 两个库中均无 `feature` 表 |
| **影响** | **CRUD 操作会失败**，表根本不存在 |

---

## 19. 无问题的模型（字段完全匹配）

以下模型的字段名与 DB 列名一致，无类型问题：

- `creature_template_locale` ✓
- `creature_template_addon` ✓
- `gameobject_template_locale` ✓
- `npc_vendor` ✓
- `quest_template` ✓
- `quest_template_locale` ✓
- `quest_template_addon` ✓
- `quest_offer_reward` / `quest_offer_reward_locale` ✓
- `quest_request_items` / `quest_request_items_locale` ✓
- `gossip_menu` ✓
- `gossip_menu_option` / `gossip_menu_option_locale` ✓
- `npc_text` ✓
- `smart_scripts` ✓
- `spell_bonus_data` ✓
- `spell_custom_attr` ✓
- `spell_linked_spell` ✓
- `spell_ranks` ✓
- `spell_area` ✓
- `loot_template`（所有变体） ✓
- `creature_equip_template` ✓
- `creature_questitem` ✓
- `gameobject_questitem` ✓
- `creature_questender` / `creature_queststarter` ✓
- `gameobject_questender` / `gameobject_queststarter` ✓
- `creature_onkill_reputation` ✓

---

## 问题严重性总结

| 严重度 | 数量 | 描述 |
|--------|------|------|
| **致命** | 3 | `feature` 表不存在、`item_enchantment_template` 输出不存在字段、`spell_loot_template` 的 `GroudId` 笔误 |
| **高** | 4 | `creature_template` 模型严重过时含 8 个废弃字段缺 4 个新字段、`page_text` 缺 `NextPageID` 和 `VerifiedBuild`、`npc_trainer` 缺 `ReqSpell` |
| **中** | 4 | `item_template` 类型不匹配（`dmg_min/max` float→int 精度丢失、`TotemCategory` int→String、`ItemLimitCategory` int→String） |
| **低** | 4 | `spell_group` 的 `special_flag` 输出问题、`Spell` 模型缺少部分 DBC 字段、`vehicle`/`creature_display_info` 等模型仅覆盖部分字段 |
