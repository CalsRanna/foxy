# Foxy 行定位器物理分类清单

本清单记录 `scalar_row_locator_simplification_plan.md` 实施后的永久 schema
分类。分类依据是仓库中的物理列定义、Repository `WHERE`、Brief Entity 与数据库
编辑合同；它不是迁移期 allowlist。

## 普通单列定位器

下列 79 个定位器均来自单列、非空 `PRIMARY KEY`，只使用普通 MySQL 等值比较，
物理 Dart 类型均为 `int`。Brief 的 `key` 直接返回对应字段；其中 76 个可编辑
Repository 的 `get` / `update` / `destroy` 接口直接接收该标量，另外 3 个只读 DBC
Picker 也直接暴露标量，不再保留包装类。

### `ID` 列

- World：`broadcast_text`、`creature_immunities`、`npc_text`、`page_text`、
  `points_of_interest`、`quest_offer_reward`、`quest_request_items`、
  `quest_template_addon`、`quest_template`。
- DBC mirror：`foxy.dbc_achievement`、`foxy.dbc_achievement_category`、
  `foxy.dbc_achievement_criteria`、`foxy.dbc_area_table`、
  `foxy.dbc_char_titles`、`foxy.dbc_cinematic_sequences`、
  `foxy.dbc_creature_display_info`、`foxy.dbc_creature_model_data`、
  `foxy.dbc_creature_movement_info`、`foxy.dbc_creature_spell_data`、
  `foxy.dbc_currency_category`、`foxy.dbc_currency_types`、
  `foxy.dbc_destructible_model_data`、`foxy.dbc_emotes`、
  `foxy.dbc_emotes_text`、`foxy.dbc_emotes_text_data`、
  `foxy.dbc_faction`、`foxy.dbc_faction_template`、
  `foxy.dbc_game_object_art_kit`、`foxy.dbc_game_object_display_info`、
  `foxy.dbc_gem_properties`、`foxy.dbc_glyph_properties`、`foxy.dbc_item`、
  `foxy.dbc_item_display_info`、`foxy.dbc_item_extended_cost`、
  `foxy.dbc_item_purchase_group`、`foxy.dbc_item_random_properties`、
  `foxy.dbc_item_random_suffix`、`foxy.dbc_item_set`、
  `foxy.dbc_item_visual_effects`、`foxy.dbc_item_visuals`、`foxy.dbc_light`、
  `foxy.dbc_liquid_type`、`foxy.dbc_lock`、`foxy.dbc_mail_template`、
  `foxy.dbc_map`、`foxy.dbc_quest_faction_reward`、`foxy.dbc_quest_info`、
  `foxy.dbc_quest_sort`、`foxy.dbc_scaling_stat_distribution`、
  `foxy.dbc_scaling_stat_values`、`foxy.dbc_skill_line`、
  `foxy.dbc_sound_ambience`、`foxy.dbc_sound_provider_preferences`、
  `foxy.dbc_spell`、`foxy.dbc_spell_duration`、`foxy.dbc_spell_focus_object`、
  `foxy.dbc_spell_icon`、`foxy.dbc_spell_item_enchantment`、
  `foxy.dbc_spell_item_enchantment_condition`、`foxy.dbc_spell_range`、
  `foxy.dbc_talent`、`foxy.dbc_talent_tab`、`foxy.dbc_taxi_path`、
  `foxy.dbc_vehicle`、`foxy.dbc_zone_intro_music_table`、
  `foxy.dbc_zone_music`。
- 只读 DBC Picker：`foxy.dbc_holidays`、`foxy.dbc_item_limit_category`、
  `foxy.dbc_totem_category`。

### `entry` 列

- `creature_template`、`creature_template_addon`、`gameobject_template`、
  `gameobject_template_addon`、`item_template`、`spell_bonus_data`。

### 其他物理列

- `creature_default_trainer.CreatureId`
- `creature_model_info.DisplayID`
- `creature_onkill_reputation.creature_id`
- `spell_custom_attr.spell_id`

### 消费层审计

- 79 个对应 Brief Entity 都直接返回上述 `int` 字段。
- 76 个可编辑 Repository 都以 `int key` / `int originalKey` 定位旧行。
- 详情路由使用标量的模块为：achievement、area table、creature template、
  currency type、emote text、game object template、gem property、glyph property、
  item extended cost、item set、item template、page text、quest faction reward、
  quest info、quest sort、quest template、scaling stat distribution、
  scaling stat value、spell、spell item enchantment、talent。
- 单列内嵌编辑器使用 `int? editingKey`；成功后读取 candidate 的真实物理字段，
  失败时保留旧标量。Picker delegate 继续使用具体 Brief 类型，不存在通用 Object
  或 Map locator 入口。

## 保留的联合定位器

下列文件继续使用不可变专用 Key；括号内是完整物理定位列：

- `condition_key.dart`（`sourceTypeOrReferenceId`, `sourceGroup`, `sourceEntry`,
  `sourceId`, `elseGroup`, `conditionTypeOrReference`, `conditionTarget`,
  `conditionValue1`, `conditionValue2`, `conditionValue3`）
- `creature_equip_template_key.dart`（`creatureID`, `id`）
- `creature_quest_ender_key.dart`（`id`, `quest`）
- `creature_quest_item_key.dart`（`creatureEntry`, `idx`）
- `creature_quest_starter_key.dart`（`id`, `quest`）
- `creature_template_locale_key.dart`（`entry`, `locale`）
- `creature_template_resistance_key.dart`（`creatureID`, `school`）
- `creature_template_spell_key.dart`（`creatureID`, `index`）
- `game_object_quest_ender_key.dart`（`id`, `quest`）
- `game_object_quest_item_key.dart`（`gameObjectEntry`, `idx`）
- `game_object_quest_starter_key.dart`（`id`, `quest`）
- `game_object_template_locale_key.dart`（`entry`, `locale`）
- `gossip_menu_key.dart`（`menuId`, `textId`）
- `gossip_menu_option_key.dart`（`menuId`, `optionId`）
- `gossip_menu_option_locale_key.dart`（`menuId`, `optionId`, `locale`）
- `item_enchantment_template_key.dart`（`entry`, `ench`）
- `item_template_locale_key.dart`（`id`, `locale`）
- `npc_text_locale_key.dart`（`id`, `locale`）
- `npc_trainer_key.dart`（`trainerId`, `spellId`）
- `npc_vendor_key.dart`（`entry`, `item`, `extendedCost`）
- `page_text_locale_key.dart`（`id`, `locale`）
- `player_create_info_action_key.dart`（`race`, `class_`, `button`）
- `player_create_info_item_key.dart`（`race`, `class_`, `itemId`）
- `player_create_info_key.dart`（`race`, `class_`）
- `player_create_info_skill_key.dart`（`raceMask`, `classMask`, `skill`）
- `player_create_info_spell_custom_key.dart`（`raceMask`, `classMask`, `spell`）
- `quest_offer_reward_locale_key.dart`（`id`, `locale`）
- `quest_request_items_locale_key.dart`（`id`, `locale`）
- `quest_template_locale_key.dart`（`id`, `locale`）
- `smart_script_key.dart`（`entryOrGuid`, `sourceType`, `id`, `link`）
- `spell_area_key.dart`（`spell`, `area`, `questStart`, `auraSpell`, `racemask`,
  `gender`）
- `spell_group_key.dart`（`id`, `spellId`）
- `spell_linked_spell_key.dart`（`spellTrigger`, `spellEffect`, `type`）
- `spell_loot_template_key.dart`（`entry`, `item`）
- `spell_rank_key.dart`（`firstSpellId`, `rank`）

## 保留的特殊定位器或身份类型

- `player_create_info_cast_spell_key.dart`：表没有主键或唯一约束；使用包含
  `raceMask`, `classMask`, `spell`, nullable `note` 的全行快照，以 null-safe、
  binary 文本比较和 `LIMIT 1` 定位。
- `loot_template_key.dart`：跨多个具体 loot 表的 reviewed 联合定位体系，包含
  表类型及各表完整物理定位列；不能退化成单个 `entry`。
- `loot_template_entry_key.dart`：Picker 的跨 loot 表身份，由 `tableType` 与
  `entry` 共同组成。
- `waypoint_data_key.dart`：只读路径 Picker 的 path 分组身份，不是单个
  `waypoint_data` 物理行主键，因此不属于普通单列行定位器迁移范围。

`test/database_editing_global_contract_test.dart` 对这份保留分类执行精确文件集合
检查；各模块合同继续验证专用 Key 的字段、值相等、Brief 构造与 Repository
`WHERE` 完整性。
