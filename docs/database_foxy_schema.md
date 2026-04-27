# foxy 数据库表结构文档

> 生成时间: 2026-04-27 12:42:42.577393
> 数据库: foxy
> 表数量: 45

---

## dbc_achievement

- 存储引擎: InnoDB
- 行数: 1799

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Faction` | `int` | YES |  |  |  |
| `Instance_ID` | `int` | YES |  |  |  |
| `Supercedes` | `int` | YES |  |  |  |
| `Title_lang_enUS` | `text` | YES |  |  |  |
| `Title_lang_koKR` | `text` | YES |  |  |  |
| `Title_lang_frFR` | `text` | YES |  |  |  |
| `Title_lang_deDE` | `text` | YES |  |  |  |
| `Title_lang_zhCN` | `text` | YES |  |  |  |
| `Title_lang_zhTW` | `text` | YES |  |  |  |
| `Title_lang_esES` | `text` | YES |  |  |  |
| `Title_lang_esMX` | `text` | YES |  |  |  |
| `Title_lang_ruRU` | `text` | YES |  |  |  |
| `Title_lang_jaJP` | `text` | YES |  |  |  |
| `Title_lang_ptPT` | `text` | YES |  |  |  |
| `Title_lang_ptBR` | `text` | YES |  |  |  |
| `Title_lang_itIT` | `text` | YES |  |  |  |
| `Title_lang_unk1` | `text` | YES |  |  |  |
| `Title_lang_unk2` | `text` | YES |  |  |  |
| `Title_lang_unk3` | `text` | YES |  |  |  |
| `Title_lang_Flags` | `int` | YES |  |  |  |
| `Description_lang_enUS` | `text` | YES |  |  |  |
| `Description_lang_koKR` | `text` | YES |  |  |  |
| `Description_lang_frFR` | `text` | YES |  |  |  |
| `Description_lang_deDE` | `text` | YES |  |  |  |
| `Description_lang_zhCN` | `text` | YES |  |  |  |
| `Description_lang_zhTW` | `text` | YES |  |  |  |
| `Description_lang_esES` | `text` | YES |  |  |  |
| `Description_lang_esMX` | `text` | YES |  |  |  |
| `Description_lang_ruRU` | `text` | YES |  |  |  |
| `Description_lang_jaJP` | `text` | YES |  |  |  |
| `Description_lang_ptPT` | `text` | YES |  |  |  |
| `Description_lang_ptBR` | `text` | YES |  |  |  |
| `Description_lang_itIT` | `text` | YES |  |  |  |
| `Description_lang_unk1` | `text` | YES |  |  |  |
| `Description_lang_unk2` | `text` | YES |  |  |  |
| `Description_lang_unk3` | `text` | YES |  |  |  |
| `Description_lang_Flags` | `int` | YES |  |  |  |
| `Category` | `int` | YES |  |  |  |
| `Points` | `int` | YES |  |  |  |
| `Ui_order` | `int` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `IconID` | `int` | YES |  |  |  |
| `Reward_lang_enUS` | `text` | YES |  |  |  |
| `Reward_lang_koKR` | `text` | YES |  |  |  |
| `Reward_lang_frFR` | `text` | YES |  |  |  |
| `Reward_lang_deDE` | `text` | YES |  |  |  |
| `Reward_lang_zhCN` | `text` | YES |  |  |  |
| `Reward_lang_zhTW` | `text` | YES |  |  |  |
| `Reward_lang_esES` | `text` | YES |  |  |  |
| `Reward_lang_esMX` | `text` | YES |  |  |  |
| `Reward_lang_ruRU` | `text` | YES |  |  |  |
| `Reward_lang_jaJP` | `text` | YES |  |  |  |
| `Reward_lang_ptPT` | `text` | YES |  |  |  |
| `Reward_lang_ptBR` | `text` | YES |  |  |  |
| `Reward_lang_itIT` | `text` | YES |  |  |  |
| `Reward_lang_unk1` | `text` | YES |  |  |  |
| `Reward_lang_unk2` | `text` | YES |  |  |  |
| `Reward_lang_unk3` | `text` | YES |  |  |  |
| `Reward_lang_Flags` | `int` | YES |  |  |  |
| `Minimum_criteria` | `int` | YES |  |  |  |
| `Shares_criteria` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_achievement` (
  `ID` int NOT NULL,
  `Faction` int DEFAULT NULL,
  `Instance_ID` int DEFAULT NULL,
  `Supercedes` int DEFAULT NULL,
  `Title_lang_enUS` text,
  `Title_lang_koKR` text,
  `Title_lang_frFR` text,
  `Title_lang_deDE` text,
  `Title_lang_zhCN` text,
  `Title_lang_zhTW` text,
  `Title_lang_esES` text,
  `Title_lang_esMX` text,
  `Title_lang_ruRU` text,
  `Title_lang_jaJP` text,
  `Title_lang_ptPT` text,
  `Title_lang_ptBR` text,
  `Title_lang_itIT` text,
  `Title_lang_unk1` text,
  `Title_lang_unk2` text,
  `Title_lang_unk3` text,
  `Title_lang_Flags` int DEFAULT NULL,
  `Description_lang_enUS` text,
  `Description_lang_koKR` text,
  `Description_lang_frFR` text,
  `Description_lang_deDE` text,
  `Description_lang_zhCN` text,
  `Description_lang_zhTW` text,
  `Description_lang_esES` text,
  `Description_lang_esMX` text,
  `Description_lang_ruRU` text,
  `Description_lang_jaJP` text,
  `Description_lang_ptPT` text,
  `Description_lang_ptBR` text,
  `Description_lang_itIT` text,
  `Description_lang_unk1` text,
  `Description_lang_unk2` text,
  `Description_lang_unk3` text,
  `Description_lang_Flags` int DEFAULT NULL,
  `Category` int DEFAULT NULL,
  `Points` int DEFAULT NULL,
  `Ui_order` int DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `IconID` int DEFAULT NULL,
  `Reward_lang_enUS` text,
  `Reward_lang_koKR` text,
  `Reward_lang_frFR` text,
  `Reward_lang_deDE` text,
  `Reward_lang_zhCN` text,
  `Reward_lang_zhTW` text,
  `Reward_lang_esES` text,
  `Reward_lang_esMX` text,
  `Reward_lang_ruRU` text,
  `Reward_lang_jaJP` text,
  `Reward_lang_ptPT` text,
  `Reward_lang_ptBR` text,
  `Reward_lang_itIT` text,
  `Reward_lang_unk1` text,
  `Reward_lang_unk2` text,
  `Reward_lang_unk3` text,
  `Reward_lang_Flags` int DEFAULT NULL,
  `Minimum_criteria` int DEFAULT NULL,
  `Shares_criteria` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_achievement_category

- 存储引擎: InnoDB
- 行数: 86

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Parent` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `Ui_order` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_achievement_category` (
  `ID` int NOT NULL,
  `Parent` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `Ui_order` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_area_table

- 存储引擎: InnoDB
- 行数: 2280

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `ContinentID` | `int` | YES |  |  |  |
| `ParentAreaID` | `int` | YES |  |  |  |
| `AreaBit` | `int` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `SoundProviderPref` | `int` | YES |  |  |  |
| `SoundProviderPrefUnderwater` | `int` | YES |  |  |  |
| `AmbienceID` | `int` | YES |  |  |  |
| `ZoneMusic` | `int` | YES |  |  |  |
| `IntroSound` | `int` | YES |  |  |  |
| `ExplorationLevel` | `int` | YES |  |  |  |
| `AreaName_lang_enUS` | `text` | YES |  |  |  |
| `AreaName_lang_koKR` | `text` | YES |  |  |  |
| `AreaName_lang_frFR` | `text` | YES |  |  |  |
| `AreaName_lang_deDE` | `text` | YES |  |  |  |
| `AreaName_lang_zhCN` | `text` | YES |  |  |  |
| `AreaName_lang_zhTW` | `text` | YES |  |  |  |
| `AreaName_lang_esES` | `text` | YES |  |  |  |
| `AreaName_lang_esMX` | `text` | YES |  |  |  |
| `AreaName_lang_ruRU` | `text` | YES |  |  |  |
| `AreaName_lang_jaJP` | `text` | YES |  |  |  |
| `AreaName_lang_ptPT` | `text` | YES |  |  |  |
| `AreaName_lang_ptBR` | `text` | YES |  |  |  |
| `AreaName_lang_itIT` | `text` | YES |  |  |  |
| `AreaName_lang_unk1` | `text` | YES |  |  |  |
| `AreaName_lang_unk2` | `text` | YES |  |  |  |
| `AreaName_lang_unk3` | `text` | YES |  |  |  |
| `AreaName_lang_Flags` | `int` | YES |  |  |  |
| `FactionGroupMask` | `int` | YES |  |  |  |
| `LiquidTypeID0` | `int` | YES |  |  |  |
| `LiquidTypeID1` | `int` | YES |  |  |  |
| `LiquidTypeID2` | `int` | YES |  |  |  |
| `LiquidTypeID3` | `int` | YES |  |  |  |
| `MinElevation` | `float` | YES |  |  |  |
| `Ambient_multiplier` | `float` | YES |  |  |  |
| `LightID` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_area_table` (
  `ID` int NOT NULL,
  `ContinentID` int DEFAULT NULL,
  `ParentAreaID` int DEFAULT NULL,
  `AreaBit` int DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `SoundProviderPref` int DEFAULT NULL,
  `SoundProviderPrefUnderwater` int DEFAULT NULL,
  `AmbienceID` int DEFAULT NULL,
  `ZoneMusic` int DEFAULT NULL,
  `IntroSound` int DEFAULT NULL,
  `ExplorationLevel` int DEFAULT NULL,
  `AreaName_lang_enUS` text,
  `AreaName_lang_koKR` text,
  `AreaName_lang_frFR` text,
  `AreaName_lang_deDE` text,
  `AreaName_lang_zhCN` text,
  `AreaName_lang_zhTW` text,
  `AreaName_lang_esES` text,
  `AreaName_lang_esMX` text,
  `AreaName_lang_ruRU` text,
  `AreaName_lang_jaJP` text,
  `AreaName_lang_ptPT` text,
  `AreaName_lang_ptBR` text,
  `AreaName_lang_itIT` text,
  `AreaName_lang_unk1` text,
  `AreaName_lang_unk2` text,
  `AreaName_lang_unk3` text,
  `AreaName_lang_Flags` int DEFAULT NULL,
  `FactionGroupMask` int DEFAULT NULL,
  `LiquidTypeID0` int DEFAULT NULL,
  `LiquidTypeID1` int DEFAULT NULL,
  `LiquidTypeID2` int DEFAULT NULL,
  `LiquidTypeID3` int DEFAULT NULL,
  `MinElevation` float DEFAULT NULL,
  `Ambient_multiplier` float DEFAULT NULL,
  `LightID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_auction_house

- 存储引擎: InnoDB
- 行数: 7

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `FactionID` | `int` | YES |  |  |  |
| `DepositRate` | `int` | YES |  |  |  |
| `ConsignmentRate` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_auction_house` (
  `ID` int NOT NULL,
  `FactionID` int DEFAULT NULL,
  `DepositRate` int DEFAULT NULL,
  `ConsignmentRate` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_bank_bag_slot_prices

- 存储引擎: InnoDB
- 行数: 12

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Cost` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_bank_bag_slot_prices` (
  `ID` int NOT NULL,
  `Cost` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_char_base_info

- 存储引擎: InnoDB
- 行数: 62

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `RaceID` | `tinyint` | YES |  |  |  |
| `ClassID` | `tinyint` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_char_base_info` (
  `RaceID` tinyint DEFAULT NULL,
  `ClassID` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_char_hair_geosets

- 存储引擎: InnoDB
- 行数: 339

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `RaceID` | `int` | YES |  |  |  |
| `SexID` | `int` | YES |  |  |  |
| `VariationID` | `int` | YES |  |  |  |
| `GeosetID` | `int` | YES |  |  |  |
| `Showscalp` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_char_hair_geosets` (
  `ID` int NOT NULL,
  `RaceID` int DEFAULT NULL,
  `SexID` int DEFAULT NULL,
  `VariationID` int DEFAULT NULL,
  `GeosetID` int DEFAULT NULL,
  `Showscalp` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_char_hair_textures

- 存储引擎: InnoDB
- 行数: 89

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Field_0_5_3_3368_001_race` | `int` | YES |  |  |  |
| `Field_0_5_3_3368_002_gender` | `int` | YES |  |  |  |
| `Field_0_5_3_3368_003` | `int` | YES |  |  |  |
| `Field_0_5_3_3368_004_mayberacemask` | `int` | YES |  |  |  |
| `Field_0_5_3_3368_005_the_x_in_hair_xy_blp` | `int` | YES |  |  |  |
| `Field_0_5_3_3368_006` | `int` | YES |  |  |  |
| `Field_0_5_3_3368_007` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_char_hair_textures` (
  `ID` int NOT NULL,
  `Field_0_5_3_3368_001_race` int DEFAULT NULL,
  `Field_0_5_3_3368_002_gender` int DEFAULT NULL,
  `Field_0_5_3_3368_003` int DEFAULT NULL,
  `Field_0_5_3_3368_004_mayberacemask` int DEFAULT NULL,
  `Field_0_5_3_3368_005_the_x_in_hair_xy_blp` int DEFAULT NULL,
  `Field_0_5_3_3368_006` int DEFAULT NULL,
  `Field_0_5_3_3368_007` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_char_sections

- 存储引擎: InnoDB
- 行数: 9042

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `RaceID` | `int` | YES |  |  |  |
| `SexID` | `int` | YES |  |  |  |
| `BaseSection` | `int` | YES |  |  |  |
| `TextureName0` | `text` | YES |  |  |  |
| `TextureName1` | `text` | YES |  |  |  |
| `TextureName2` | `text` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `VariationIndex` | `int` | YES |  |  |  |
| `ColorIndex` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_char_sections` (
  `ID` int NOT NULL,
  `RaceID` int DEFAULT NULL,
  `SexID` int DEFAULT NULL,
  `BaseSection` int DEFAULT NULL,
  `TextureName0` text,
  `TextureName1` text,
  `TextureName2` text,
  `Flags` int DEFAULT NULL,
  `VariationIndex` int DEFAULT NULL,
  `ColorIndex` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_char_start_outfit

- 存储引擎: InnoDB
- 行数: 126

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `RaceID` | `tinyint` | YES |  |  |  |
| `ClassID` | `tinyint` | YES |  |  |  |
| `SexID` | `tinyint` | YES |  |  |  |
| `OutfitID` | `tinyint` | YES |  |  |  |
| `ItemID0` | `int` | YES |  |  |  |
| `ItemID1` | `int` | YES |  |  |  |
| `ItemID2` | `int` | YES |  |  |  |
| `ItemID3` | `int` | YES |  |  |  |
| `ItemID4` | `int` | YES |  |  |  |
| `ItemID5` | `int` | YES |  |  |  |
| `ItemID6` | `int` | YES |  |  |  |
| `ItemID7` | `int` | YES |  |  |  |
| `ItemID8` | `int` | YES |  |  |  |
| `ItemID9` | `int` | YES |  |  |  |
| `ItemID10` | `int` | YES |  |  |  |
| `ItemID11` | `int` | YES |  |  |  |
| `ItemID12` | `int` | YES |  |  |  |
| `ItemID13` | `int` | YES |  |  |  |
| `ItemID14` | `int` | YES |  |  |  |
| `ItemID15` | `int` | YES |  |  |  |
| `ItemID16` | `int` | YES |  |  |  |
| `ItemID17` | `int` | YES |  |  |  |
| `ItemID18` | `int` | YES |  |  |  |
| `ItemID19` | `int` | YES |  |  |  |
| `ItemID20` | `int` | YES |  |  |  |
| `ItemID21` | `int` | YES |  |  |  |
| `ItemID22` | `int` | YES |  |  |  |
| `ItemID23` | `int` | YES |  |  |  |
| `DisplayItemID0` | `int` | YES |  |  |  |
| `DisplayItemID1` | `int` | YES |  |  |  |
| `DisplayItemID2` | `int` | YES |  |  |  |
| `DisplayItemID3` | `int` | YES |  |  |  |
| `DisplayItemID4` | `int` | YES |  |  |  |
| `DisplayItemID5` | `int` | YES |  |  |  |
| `DisplayItemID6` | `int` | YES |  |  |  |
| `DisplayItemID7` | `int` | YES |  |  |  |
| `DisplayItemID8` | `int` | YES |  |  |  |
| `DisplayItemID9` | `int` | YES |  |  |  |
| `DisplayItemID10` | `int` | YES |  |  |  |
| `DisplayItemID11` | `int` | YES |  |  |  |
| `DisplayItemID12` | `int` | YES |  |  |  |
| `DisplayItemID13` | `int` | YES |  |  |  |
| `DisplayItemID14` | `int` | YES |  |  |  |
| `DisplayItemID15` | `int` | YES |  |  |  |
| `DisplayItemID16` | `int` | YES |  |  |  |
| `DisplayItemID17` | `int` | YES |  |  |  |
| `DisplayItemID18` | `int` | YES |  |  |  |
| `DisplayItemID19` | `int` | YES |  |  |  |
| `DisplayItemID20` | `int` | YES |  |  |  |
| `DisplayItemID21` | `int` | YES |  |  |  |
| `DisplayItemID22` | `int` | YES |  |  |  |
| `DisplayItemID23` | `int` | YES |  |  |  |
| `InventoryType0` | `int` | YES |  |  |  |
| `InventoryType1` | `int` | YES |  |  |  |
| `InventoryType2` | `int` | YES |  |  |  |
| `InventoryType3` | `int` | YES |  |  |  |
| `InventoryType4` | `int` | YES |  |  |  |
| `InventoryType5` | `int` | YES |  |  |  |
| `InventoryType6` | `int` | YES |  |  |  |
| `InventoryType7` | `int` | YES |  |  |  |
| `InventoryType8` | `int` | YES |  |  |  |
| `InventoryType9` | `int` | YES |  |  |  |
| `InventoryType10` | `int` | YES |  |  |  |
| `InventoryType11` | `int` | YES |  |  |  |
| `InventoryType12` | `int` | YES |  |  |  |
| `InventoryType13` | `int` | YES |  |  |  |
| `InventoryType14` | `int` | YES |  |  |  |
| `InventoryType15` | `int` | YES |  |  |  |
| `InventoryType16` | `int` | YES |  |  |  |
| `InventoryType17` | `int` | YES |  |  |  |
| `InventoryType18` | `int` | YES |  |  |  |
| `InventoryType19` | `int` | YES |  |  |  |
| `InventoryType20` | `int` | YES |  |  |  |
| `InventoryType21` | `int` | YES |  |  |  |
| `InventoryType22` | `int` | YES |  |  |  |
| `InventoryType23` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_char_start_outfit` (
  `ID` int NOT NULL,
  `RaceID` tinyint DEFAULT NULL,
  `ClassID` tinyint DEFAULT NULL,
  `SexID` tinyint DEFAULT NULL,
  `OutfitID` tinyint DEFAULT NULL,
  `ItemID0` int DEFAULT NULL,
  `ItemID1` int DEFAULT NULL,
  `ItemID2` int DEFAULT NULL,
  `ItemID3` int DEFAULT NULL,
  `ItemID4` int DEFAULT NULL,
  `ItemID5` int DEFAULT NULL,
  `ItemID6` int DEFAULT NULL,
  `ItemID7` int DEFAULT NULL,
  `ItemID8` int DEFAULT NULL,
  `ItemID9` int DEFAULT NULL,
  `ItemID10` int DEFAULT NULL,
  `ItemID11` int DEFAULT NULL,
  `ItemID12` int DEFAULT NULL,
  `ItemID13` int DEFAULT NULL,
  `ItemID14` int DEFAULT NULL,
  `ItemID15` int DEFAULT NULL,
  `ItemID16` int DEFAULT NULL,
  `ItemID17` int DEFAULT NULL,
  `ItemID18` int DEFAULT NULL,
  `ItemID19` int DEFAULT NULL,
  `ItemID20` int DEFAULT NULL,
  `ItemID21` int DEFAULT NULL,
  `ItemID22` int DEFAULT NULL,
  `ItemID23` int DEFAULT NULL,
  `DisplayItemID0` int DEFAULT NULL,
  `DisplayItemID1` int DEFAULT NULL,
  `DisplayItemID2` int DEFAULT NULL,
  `DisplayItemID3` int DEFAULT NULL,
  `DisplayItemID4` int DEFAULT NULL,
  `DisplayItemID5` int DEFAULT NULL,
  `DisplayItemID6` int DEFAULT NULL,
  `DisplayItemID7` int DEFAULT NULL,
  `DisplayItemID8` int DEFAULT NULL,
  `DisplayItemID9` int DEFAULT NULL,
  `DisplayItemID10` int DEFAULT NULL,
  `DisplayItemID11` int DEFAULT NULL,
  `DisplayItemID12` int DEFAULT NULL,
  `DisplayItemID13` int DEFAULT NULL,
  `DisplayItemID14` int DEFAULT NULL,
  `DisplayItemID15` int DEFAULT NULL,
  `DisplayItemID16` int DEFAULT NULL,
  `DisplayItemID17` int DEFAULT NULL,
  `DisplayItemID18` int DEFAULT NULL,
  `DisplayItemID19` int DEFAULT NULL,
  `DisplayItemID20` int DEFAULT NULL,
  `DisplayItemID21` int DEFAULT NULL,
  `DisplayItemID22` int DEFAULT NULL,
  `DisplayItemID23` int DEFAULT NULL,
  `InventoryType0` int DEFAULT NULL,
  `InventoryType1` int DEFAULT NULL,
  `InventoryType2` int DEFAULT NULL,
  `InventoryType3` int DEFAULT NULL,
  `InventoryType4` int DEFAULT NULL,
  `InventoryType5` int DEFAULT NULL,
  `InventoryType6` int DEFAULT NULL,
  `InventoryType7` int DEFAULT NULL,
  `InventoryType8` int DEFAULT NULL,
  `InventoryType9` int DEFAULT NULL,
  `InventoryType10` int DEFAULT NULL,
  `InventoryType11` int DEFAULT NULL,
  `InventoryType12` int DEFAULT NULL,
  `InventoryType13` int DEFAULT NULL,
  `InventoryType14` int DEFAULT NULL,
  `InventoryType15` int DEFAULT NULL,
  `InventoryType16` int DEFAULT NULL,
  `InventoryType17` int DEFAULT NULL,
  `InventoryType18` int DEFAULT NULL,
  `InventoryType19` int DEFAULT NULL,
  `InventoryType20` int DEFAULT NULL,
  `InventoryType21` int DEFAULT NULL,
  `InventoryType22` int DEFAULT NULL,
  `InventoryType23` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_char_titles

- 存储引擎: InnoDB
- 行数: 142

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Condition_ID` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `Name1_lang_enUS` | `text` | YES |  |  |  |
| `Name1_lang_koKR` | `text` | YES |  |  |  |
| `Name1_lang_frFR` | `text` | YES |  |  |  |
| `Name1_lang_deDE` | `text` | YES |  |  |  |
| `Name1_lang_zhCN` | `text` | YES |  |  |  |
| `Name1_lang_zhTW` | `text` | YES |  |  |  |
| `Name1_lang_esES` | `text` | YES |  |  |  |
| `Name1_lang_esMX` | `text` | YES |  |  |  |
| `Name1_lang_ruRU` | `text` | YES |  |  |  |
| `Name1_lang_jaJP` | `text` | YES |  |  |  |
| `Name1_lang_ptPT` | `text` | YES |  |  |  |
| `Name1_lang_ptBR` | `text` | YES |  |  |  |
| `Name1_lang_itIT` | `text` | YES |  |  |  |
| `Name1_lang_unk1` | `text` | YES |  |  |  |
| `Name1_lang_unk2` | `text` | YES |  |  |  |
| `Name1_lang_unk3` | `text` | YES |  |  |  |
| `Name1_lang_Flags` | `int` | YES |  |  |  |
| `Mask_ID` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_char_titles` (
  `ID` int NOT NULL,
  `Condition_ID` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `Name1_lang_enUS` text,
  `Name1_lang_koKR` text,
  `Name1_lang_frFR` text,
  `Name1_lang_deDE` text,
  `Name1_lang_zhCN` text,
  `Name1_lang_zhTW` text,
  `Name1_lang_esES` text,
  `Name1_lang_esMX` text,
  `Name1_lang_ruRU` text,
  `Name1_lang_jaJP` text,
  `Name1_lang_ptPT` text,
  `Name1_lang_ptBR` text,
  `Name1_lang_itIT` text,
  `Name1_lang_unk1` text,
  `Name1_lang_unk2` text,
  `Name1_lang_unk3` text,
  `Name1_lang_Flags` int DEFAULT NULL,
  `Mask_ID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_chat_channels

- 存储引擎: InnoDB
- 行数: 6

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `FactionGroup` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `Shortcut_lang_enUS` | `text` | YES |  |  |  |
| `Shortcut_lang_koKR` | `text` | YES |  |  |  |
| `Shortcut_lang_frFR` | `text` | YES |  |  |  |
| `Shortcut_lang_deDE` | `text` | YES |  |  |  |
| `Shortcut_lang_zhCN` | `text` | YES |  |  |  |
| `Shortcut_lang_zhTW` | `text` | YES |  |  |  |
| `Shortcut_lang_esES` | `text` | YES |  |  |  |
| `Shortcut_lang_esMX` | `text` | YES |  |  |  |
| `Shortcut_lang_ruRU` | `text` | YES |  |  |  |
| `Shortcut_lang_jaJP` | `text` | YES |  |  |  |
| `Shortcut_lang_ptPT` | `text` | YES |  |  |  |
| `Shortcut_lang_ptBR` | `text` | YES |  |  |  |
| `Shortcut_lang_itIT` | `text` | YES |  |  |  |
| `Shortcut_lang_unk1` | `text` | YES |  |  |  |
| `Shortcut_lang_unk2` | `text` | YES |  |  |  |
| `Shortcut_lang_unk3` | `text` | YES |  |  |  |
| `Shortcut_lang_Flags` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_chat_channels` (
  `ID` int NOT NULL,
  `Flags` int DEFAULT NULL,
  `FactionGroup` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `Shortcut_lang_enUS` text,
  `Shortcut_lang_koKR` text,
  `Shortcut_lang_frFR` text,
  `Shortcut_lang_deDE` text,
  `Shortcut_lang_zhCN` text,
  `Shortcut_lang_zhTW` text,
  `Shortcut_lang_esES` text,
  `Shortcut_lang_esMX` text,
  `Shortcut_lang_ruRU` text,
  `Shortcut_lang_jaJP` text,
  `Shortcut_lang_ptPT` text,
  `Shortcut_lang_ptBR` text,
  `Shortcut_lang_itIT` text,
  `Shortcut_lang_unk1` text,
  `Shortcut_lang_unk2` text,
  `Shortcut_lang_unk3` text,
  `Shortcut_lang_Flags` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_chr_classes

- 存储引擎: InnoDB
- 行数: 10

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `DamageBonusStat` | `int` | YES |  |  |  |
| `DisplayPower` | `int` | YES |  |  |  |
| `PetNameToken` | `text` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `Name_female_lang_enUS` | `text` | YES |  |  |  |
| `Name_female_lang_koKR` | `text` | YES |  |  |  |
| `Name_female_lang_frFR` | `text` | YES |  |  |  |
| `Name_female_lang_deDE` | `text` | YES |  |  |  |
| `Name_female_lang_zhCN` | `text` | YES |  |  |  |
| `Name_female_lang_zhTW` | `text` | YES |  |  |  |
| `Name_female_lang_esES` | `text` | YES |  |  |  |
| `Name_female_lang_esMX` | `text` | YES |  |  |  |
| `Name_female_lang_ruRU` | `text` | YES |  |  |  |
| `Name_female_lang_jaJP` | `text` | YES |  |  |  |
| `Name_female_lang_ptPT` | `text` | YES |  |  |  |
| `Name_female_lang_ptBR` | `text` | YES |  |  |  |
| `Name_female_lang_itIT` | `text` | YES |  |  |  |
| `Name_female_lang_unk1` | `text` | YES |  |  |  |
| `Name_female_lang_unk2` | `text` | YES |  |  |  |
| `Name_female_lang_unk3` | `text` | YES |  |  |  |
| `Name_female_lang_Flags` | `int` | YES |  |  |  |
| `Name_male_lang_enUS` | `text` | YES |  |  |  |
| `Name_male_lang_koKR` | `text` | YES |  |  |  |
| `Name_male_lang_frFR` | `text` | YES |  |  |  |
| `Name_male_lang_deDE` | `text` | YES |  |  |  |
| `Name_male_lang_zhCN` | `text` | YES |  |  |  |
| `Name_male_lang_zhTW` | `text` | YES |  |  |  |
| `Name_male_lang_esES` | `text` | YES |  |  |  |
| `Name_male_lang_esMX` | `text` | YES |  |  |  |
| `Name_male_lang_ruRU` | `text` | YES |  |  |  |
| `Name_male_lang_jaJP` | `text` | YES |  |  |  |
| `Name_male_lang_ptPT` | `text` | YES |  |  |  |
| `Name_male_lang_ptBR` | `text` | YES |  |  |  |
| `Name_male_lang_itIT` | `text` | YES |  |  |  |
| `Name_male_lang_unk1` | `text` | YES |  |  |  |
| `Name_male_lang_unk2` | `text` | YES |  |  |  |
| `Name_male_lang_unk3` | `text` | YES |  |  |  |
| `Name_male_lang_Flags` | `int` | YES |  |  |  |
| `Filename` | `text` | YES |  |  |  |
| `SpellClassSet` | `int` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `CinematicSequenceID` | `int` | YES |  |  |  |
| `Required_expansion` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_chr_classes` (
  `ID` int NOT NULL,
  `DamageBonusStat` int DEFAULT NULL,
  `DisplayPower` int DEFAULT NULL,
  `PetNameToken` text,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `Name_female_lang_enUS` text,
  `Name_female_lang_koKR` text,
  `Name_female_lang_frFR` text,
  `Name_female_lang_deDE` text,
  `Name_female_lang_zhCN` text,
  `Name_female_lang_zhTW` text,
  `Name_female_lang_esES` text,
  `Name_female_lang_esMX` text,
  `Name_female_lang_ruRU` text,
  `Name_female_lang_jaJP` text,
  `Name_female_lang_ptPT` text,
  `Name_female_lang_ptBR` text,
  `Name_female_lang_itIT` text,
  `Name_female_lang_unk1` text,
  `Name_female_lang_unk2` text,
  `Name_female_lang_unk3` text,
  `Name_female_lang_Flags` int DEFAULT NULL,
  `Name_male_lang_enUS` text,
  `Name_male_lang_koKR` text,
  `Name_male_lang_frFR` text,
  `Name_male_lang_deDE` text,
  `Name_male_lang_zhCN` text,
  `Name_male_lang_zhTW` text,
  `Name_male_lang_esES` text,
  `Name_male_lang_esMX` text,
  `Name_male_lang_ruRU` text,
  `Name_male_lang_jaJP` text,
  `Name_male_lang_ptPT` text,
  `Name_male_lang_ptBR` text,
  `Name_male_lang_itIT` text,
  `Name_male_lang_unk1` text,
  `Name_male_lang_unk2` text,
  `Name_male_lang_unk3` text,
  `Name_male_lang_Flags` int DEFAULT NULL,
  `Filename` text,
  `SpellClassSet` int DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `CinematicSequenceID` int DEFAULT NULL,
  `Required_expansion` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_chr_races

- 存储引擎: InnoDB
- 行数: 21

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `FactionID` | `int` | YES |  |  |  |
| `ExplorationSoundID` | `int` | YES |  |  |  |
| `MaleDisplayID` | `int` | YES |  |  |  |
| `FemaleDisplayID` | `int` | YES |  |  |  |
| `ClientPrefix` | `text` | YES |  |  |  |
| `BaseLanguage` | `int` | YES |  |  |  |
| `CreatureType` | `int` | YES |  |  |  |
| `ResSicknessSpellID` | `int` | YES |  |  |  |
| `SplashSoundID` | `int` | YES |  |  |  |
| `ClientFileString` | `text` | YES |  |  |  |
| `CinematicSequenceID` | `int` | YES |  |  |  |
| `Alliance` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `Name_female_lang_enUS` | `text` | YES |  |  |  |
| `Name_female_lang_koKR` | `text` | YES |  |  |  |
| `Name_female_lang_frFR` | `text` | YES |  |  |  |
| `Name_female_lang_deDE` | `text` | YES |  |  |  |
| `Name_female_lang_zhCN` | `text` | YES |  |  |  |
| `Name_female_lang_zhTW` | `text` | YES |  |  |  |
| `Name_female_lang_esES` | `text` | YES |  |  |  |
| `Name_female_lang_esMX` | `text` | YES |  |  |  |
| `Name_female_lang_ruRU` | `text` | YES |  |  |  |
| `Name_female_lang_jaJP` | `text` | YES |  |  |  |
| `Name_female_lang_ptPT` | `text` | YES |  |  |  |
| `Name_female_lang_ptBR` | `text` | YES |  |  |  |
| `Name_female_lang_itIT` | `text` | YES |  |  |  |
| `Name_female_lang_unk1` | `text` | YES |  |  |  |
| `Name_female_lang_unk2` | `text` | YES |  |  |  |
| `Name_female_lang_unk3` | `text` | YES |  |  |  |
| `Name_female_lang_Flags` | `int` | YES |  |  |  |
| `Name_male_lang_enUS` | `text` | YES |  |  |  |
| `Name_male_lang_koKR` | `text` | YES |  |  |  |
| `Name_male_lang_frFR` | `text` | YES |  |  |  |
| `Name_male_lang_deDE` | `text` | YES |  |  |  |
| `Name_male_lang_zhCN` | `text` | YES |  |  |  |
| `Name_male_lang_zhTW` | `text` | YES |  |  |  |
| `Name_male_lang_esES` | `text` | YES |  |  |  |
| `Name_male_lang_esMX` | `text` | YES |  |  |  |
| `Name_male_lang_ruRU` | `text` | YES |  |  |  |
| `Name_male_lang_jaJP` | `text` | YES |  |  |  |
| `Name_male_lang_ptPT` | `text` | YES |  |  |  |
| `Name_male_lang_ptBR` | `text` | YES |  |  |  |
| `Name_male_lang_itIT` | `text` | YES |  |  |  |
| `Name_male_lang_unk1` | `text` | YES |  |  |  |
| `Name_male_lang_unk2` | `text` | YES |  |  |  |
| `Name_male_lang_unk3` | `text` | YES |  |  |  |
| `Name_male_lang_Flags` | `int` | YES |  |  |  |
| `FacialHairCustomization0` | `text` | YES |  |  |  |
| `FacialHairCustomization1` | `text` | YES |  |  |  |
| `HairCustomization` | `text` | YES |  |  |  |
| `Required_expansion` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_chr_races` (
  `ID` int NOT NULL,
  `Flags` int DEFAULT NULL,
  `FactionID` int DEFAULT NULL,
  `ExplorationSoundID` int DEFAULT NULL,
  `MaleDisplayID` int DEFAULT NULL,
  `FemaleDisplayID` int DEFAULT NULL,
  `ClientPrefix` text,
  `BaseLanguage` int DEFAULT NULL,
  `CreatureType` int DEFAULT NULL,
  `ResSicknessSpellID` int DEFAULT NULL,
  `SplashSoundID` int DEFAULT NULL,
  `ClientFileString` text,
  `CinematicSequenceID` int DEFAULT NULL,
  `Alliance` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `Name_female_lang_enUS` text,
  `Name_female_lang_koKR` text,
  `Name_female_lang_frFR` text,
  `Name_female_lang_deDE` text,
  `Name_female_lang_zhCN` text,
  `Name_female_lang_zhTW` text,
  `Name_female_lang_esES` text,
  `Name_female_lang_esMX` text,
  `Name_female_lang_ruRU` text,
  `Name_female_lang_jaJP` text,
  `Name_female_lang_ptPT` text,
  `Name_female_lang_ptBR` text,
  `Name_female_lang_itIT` text,
  `Name_female_lang_unk1` text,
  `Name_female_lang_unk2` text,
  `Name_female_lang_unk3` text,
  `Name_female_lang_Flags` int DEFAULT NULL,
  `Name_male_lang_enUS` text,
  `Name_male_lang_koKR` text,
  `Name_male_lang_frFR` text,
  `Name_male_lang_deDE` text,
  `Name_male_lang_zhCN` text,
  `Name_male_lang_zhTW` text,
  `Name_male_lang_esES` text,
  `Name_male_lang_esMX` text,
  `Name_male_lang_ruRU` text,
  `Name_male_lang_jaJP` text,
  `Name_male_lang_ptPT` text,
  `Name_male_lang_ptBR` text,
  `Name_male_lang_itIT` text,
  `Name_male_lang_unk1` text,
  `Name_male_lang_unk2` text,
  `Name_male_lang_unk3` text,
  `Name_male_lang_Flags` int DEFAULT NULL,
  `FacialHairCustomization0` text,
  `FacialHairCustomization1` text,
  `HairCustomization` text,
  `Required_expansion` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_creature_display_info

- 存储引擎: InnoDB
- 行数: 24562

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `ModelID` | `int` | YES |  |  |  |
| `SoundID` | `int` | YES |  |  |  |
| `ExtendedDisplayInfoID` | `int` | YES |  |  |  |
| `CreatureModelScale` | `float` | YES |  |  |  |
| `CreatureModelAlpha` | `int` | YES |  |  |  |
| `TextureVariation0` | `text` | YES |  |  |  |
| `TextureVariation1` | `text` | YES |  |  |  |
| `TextureVariation2` | `text` | YES |  |  |  |
| `PortraitTextureName` | `text` | YES |  |  |  |
| `SizeClass` | `int` | YES |  |  |  |
| `BloodID` | `int` | YES |  |  |  |
| `NPCSoundID` | `int` | YES |  |  |  |
| `ParticleColorID` | `int` | YES |  |  |  |
| `CreatureGeosetData` | `int` | YES |  |  |  |
| `ObjectEffectPackageID` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_creature_display_info` (
  `ID` int NOT NULL,
  `ModelID` int DEFAULT NULL,
  `SoundID` int DEFAULT NULL,
  `ExtendedDisplayInfoID` int DEFAULT NULL,
  `CreatureModelScale` float DEFAULT NULL,
  `CreatureModelAlpha` int DEFAULT NULL,
  `TextureVariation0` text,
  `TextureVariation1` text,
  `TextureVariation2` text,
  `PortraitTextureName` text,
  `SizeClass` int DEFAULT NULL,
  `BloodID` int DEFAULT NULL,
  `NPCSoundID` int DEFAULT NULL,
  `ParticleColorID` int DEFAULT NULL,
  `CreatureGeosetData` int DEFAULT NULL,
  `ObjectEffectPackageID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_creature_model_data

- 存储引擎: InnoDB
- 行数: 1331

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `ModelName` | `text` | YES |  |  |  |
| `SizeClass` | `int` | YES |  |  |  |
| `ModelScale` | `float` | YES |  |  |  |
| `BloodID` | `int` | YES |  |  |  |
| `FootprintTextureID` | `int` | YES |  |  |  |
| `FootprintTextureLength` | `float` | YES |  |  |  |
| `FootprintTextureWidth` | `float` | YES |  |  |  |
| `FootprintParticleScale` | `float` | YES |  |  |  |
| `FoleyMaterialID` | `int` | YES |  |  |  |
| `FootstepShakeSize` | `int` | YES |  |  |  |
| `DeathThudShakeSize` | `int` | YES |  |  |  |
| `SoundID` | `int` | YES |  |  |  |
| `CollisionWidth` | `float` | YES |  |  |  |
| `CollisionHeight` | `float` | YES |  |  |  |
| `MountHeight` | `float` | YES |  |  |  |
| `GeoBoxMinX` | `float` | YES |  |  |  |
| `GeoBoxMinY` | `float` | YES |  |  |  |
| `GeoBoxMinZ` | `float` | YES |  |  |  |
| `GeoBoxMaxX` | `float` | YES |  |  |  |
| `GeoBoxMaxY` | `float` | YES |  |  |  |
| `GeoBoxMaxZ` | `float` | YES |  |  |  |
| `WorldEffectScale` | `float` | YES |  |  |  |
| `AttachedEffectScale` | `float` | YES |  |  |  |
| `MissileCollisionRadius` | `float` | YES |  |  |  |
| `MissileCollisionPush` | `float` | YES |  |  |  |
| `MissileCollisionRaise` | `float` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_creature_model_data` (
  `ID` int NOT NULL,
  `Flags` int DEFAULT NULL,
  `ModelName` text,
  `SizeClass` int DEFAULT NULL,
  `ModelScale` float DEFAULT NULL,
  `BloodID` int DEFAULT NULL,
  `FootprintTextureID` int DEFAULT NULL,
  `FootprintTextureLength` float DEFAULT NULL,
  `FootprintTextureWidth` float DEFAULT NULL,
  `FootprintParticleScale` float DEFAULT NULL,
  `FoleyMaterialID` int DEFAULT NULL,
  `FootstepShakeSize` int DEFAULT NULL,
  `DeathThudShakeSize` int DEFAULT NULL,
  `SoundID` int DEFAULT NULL,
  `CollisionWidth` float DEFAULT NULL,
  `CollisionHeight` float DEFAULT NULL,
  `MountHeight` float DEFAULT NULL,
  `GeoBoxMinX` float DEFAULT NULL,
  `GeoBoxMinY` float DEFAULT NULL,
  `GeoBoxMinZ` float DEFAULT NULL,
  `GeoBoxMaxX` float DEFAULT NULL,
  `GeoBoxMaxY` float DEFAULT NULL,
  `GeoBoxMaxZ` float DEFAULT NULL,
  `WorldEffectScale` float DEFAULT NULL,
  `AttachedEffectScale` float DEFAULT NULL,
  `MissileCollisionRadius` float DEFAULT NULL,
  `MissileCollisionPush` float DEFAULT NULL,
  `MissileCollisionRaise` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_creature_spell_data

- 存储引擎: InnoDB
- 行数: 802

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Spells0` | `int` | YES |  |  |  |
| `Spells1` | `int` | YES |  |  |  |
| `Spells2` | `int` | YES |  |  |  |
| `Spells3` | `int` | YES |  |  |  |
| `Availability0` | `int` | YES |  |  |  |
| `Availability1` | `int` | YES |  |  |  |
| `Availability2` | `int` | YES |  |  |  |
| `Availability3` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_creature_spell_data` (
  `ID` int NOT NULL,
  `Spells0` int DEFAULT NULL,
  `Spells1` int DEFAULT NULL,
  `Spells2` int DEFAULT NULL,
  `Spells3` int DEFAULT NULL,
  `Availability0` int DEFAULT NULL,
  `Availability1` int DEFAULT NULL,
  `Availability2` int DEFAULT NULL,
  `Availability3` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_currency_types

- 存储引擎: InnoDB
- 行数: 26

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `ItemID` | `int` | YES |  |  |  |
| `CategoryID` | `int` | YES |  |  |  |
| `BitIndex` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_currency_types` (
  `ID` int NOT NULL,
  `ItemID` int DEFAULT NULL,
  `CategoryID` int DEFAULT NULL,
  `BitIndex` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_durability_costs

- 存储引擎: InnoDB
- 行数: 300

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `WeaponSubClassCost0` | `int` | YES |  |  |  |
| `WeaponSubClassCost1` | `int` | YES |  |  |  |
| `WeaponSubClassCost2` | `int` | YES |  |  |  |
| `WeaponSubClassCost3` | `int` | YES |  |  |  |
| `WeaponSubClassCost4` | `int` | YES |  |  |  |
| `WeaponSubClassCost5` | `int` | YES |  |  |  |
| `WeaponSubClassCost6` | `int` | YES |  |  |  |
| `WeaponSubClassCost7` | `int` | YES |  |  |  |
| `WeaponSubClassCost8` | `int` | YES |  |  |  |
| `WeaponSubClassCost9` | `int` | YES |  |  |  |
| `WeaponSubClassCost10` | `int` | YES |  |  |  |
| `WeaponSubClassCost11` | `int` | YES |  |  |  |
| `WeaponSubClassCost12` | `int` | YES |  |  |  |
| `WeaponSubClassCost13` | `int` | YES |  |  |  |
| `WeaponSubClassCost14` | `int` | YES |  |  |  |
| `WeaponSubClassCost15` | `int` | YES |  |  |  |
| `WeaponSubClassCost16` | `int` | YES |  |  |  |
| `WeaponSubClassCost17` | `int` | YES |  |  |  |
| `WeaponSubClassCost18` | `int` | YES |  |  |  |
| `WeaponSubClassCost19` | `int` | YES |  |  |  |
| `WeaponSubClassCost20` | `int` | YES |  |  |  |
| `ArmorSubClassCost0` | `int` | YES |  |  |  |
| `ArmorSubClassCost1` | `int` | YES |  |  |  |
| `ArmorSubClassCost2` | `int` | YES |  |  |  |
| `ArmorSubClassCost3` | `int` | YES |  |  |  |
| `ArmorSubClassCost4` | `int` | YES |  |  |  |
| `ArmorSubClassCost5` | `int` | YES |  |  |  |
| `ArmorSubClassCost6` | `int` | YES |  |  |  |
| `ArmorSubClassCost7` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_durability_costs` (
  `ID` int NOT NULL,
  `WeaponSubClassCost0` int DEFAULT NULL,
  `WeaponSubClassCost1` int DEFAULT NULL,
  `WeaponSubClassCost2` int DEFAULT NULL,
  `WeaponSubClassCost3` int DEFAULT NULL,
  `WeaponSubClassCost4` int DEFAULT NULL,
  `WeaponSubClassCost5` int DEFAULT NULL,
  `WeaponSubClassCost6` int DEFAULT NULL,
  `WeaponSubClassCost7` int DEFAULT NULL,
  `WeaponSubClassCost8` int DEFAULT NULL,
  `WeaponSubClassCost9` int DEFAULT NULL,
  `WeaponSubClassCost10` int DEFAULT NULL,
  `WeaponSubClassCost11` int DEFAULT NULL,
  `WeaponSubClassCost12` int DEFAULT NULL,
  `WeaponSubClassCost13` int DEFAULT NULL,
  `WeaponSubClassCost14` int DEFAULT NULL,
  `WeaponSubClassCost15` int DEFAULT NULL,
  `WeaponSubClassCost16` int DEFAULT NULL,
  `WeaponSubClassCost17` int DEFAULT NULL,
  `WeaponSubClassCost18` int DEFAULT NULL,
  `WeaponSubClassCost19` int DEFAULT NULL,
  `WeaponSubClassCost20` int DEFAULT NULL,
  `ArmorSubClassCost0` int DEFAULT NULL,
  `ArmorSubClassCost1` int DEFAULT NULL,
  `ArmorSubClassCost2` int DEFAULT NULL,
  `ArmorSubClassCost3` int DEFAULT NULL,
  `ArmorSubClassCost4` int DEFAULT NULL,
  `ArmorSubClassCost5` int DEFAULT NULL,
  `ArmorSubClassCost6` int DEFAULT NULL,
  `ArmorSubClassCost7` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_durability_quality

- 存储引擎: InnoDB
- 行数: 16

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Data` | `float` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_durability_quality` (
  `ID` int NOT NULL,
  `Data` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_emotes_text

- 存储引擎: InnoDB
- 行数: 252

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Name` | `text` | YES |  |  |  |
| `EmoteID` | `int` | YES |  |  |  |
| `EmoteText0` | `int` | YES |  |  |  |
| `EmoteText1` | `int` | YES |  |  |  |
| `EmoteText2` | `int` | YES |  |  |  |
| `EmoteText3` | `int` | YES |  |  |  |
| `EmoteText4` | `int` | YES |  |  |  |
| `EmoteText5` | `int` | YES |  |  |  |
| `EmoteText6` | `int` | YES |  |  |  |
| `EmoteText7` | `int` | YES |  |  |  |
| `EmoteText8` | `int` | YES |  |  |  |
| `EmoteText9` | `int` | YES |  |  |  |
| `EmoteText10` | `int` | YES |  |  |  |
| `EmoteText11` | `int` | YES |  |  |  |
| `EmoteText12` | `int` | YES |  |  |  |
| `EmoteText13` | `int` | YES |  |  |  |
| `EmoteText14` | `int` | YES |  |  |  |
| `EmoteText15` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_emotes_text` (
  `ID` int NOT NULL,
  `Name` text,
  `EmoteID` int DEFAULT NULL,
  `EmoteText0` int DEFAULT NULL,
  `EmoteText1` int DEFAULT NULL,
  `EmoteText2` int DEFAULT NULL,
  `EmoteText3` int DEFAULT NULL,
  `EmoteText4` int DEFAULT NULL,
  `EmoteText5` int DEFAULT NULL,
  `EmoteText6` int DEFAULT NULL,
  `EmoteText7` int DEFAULT NULL,
  `EmoteText8` int DEFAULT NULL,
  `EmoteText9` int DEFAULT NULL,
  `EmoteText10` int DEFAULT NULL,
  `EmoteText11` int DEFAULT NULL,
  `EmoteText12` int DEFAULT NULL,
  `EmoteText13` int DEFAULT NULL,
  `EmoteText14` int DEFAULT NULL,
  `EmoteText15` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_faction

- 存储引擎: InnoDB
- 行数: 401

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `ReputationIndex` | `int` | YES |  |  |  |
| `ReputationRaceMask0` | `int` | YES |  |  |  |
| `ReputationRaceMask1` | `int` | YES |  |  |  |
| `ReputationRaceMask2` | `int` | YES |  |  |  |
| `ReputationRaceMask3` | `int` | YES |  |  |  |
| `ReputationClassMask0` | `int` | YES |  |  |  |
| `ReputationClassMask1` | `int` | YES |  |  |  |
| `ReputationClassMask2` | `int` | YES |  |  |  |
| `ReputationClassMask3` | `int` | YES |  |  |  |
| `ReputationBase0` | `int` | YES |  |  |  |
| `ReputationBase1` | `int` | YES |  |  |  |
| `ReputationBase2` | `int` | YES |  |  |  |
| `ReputationBase3` | `int` | YES |  |  |  |
| `ReputationFlags0` | `int` | YES |  |  |  |
| `ReputationFlags1` | `int` | YES |  |  |  |
| `ReputationFlags2` | `int` | YES |  |  |  |
| `ReputationFlags3` | `int` | YES |  |  |  |
| `ParentFactionID` | `int` | YES |  |  |  |
| `ParentFactionMod0` | `float` | YES |  |  |  |
| `ParentFactionMod1` | `float` | YES |  |  |  |
| `ParentFactionCap0` | `int` | YES |  |  |  |
| `ParentFactionCap1` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `Description_lang_enUS` | `text` | YES |  |  |  |
| `Description_lang_koKR` | `text` | YES |  |  |  |
| `Description_lang_frFR` | `text` | YES |  |  |  |
| `Description_lang_deDE` | `text` | YES |  |  |  |
| `Description_lang_zhCN` | `text` | YES |  |  |  |
| `Description_lang_zhTW` | `text` | YES |  |  |  |
| `Description_lang_esES` | `text` | YES |  |  |  |
| `Description_lang_esMX` | `text` | YES |  |  |  |
| `Description_lang_ruRU` | `text` | YES |  |  |  |
| `Description_lang_jaJP` | `text` | YES |  |  |  |
| `Description_lang_ptPT` | `text` | YES |  |  |  |
| `Description_lang_ptBR` | `text` | YES |  |  |  |
| `Description_lang_itIT` | `text` | YES |  |  |  |
| `Description_lang_unk1` | `text` | YES |  |  |  |
| `Description_lang_unk2` | `text` | YES |  |  |  |
| `Description_lang_unk3` | `text` | YES |  |  |  |
| `Description_lang_Flags` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_faction` (
  `ID` int NOT NULL,
  `ReputationIndex` int DEFAULT NULL,
  `ReputationRaceMask0` int DEFAULT NULL,
  `ReputationRaceMask1` int DEFAULT NULL,
  `ReputationRaceMask2` int DEFAULT NULL,
  `ReputationRaceMask3` int DEFAULT NULL,
  `ReputationClassMask0` int DEFAULT NULL,
  `ReputationClassMask1` int DEFAULT NULL,
  `ReputationClassMask2` int DEFAULT NULL,
  `ReputationClassMask3` int DEFAULT NULL,
  `ReputationBase0` int DEFAULT NULL,
  `ReputationBase1` int DEFAULT NULL,
  `ReputationBase2` int DEFAULT NULL,
  `ReputationBase3` int DEFAULT NULL,
  `ReputationFlags0` int DEFAULT NULL,
  `ReputationFlags1` int DEFAULT NULL,
  `ReputationFlags2` int DEFAULT NULL,
  `ReputationFlags3` int DEFAULT NULL,
  `ParentFactionID` int DEFAULT NULL,
  `ParentFactionMod0` float DEFAULT NULL,
  `ParentFactionMod1` float DEFAULT NULL,
  `ParentFactionCap0` int DEFAULT NULL,
  `ParentFactionCap1` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `Description_lang_enUS` text,
  `Description_lang_koKR` text,
  `Description_lang_frFR` text,
  `Description_lang_deDE` text,
  `Description_lang_zhCN` text,
  `Description_lang_zhTW` text,
  `Description_lang_esES` text,
  `Description_lang_esMX` text,
  `Description_lang_ruRU` text,
  `Description_lang_jaJP` text,
  `Description_lang_ptPT` text,
  `Description_lang_ptBR` text,
  `Description_lang_itIT` text,
  `Description_lang_unk1` text,
  `Description_lang_unk2` text,
  `Description_lang_unk3` text,
  `Description_lang_Flags` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_gem_properties

- 存储引擎: InnoDB
- 行数: 626

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Enchant_ID` | `int` | YES |  |  |  |
| `Maxcount_inv` | `int` | YES |  |  |  |
| `Maxcount_item` | `int` | YES |  |  |  |
| `Type` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_gem_properties` (
  `ID` int NOT NULL,
  `Enchant_ID` int DEFAULT NULL,
  `Maxcount_inv` int DEFAULT NULL,
  `Maxcount_item` int DEFAULT NULL,
  `Type` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_glyph_properties

- 存储引擎: InnoDB
- 行数: 362

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `SpellID` | `int` | YES |  |  |  |
| `GlyphSlotFlags` | `int` | YES |  |  |  |
| `SpellIconID` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_glyph_properties` (
  `ID` int NOT NULL,
  `SpellID` int DEFAULT NULL,
  `GlyphSlotFlags` int DEFAULT NULL,
  `SpellIconID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_item_display_info

- 存储引擎: InnoDB
- 行数: 55174

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `ModelName0` | `text` | YES |  |  |  |
| `ModelName1` | `text` | YES |  |  |  |
| `ModelTexture0` | `text` | YES |  |  |  |
| `ModelTexture1` | `text` | YES |  |  |  |
| `InventoryIcon0` | `text` | YES |  |  |  |
| `InventoryIcon1` | `text` | YES |  |  |  |
| `GeosetGroup0` | `int` | YES |  |  |  |
| `GeosetGroup1` | `int` | YES |  |  |  |
| `GeosetGroup2` | `int` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `SpellVisualID` | `int` | YES |  |  |  |
| `GroupSoundIndex` | `int` | YES |  |  |  |
| `HelmetGeosetVisID0` | `int` | YES |  |  |  |
| `HelmetGeosetVisID1` | `int` | YES |  |  |  |
| `Texture0` | `text` | YES |  |  |  |
| `Texture1` | `text` | YES |  |  |  |
| `Texture2` | `text` | YES |  |  |  |
| `Texture3` | `text` | YES |  |  |  |
| `Texture4` | `text` | YES |  |  |  |
| `Texture5` | `text` | YES |  |  |  |
| `Texture6` | `text` | YES |  |  |  |
| `Texture7` | `text` | YES |  |  |  |
| `ItemVisual` | `int` | YES |  |  |  |
| `ParticleColorID` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_item_display_info` (
  `ID` int NOT NULL,
  `ModelName0` text,
  `ModelName1` text,
  `ModelTexture0` text,
  `ModelTexture1` text,
  `InventoryIcon0` text,
  `InventoryIcon1` text,
  `GeosetGroup0` int DEFAULT NULL,
  `GeosetGroup1` int DEFAULT NULL,
  `GeosetGroup2` int DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `SpellVisualID` int DEFAULT NULL,
  `GroupSoundIndex` int DEFAULT NULL,
  `HelmetGeosetVisID0` int DEFAULT NULL,
  `HelmetGeosetVisID1` int DEFAULT NULL,
  `Texture0` text,
  `Texture1` text,
  `Texture2` text,
  `Texture3` text,
  `Texture4` text,
  `Texture5` text,
  `Texture6` text,
  `Texture7` text,
  `ItemVisual` int DEFAULT NULL,
  `ParticleColorID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_item_extended_cost

- 存储引擎: InnoDB
- 行数: 972

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `HonorPoints` | `int` | YES |  |  |  |
| `ArenaPoints` | `int` | YES |  |  |  |
| `ArenaBracket` | `int` | YES |  |  |  |
| `ItemID0` | `int` | YES |  |  |  |
| `ItemID1` | `int` | YES |  |  |  |
| `ItemID2` | `int` | YES |  |  |  |
| `ItemID3` | `int` | YES |  |  |  |
| `ItemID4` | `int` | YES |  |  |  |
| `ItemCount0` | `int` | YES |  |  |  |
| `ItemCount1` | `int` | YES |  |  |  |
| `ItemCount2` | `int` | YES |  |  |  |
| `ItemCount3` | `int` | YES |  |  |  |
| `ItemCount4` | `int` | YES |  |  |  |
| `RequiredArenaRating` | `int` | YES |  |  |  |
| `ItemPurchaseGroup` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_item_extended_cost` (
  `ID` int NOT NULL,
  `HonorPoints` int DEFAULT NULL,
  `ArenaPoints` int DEFAULT NULL,
  `ArenaBracket` int DEFAULT NULL,
  `ItemID0` int DEFAULT NULL,
  `ItemID1` int DEFAULT NULL,
  `ItemID2` int DEFAULT NULL,
  `ItemID3` int DEFAULT NULL,
  `ItemID4` int DEFAULT NULL,
  `ItemCount0` int DEFAULT NULL,
  `ItemCount1` int DEFAULT NULL,
  `ItemCount2` int DEFAULT NULL,
  `ItemCount3` int DEFAULT NULL,
  `ItemCount4` int DEFAULT NULL,
  `RequiredArenaRating` int DEFAULT NULL,
  `ItemPurchaseGroup` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_item_random_properties

- 存储引擎: InnoDB
- 行数: 2012

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Name` | `text` | YES |  |  |  |
| `Enchantment0` | `int` | YES |  |  |  |
| `Enchantment1` | `int` | YES |  |  |  |
| `Enchantment2` | `int` | YES |  |  |  |
| `Enchantment3` | `int` | YES |  |  |  |
| `Enchantment4` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_item_random_properties` (
  `ID` int NOT NULL,
  `Name` text,
  `Enchantment0` int DEFAULT NULL,
  `Enchantment1` int DEFAULT NULL,
  `Enchantment2` int DEFAULT NULL,
  `Enchantment3` int DEFAULT NULL,
  `Enchantment4` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_item_random_suffix

- 存储引擎: InnoDB
- 行数: 95

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `InternalName` | `text` | YES |  |  |  |
| `Enchantment0` | `int` | YES |  |  |  |
| `Enchantment1` | `int` | YES |  |  |  |
| `Enchantment2` | `int` | YES |  |  |  |
| `Enchantment3` | `int` | YES |  |  |  |
| `Enchantment4` | `int` | YES |  |  |  |
| `AllocationPct0` | `int` | YES |  |  |  |
| `AllocationPct1` | `int` | YES |  |  |  |
| `AllocationPct2` | `int` | YES |  |  |  |
| `AllocationPct3` | `int` | YES |  |  |  |
| `AllocationPct4` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_item_random_suffix` (
  `ID` int NOT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `InternalName` text,
  `Enchantment0` int DEFAULT NULL,
  `Enchantment1` int DEFAULT NULL,
  `Enchantment2` int DEFAULT NULL,
  `Enchantment3` int DEFAULT NULL,
  `Enchantment4` int DEFAULT NULL,
  `AllocationPct0` int DEFAULT NULL,
  `AllocationPct1` int DEFAULT NULL,
  `AllocationPct2` int DEFAULT NULL,
  `AllocationPct3` int DEFAULT NULL,
  `AllocationPct4` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_lock

- 存储引擎: InnoDB
- 行数: 388

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Type0` | `int` | YES |  |  |  |
| `Type1` | `int` | YES |  |  |  |
| `Type2` | `int` | YES |  |  |  |
| `Type3` | `int` | YES |  |  |  |
| `Type4` | `int` | YES |  |  |  |
| `Type5` | `int` | YES |  |  |  |
| `Type6` | `int` | YES |  |  |  |
| `Type7` | `int` | YES |  |  |  |
| `Index0` | `int` | YES |  |  |  |
| `Index1` | `int` | YES |  |  |  |
| `Index2` | `int` | YES |  |  |  |
| `Index3` | `int` | YES |  |  |  |
| `Index4` | `int` | YES |  |  |  |
| `Index5` | `int` | YES |  |  |  |
| `Index6` | `int` | YES |  |  |  |
| `Index7` | `int` | YES |  |  |  |
| `Skill0` | `int` | YES |  |  |  |
| `Skill1` | `int` | YES |  |  |  |
| `Skill2` | `int` | YES |  |  |  |
| `Skill3` | `int` | YES |  |  |  |
| `Skill4` | `int` | YES |  |  |  |
| `Skill5` | `int` | YES |  |  |  |
| `Skill6` | `int` | YES |  |  |  |
| `Skill7` | `int` | YES |  |  |  |
| `Action0` | `int` | YES |  |  |  |
| `Action1` | `int` | YES |  |  |  |
| `Action2` | `int` | YES |  |  |  |
| `Action3` | `int` | YES |  |  |  |
| `Action4` | `int` | YES |  |  |  |
| `Action5` | `int` | YES |  |  |  |
| `Action6` | `int` | YES |  |  |  |
| `Action7` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_lock` (
  `ID` int NOT NULL,
  `Type0` int DEFAULT NULL,
  `Type1` int DEFAULT NULL,
  `Type2` int DEFAULT NULL,
  `Type3` int DEFAULT NULL,
  `Type4` int DEFAULT NULL,
  `Type5` int DEFAULT NULL,
  `Type6` int DEFAULT NULL,
  `Type7` int DEFAULT NULL,
  `Index0` int DEFAULT NULL,
  `Index1` int DEFAULT NULL,
  `Index2` int DEFAULT NULL,
  `Index3` int DEFAULT NULL,
  `Index4` int DEFAULT NULL,
  `Index5` int DEFAULT NULL,
  `Index6` int DEFAULT NULL,
  `Index7` int DEFAULT NULL,
  `Skill0` int DEFAULT NULL,
  `Skill1` int DEFAULT NULL,
  `Skill2` int DEFAULT NULL,
  `Skill3` int DEFAULT NULL,
  `Skill4` int DEFAULT NULL,
  `Skill5` int DEFAULT NULL,
  `Skill6` int DEFAULT NULL,
  `Skill7` int DEFAULT NULL,
  `Action0` int DEFAULT NULL,
  `Action1` int DEFAULT NULL,
  `Action2` int DEFAULT NULL,
  `Action3` int DEFAULT NULL,
  `Action4` int DEFAULT NULL,
  `Action5` int DEFAULT NULL,
  `Action6` int DEFAULT NULL,
  `Action7` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_map

- 存储引擎: InnoDB
- 行数: 135

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Directory` | `text` | YES |  |  |  |
| `InstanceType` | `int` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `PVP` | `int` | YES |  |  |  |
| `MapName_lang_enUS` | `text` | YES |  |  |  |
| `MapName_lang_koKR` | `text` | YES |  |  |  |
| `MapName_lang_frFR` | `text` | YES |  |  |  |
| `MapName_lang_deDE` | `text` | YES |  |  |  |
| `MapName_lang_zhCN` | `text` | YES |  |  |  |
| `MapName_lang_zhTW` | `text` | YES |  |  |  |
| `MapName_lang_esES` | `text` | YES |  |  |  |
| `MapName_lang_esMX` | `text` | YES |  |  |  |
| `MapName_lang_ruRU` | `text` | YES |  |  |  |
| `MapName_lang_jaJP` | `text` | YES |  |  |  |
| `MapName_lang_ptPT` | `text` | YES |  |  |  |
| `MapName_lang_ptBR` | `text` | YES |  |  |  |
| `MapName_lang_itIT` | `text` | YES |  |  |  |
| `MapName_lang_unk1` | `text` | YES |  |  |  |
| `MapName_lang_unk2` | `text` | YES |  |  |  |
| `MapName_lang_unk3` | `text` | YES |  |  |  |
| `MapName_lang_Flags` | `int` | YES |  |  |  |
| `AreaTableID` | `int` | YES |  |  |  |
| `MapDescription0_lang_enUS` | `text` | YES |  |  |  |
| `MapDescription0_lang_koKR` | `text` | YES |  |  |  |
| `MapDescription0_lang_frFR` | `text` | YES |  |  |  |
| `MapDescription0_lang_deDE` | `text` | YES |  |  |  |
| `MapDescription0_lang_zhCN` | `text` | YES |  |  |  |
| `MapDescription0_lang_zhTW` | `text` | YES |  |  |  |
| `MapDescription0_lang_esES` | `text` | YES |  |  |  |
| `MapDescription0_lang_esMX` | `text` | YES |  |  |  |
| `MapDescription0_lang_ruRU` | `text` | YES |  |  |  |
| `MapDescription0_lang_jaJP` | `text` | YES |  |  |  |
| `MapDescription0_lang_ptPT` | `text` | YES |  |  |  |
| `MapDescription0_lang_ptBR` | `text` | YES |  |  |  |
| `MapDescription0_lang_itIT` | `text` | YES |  |  |  |
| `MapDescription0_lang_unk1` | `text` | YES |  |  |  |
| `MapDescription0_lang_unk2` | `text` | YES |  |  |  |
| `MapDescription0_lang_unk3` | `text` | YES |  |  |  |
| `MapDescription0_lang_Flags` | `int` | YES |  |  |  |
| `MapDescription1_lang_enUS` | `text` | YES |  |  |  |
| `MapDescription1_lang_koKR` | `text` | YES |  |  |  |
| `MapDescription1_lang_frFR` | `text` | YES |  |  |  |
| `MapDescription1_lang_deDE` | `text` | YES |  |  |  |
| `MapDescription1_lang_zhCN` | `text` | YES |  |  |  |
| `MapDescription1_lang_zhTW` | `text` | YES |  |  |  |
| `MapDescription1_lang_esES` | `text` | YES |  |  |  |
| `MapDescription1_lang_esMX` | `text` | YES |  |  |  |
| `MapDescription1_lang_ruRU` | `text` | YES |  |  |  |
| `MapDescription1_lang_jaJP` | `text` | YES |  |  |  |
| `MapDescription1_lang_ptPT` | `text` | YES |  |  |  |
| `MapDescription1_lang_ptBR` | `text` | YES |  |  |  |
| `MapDescription1_lang_itIT` | `text` | YES |  |  |  |
| `MapDescription1_lang_unk1` | `text` | YES |  |  |  |
| `MapDescription1_lang_unk2` | `text` | YES |  |  |  |
| `MapDescription1_lang_unk3` | `text` | YES |  |  |  |
| `MapDescription1_lang_Flags` | `int` | YES |  |  |  |
| `LoadingScreenID` | `int` | YES |  |  |  |
| `MinimapIconScale` | `float` | YES |  |  |  |
| `CorpseMapID` | `int` | YES |  |  |  |
| `Corpse0` | `float` | YES |  |  |  |
| `Corpse1` | `float` | YES |  |  |  |
| `TimeOfDayOverride` | `int` | YES |  |  |  |
| `ExpansionID` | `int` | YES |  |  |  |
| `RaidOffset` | `int` | YES |  |  |  |
| `MaxPlayers` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_map` (
  `ID` int NOT NULL,
  `Directory` text,
  `InstanceType` int DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `PVP` int DEFAULT NULL,
  `MapName_lang_enUS` text,
  `MapName_lang_koKR` text,
  `MapName_lang_frFR` text,
  `MapName_lang_deDE` text,
  `MapName_lang_zhCN` text,
  `MapName_lang_zhTW` text,
  `MapName_lang_esES` text,
  `MapName_lang_esMX` text,
  `MapName_lang_ruRU` text,
  `MapName_lang_jaJP` text,
  `MapName_lang_ptPT` text,
  `MapName_lang_ptBR` text,
  `MapName_lang_itIT` text,
  `MapName_lang_unk1` text,
  `MapName_lang_unk2` text,
  `MapName_lang_unk3` text,
  `MapName_lang_Flags` int DEFAULT NULL,
  `AreaTableID` int DEFAULT NULL,
  `MapDescription0_lang_enUS` text,
  `MapDescription0_lang_koKR` text,
  `MapDescription0_lang_frFR` text,
  `MapDescription0_lang_deDE` text,
  `MapDescription0_lang_zhCN` text,
  `MapDescription0_lang_zhTW` text,
  `MapDescription0_lang_esES` text,
  `MapDescription0_lang_esMX` text,
  `MapDescription0_lang_ruRU` text,
  `MapDescription0_lang_jaJP` text,
  `MapDescription0_lang_ptPT` text,
  `MapDescription0_lang_ptBR` text,
  `MapDescription0_lang_itIT` text,
  `MapDescription0_lang_unk1` text,
  `MapDescription0_lang_unk2` text,
  `MapDescription0_lang_unk3` text,
  `MapDescription0_lang_Flags` int DEFAULT NULL,
  `MapDescription1_lang_enUS` text,
  `MapDescription1_lang_koKR` text,
  `MapDescription1_lang_frFR` text,
  `MapDescription1_lang_deDE` text,
  `MapDescription1_lang_zhCN` text,
  `MapDescription1_lang_zhTW` text,
  `MapDescription1_lang_esES` text,
  `MapDescription1_lang_esMX` text,
  `MapDescription1_lang_ruRU` text,
  `MapDescription1_lang_jaJP` text,
  `MapDescription1_lang_ptPT` text,
  `MapDescription1_lang_ptBR` text,
  `MapDescription1_lang_itIT` text,
  `MapDescription1_lang_unk1` text,
  `MapDescription1_lang_unk2` text,
  `MapDescription1_lang_unk3` text,
  `MapDescription1_lang_Flags` int DEFAULT NULL,
  `LoadingScreenID` int DEFAULT NULL,
  `MinimapIconScale` float DEFAULT NULL,
  `CorpseMapID` int DEFAULT NULL,
  `Corpse0` float DEFAULT NULL,
  `Corpse1` float DEFAULT NULL,
  `TimeOfDayOverride` int DEFAULT NULL,
  `ExpansionID` int DEFAULT NULL,
  `RaidOffset` int DEFAULT NULL,
  `MaxPlayers` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_movie

- 存储引擎: InnoDB
- 行数: 4

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Filename` | `text` | YES |  |  |  |
| `Volume` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_movie` (
  `ID` int NOT NULL,
  `Filename` text,
  `Volume` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_movie_file_data

- 存储引擎: InnoDB
- 行数: 8

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `FileDataID` | `int` | NO |  |  |  |
| `Resolution` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_movie_file_data` (
  `FileDataID` int NOT NULL,
  `Resolution` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_quest_faction_reward

- 存储引擎: InnoDB
- 行数: 2

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Difficulty0` | `int` | YES |  |  |  |
| `Difficulty1` | `int` | YES |  |  |  |
| `Difficulty2` | `int` | YES |  |  |  |
| `Difficulty3` | `int` | YES |  |  |  |
| `Difficulty4` | `int` | YES |  |  |  |
| `Difficulty5` | `int` | YES |  |  |  |
| `Difficulty6` | `int` | YES |  |  |  |
| `Difficulty7` | `int` | YES |  |  |  |
| `Difficulty8` | `int` | YES |  |  |  |
| `Difficulty9` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_quest_faction_reward` (
  `ID` int NOT NULL,
  `Difficulty0` int DEFAULT NULL,
  `Difficulty1` int DEFAULT NULL,
  `Difficulty2` int DEFAULT NULL,
  `Difficulty3` int DEFAULT NULL,
  `Difficulty4` int DEFAULT NULL,
  `Difficulty5` int DEFAULT NULL,
  `Difficulty6` int DEFAULT NULL,
  `Difficulty7` int DEFAULT NULL,
  `Difficulty8` int DEFAULT NULL,
  `Difficulty9` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_scaling_stat_distribution

- 存储引擎: InnoDB
- 行数: 57

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `StatID0` | `int` | YES |  |  |  |
| `StatID1` | `int` | YES |  |  |  |
| `StatID2` | `int` | YES |  |  |  |
| `StatID3` | `int` | YES |  |  |  |
| `StatID4` | `int` | YES |  |  |  |
| `StatID5` | `int` | YES |  |  |  |
| `StatID6` | `int` | YES |  |  |  |
| `StatID7` | `int` | YES |  |  |  |
| `StatID8` | `int` | YES |  |  |  |
| `StatID9` | `int` | YES |  |  |  |
| `Bonus0` | `int` | YES |  |  |  |
| `Bonus1` | `int` | YES |  |  |  |
| `Bonus2` | `int` | YES |  |  |  |
| `Bonus3` | `int` | YES |  |  |  |
| `Bonus4` | `int` | YES |  |  |  |
| `Bonus5` | `int` | YES |  |  |  |
| `Bonus6` | `int` | YES |  |  |  |
| `Bonus7` | `int` | YES |  |  |  |
| `Bonus8` | `int` | YES |  |  |  |
| `Bonus9` | `int` | YES |  |  |  |
| `Maxlevel` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_scaling_stat_distribution` (
  `ID` int NOT NULL,
  `StatID0` int DEFAULT NULL,
  `StatID1` int DEFAULT NULL,
  `StatID2` int DEFAULT NULL,
  `StatID3` int DEFAULT NULL,
  `StatID4` int DEFAULT NULL,
  `StatID5` int DEFAULT NULL,
  `StatID6` int DEFAULT NULL,
  `StatID7` int DEFAULT NULL,
  `StatID8` int DEFAULT NULL,
  `StatID9` int DEFAULT NULL,
  `Bonus0` int DEFAULT NULL,
  `Bonus1` int DEFAULT NULL,
  `Bonus2` int DEFAULT NULL,
  `Bonus3` int DEFAULT NULL,
  `Bonus4` int DEFAULT NULL,
  `Bonus5` int DEFAULT NULL,
  `Bonus6` int DEFAULT NULL,
  `Bonus7` int DEFAULT NULL,
  `Bonus8` int DEFAULT NULL,
  `Bonus9` int DEFAULT NULL,
  `Maxlevel` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_skill_line

- 存储引擎: InnoDB
- 行数: 150

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `CategoryID` | `int` | YES |  |  |  |
| `SkillCostsID` | `int` | YES |  |  |  |
| `DisplayName_lang_enUS` | `text` | YES |  |  |  |
| `DisplayName_lang_koKR` | `text` | YES |  |  |  |
| `DisplayName_lang_frFR` | `text` | YES |  |  |  |
| `DisplayName_lang_deDE` | `text` | YES |  |  |  |
| `DisplayName_lang_zhCN` | `text` | YES |  |  |  |
| `DisplayName_lang_zhTW` | `text` | YES |  |  |  |
| `DisplayName_lang_esES` | `text` | YES |  |  |  |
| `DisplayName_lang_esMX` | `text` | YES |  |  |  |
| `DisplayName_lang_ruRU` | `text` | YES |  |  |  |
| `DisplayName_lang_jaJP` | `text` | YES |  |  |  |
| `DisplayName_lang_ptPT` | `text` | YES |  |  |  |
| `DisplayName_lang_ptBR` | `text` | YES |  |  |  |
| `DisplayName_lang_itIT` | `text` | YES |  |  |  |
| `DisplayName_lang_unk1` | `text` | YES |  |  |  |
| `DisplayName_lang_unk2` | `text` | YES |  |  |  |
| `DisplayName_lang_unk3` | `text` | YES |  |  |  |
| `DisplayName_lang_Flags` | `int` | YES |  |  |  |
| `Description_lang_enUS` | `text` | YES |  |  |  |
| `Description_lang_koKR` | `text` | YES |  |  |  |
| `Description_lang_frFR` | `text` | YES |  |  |  |
| `Description_lang_deDE` | `text` | YES |  |  |  |
| `Description_lang_zhCN` | `text` | YES |  |  |  |
| `Description_lang_zhTW` | `text` | YES |  |  |  |
| `Description_lang_esES` | `text` | YES |  |  |  |
| `Description_lang_esMX` | `text` | YES |  |  |  |
| `Description_lang_ruRU` | `text` | YES |  |  |  |
| `Description_lang_jaJP` | `text` | YES |  |  |  |
| `Description_lang_ptPT` | `text` | YES |  |  |  |
| `Description_lang_ptBR` | `text` | YES |  |  |  |
| `Description_lang_itIT` | `text` | YES |  |  |  |
| `Description_lang_unk1` | `text` | YES |  |  |  |
| `Description_lang_unk2` | `text` | YES |  |  |  |
| `Description_lang_unk3` | `text` | YES |  |  |  |
| `Description_lang_Flags` | `int` | YES |  |  |  |
| `SpellIconID` | `int` | YES |  |  |  |
| `AlternateVerb_lang_enUS` | `text` | YES |  |  |  |
| `AlternateVerb_lang_koKR` | `text` | YES |  |  |  |
| `AlternateVerb_lang_frFR` | `text` | YES |  |  |  |
| `AlternateVerb_lang_deDE` | `text` | YES |  |  |  |
| `AlternateVerb_lang_zhCN` | `text` | YES |  |  |  |
| `AlternateVerb_lang_zhTW` | `text` | YES |  |  |  |
| `AlternateVerb_lang_esES` | `text` | YES |  |  |  |
| `AlternateVerb_lang_esMX` | `text` | YES |  |  |  |
| `AlternateVerb_lang_ruRU` | `text` | YES |  |  |  |
| `AlternateVerb_lang_jaJP` | `text` | YES |  |  |  |
| `AlternateVerb_lang_ptPT` | `text` | YES |  |  |  |
| `AlternateVerb_lang_ptBR` | `text` | YES |  |  |  |
| `AlternateVerb_lang_itIT` | `text` | YES |  |  |  |
| `AlternateVerb_lang_unk1` | `text` | YES |  |  |  |
| `AlternateVerb_lang_unk2` | `text` | YES |  |  |  |
| `AlternateVerb_lang_unk3` | `text` | YES |  |  |  |
| `AlternateVerb_lang_Flags` | `int` | YES |  |  |  |
| `CanLink` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_skill_line` (
  `ID` int NOT NULL,
  `CategoryID` int DEFAULT NULL,
  `SkillCostsID` int DEFAULT NULL,
  `DisplayName_lang_enUS` text,
  `DisplayName_lang_koKR` text,
  `DisplayName_lang_frFR` text,
  `DisplayName_lang_deDE` text,
  `DisplayName_lang_zhCN` text,
  `DisplayName_lang_zhTW` text,
  `DisplayName_lang_esES` text,
  `DisplayName_lang_esMX` text,
  `DisplayName_lang_ruRU` text,
  `DisplayName_lang_jaJP` text,
  `DisplayName_lang_ptPT` text,
  `DisplayName_lang_ptBR` text,
  `DisplayName_lang_itIT` text,
  `DisplayName_lang_unk1` text,
  `DisplayName_lang_unk2` text,
  `DisplayName_lang_unk3` text,
  `DisplayName_lang_Flags` int DEFAULT NULL,
  `Description_lang_enUS` text,
  `Description_lang_koKR` text,
  `Description_lang_frFR` text,
  `Description_lang_deDE` text,
  `Description_lang_zhCN` text,
  `Description_lang_zhTW` text,
  `Description_lang_esES` text,
  `Description_lang_esMX` text,
  `Description_lang_ruRU` text,
  `Description_lang_jaJP` text,
  `Description_lang_ptPT` text,
  `Description_lang_ptBR` text,
  `Description_lang_itIT` text,
  `Description_lang_unk1` text,
  `Description_lang_unk2` text,
  `Description_lang_unk3` text,
  `Description_lang_Flags` int DEFAULT NULL,
  `SpellIconID` int DEFAULT NULL,
  `AlternateVerb_lang_enUS` text,
  `AlternateVerb_lang_koKR` text,
  `AlternateVerb_lang_frFR` text,
  `AlternateVerb_lang_deDE` text,
  `AlternateVerb_lang_zhCN` text,
  `AlternateVerb_lang_zhTW` text,
  `AlternateVerb_lang_esES` text,
  `AlternateVerb_lang_esMX` text,
  `AlternateVerb_lang_ruRU` text,
  `AlternateVerb_lang_jaJP` text,
  `AlternateVerb_lang_ptPT` text,
  `AlternateVerb_lang_ptBR` text,
  `AlternateVerb_lang_itIT` text,
  `AlternateVerb_lang_unk1` text,
  `AlternateVerb_lang_unk2` text,
  `AlternateVerb_lang_unk3` text,
  `AlternateVerb_lang_Flags` int DEFAULT NULL,
  `CanLink` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_skill_line_ability

- 存储引擎: InnoDB
- 行数: 10431

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `SkillLine` | `int` | YES |  |  |  |
| `Spell` | `int` | YES |  |  |  |
| `RaceMask` | `int` | YES |  |  |  |
| `ClassMask` | `int` | YES |  |  |  |
| `ExcludeRace` | `int` | YES |  |  |  |
| `ExcludeClass` | `int` | YES |  |  |  |
| `MinSkillLineRank` | `int` | YES |  |  |  |
| `SupercededBySpell` | `int` | YES |  |  |  |
| `AcquireMethod` | `int` | YES |  |  |  |
| `TrivialSkillLineRankHigh` | `int` | YES |  |  |  |
| `TrivialSkillLineRankLow` | `int` | YES |  |  |  |
| `CharacterPoints0` | `int` | YES |  |  |  |
| `CharacterPoints1` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_skill_line_ability` (
  `ID` int NOT NULL,
  `SkillLine` int DEFAULT NULL,
  `Spell` int DEFAULT NULL,
  `RaceMask` int DEFAULT NULL,
  `ClassMask` int DEFAULT NULL,
  `ExcludeRace` int DEFAULT NULL,
  `ExcludeClass` int DEFAULT NULL,
  `MinSkillLineRank` int DEFAULT NULL,
  `SupercededBySpell` int DEFAULT NULL,
  `AcquireMethod` int DEFAULT NULL,
  `TrivialSkillLineRankHigh` int DEFAULT NULL,
  `TrivialSkillLineRankLow` int DEFAULT NULL,
  `CharacterPoints0` int DEFAULT NULL,
  `CharacterPoints1` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_spell

- 存储引擎: InnoDB
- 行数: 46370

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Category` | `int` | YES |  |  |  |
| `DispelType` | `int` | YES |  |  |  |
| `Mechanic` | `int` | YES |  |  |  |
| `Attributes` | `int` | YES |  |  |  |
| `AttributesEx` | `int` | YES |  |  |  |
| `AttributesExB` | `int` | YES |  |  |  |
| `AttributesExC` | `int` | YES |  |  |  |
| `AttributesExD` | `int` | YES |  |  |  |
| `AttributesExE` | `int` | YES |  |  |  |
| `AttributesExF` | `int` | YES |  |  |  |
| `AttributesExG` | `int` | YES |  |  |  |
| `ShapeshiftMask0` | `int` | YES |  |  |  |
| `ShapeshiftMask1` | `int` | YES |  |  |  |
| `ShapeshiftExclude0` | `int` | YES |  |  |  |
| `ShapeshiftExclude1` | `int` | YES |  |  |  |
| `Targets` | `int` | YES |  |  |  |
| `TargetCreatureType` | `int` | YES |  |  |  |
| `RequiresSpellFocus` | `int` | YES |  |  |  |
| `FacingCasterFlags` | `int` | YES |  |  |  |
| `CasterAuraState` | `int` | YES |  |  |  |
| `TargetAuraState` | `int` | YES |  |  |  |
| `ExcludeCasterAuraState` | `int` | YES |  |  |  |
| `ExcludeTargetAuraState` | `int` | YES |  |  |  |
| `CasterAuraSpell` | `int` | YES |  |  |  |
| `TargetAuraSpell` | `int` | YES |  |  |  |
| `ExcludeCasterAuraSpell` | `int` | YES |  |  |  |
| `ExcludeTargetAuraSpell` | `int` | YES |  |  |  |
| `CastingTimeIndex` | `int` | YES |  |  |  |
| `RecoveryTime` | `int` | YES |  |  |  |
| `CategoryRecoveryTime` | `int` | YES |  |  |  |
| `InterruptFlags` | `int` | YES |  |  |  |
| `AuraInterruptFlags` | `int` | YES |  |  |  |
| `ChannelInterruptFlags` | `int` | YES |  |  |  |
| `ProcTypeMask` | `int` | YES |  |  |  |
| `ProcChance` | `int` | YES |  |  |  |
| `ProcCharges` | `int` | YES |  |  |  |
| `MaxLevel` | `int` | YES |  |  |  |
| `BaseLevel` | `int` | YES |  |  |  |
| `SpellLevel` | `int` | YES |  |  |  |
| `DurationIndex` | `int` | YES |  |  |  |
| `PowerType` | `int` | YES |  |  |  |
| `ManaCost` | `int` | YES |  |  |  |
| `ManaCostPerLevel` | `int` | YES |  |  |  |
| `ManaPerSecond` | `int` | YES |  |  |  |
| `ManaPerSecondPerLevel` | `int` | YES |  |  |  |
| `RangeIndex` | `int` | YES |  |  |  |
| `Speed` | `float` | YES |  |  |  |
| `ModalNextSpell` | `int` | YES |  |  |  |
| `CumulativeAura` | `int` | YES |  |  |  |
| `Totem0` | `int` | YES |  |  |  |
| `Totem1` | `int` | YES |  |  |  |
| `Reagent0` | `int` | YES |  |  |  |
| `Reagent1` | `int` | YES |  |  |  |
| `Reagent2` | `int` | YES |  |  |  |
| `Reagent3` | `int` | YES |  |  |  |
| `Reagent4` | `int` | YES |  |  |  |
| `Reagent5` | `int` | YES |  |  |  |
| `Reagent6` | `int` | YES |  |  |  |
| `Reagent7` | `int` | YES |  |  |  |
| `ReagentCount0` | `int` | YES |  |  |  |
| `ReagentCount1` | `int` | YES |  |  |  |
| `ReagentCount2` | `int` | YES |  |  |  |
| `ReagentCount3` | `int` | YES |  |  |  |
| `ReagentCount4` | `int` | YES |  |  |  |
| `ReagentCount5` | `int` | YES |  |  |  |
| `ReagentCount6` | `int` | YES |  |  |  |
| `ReagentCount7` | `int` | YES |  |  |  |
| `EquippedItemClass` | `int` | YES |  |  |  |
| `EquippedItemSubclass` | `int` | YES |  |  |  |
| `EquippedItemInvTypes` | `int` | YES |  |  |  |
| `Effect0` | `int` | YES |  |  |  |
| `Effect1` | `int` | YES |  |  |  |
| `Effect2` | `int` | YES |  |  |  |
| `EffectDieSides0` | `int` | YES |  |  |  |
| `EffectDieSides1` | `int` | YES |  |  |  |
| `EffectDieSides2` | `int` | YES |  |  |  |
| `EffectRealPointsPerLevel0` | `float` | YES |  |  |  |
| `EffectRealPointsPerLevel1` | `float` | YES |  |  |  |
| `EffectRealPointsPerLevel2` | `float` | YES |  |  |  |
| `EffectBasePoints0` | `int` | YES |  |  |  |
| `EffectBasePoints1` | `int` | YES |  |  |  |
| `EffectBasePoints2` | `int` | YES |  |  |  |
| `EffectMechanic0` | `int` | YES |  |  |  |
| `EffectMechanic1` | `int` | YES |  |  |  |
| `EffectMechanic2` | `int` | YES |  |  |  |
| `ImplicitTargetA0` | `int` | YES |  |  |  |
| `ImplicitTargetA1` | `int` | YES |  |  |  |
| `ImplicitTargetA2` | `int` | YES |  |  |  |
| `ImplicitTargetB0` | `int` | YES |  |  |  |
| `ImplicitTargetB1` | `int` | YES |  |  |  |
| `ImplicitTargetB2` | `int` | YES |  |  |  |
| `EffectRadiusIndex0` | `int` | YES |  |  |  |
| `EffectRadiusIndex1` | `int` | YES |  |  |  |
| `EffectRadiusIndex2` | `int` | YES |  |  |  |
| `EffectAura0` | `int` | YES |  |  |  |
| `EffectAura1` | `int` | YES |  |  |  |
| `EffectAura2` | `int` | YES |  |  |  |
| `EffectAuraPeriod0` | `int` | YES |  |  |  |
| `EffectAuraPeriod1` | `int` | YES |  |  |  |
| `EffectAuraPeriod2` | `int` | YES |  |  |  |
| `EffectAmplitude0` | `float` | YES |  |  |  |
| `EffectAmplitude1` | `float` | YES |  |  |  |
| `EffectAmplitude2` | `float` | YES |  |  |  |
| `EffectChainTargets0` | `int` | YES |  |  |  |
| `EffectChainTargets1` | `int` | YES |  |  |  |
| `EffectChainTargets2` | `int` | YES |  |  |  |
| `EffectItemType0` | `int` | YES |  |  |  |
| `EffectItemType1` | `int` | YES |  |  |  |
| `EffectItemType2` | `int` | YES |  |  |  |
| `EffectMiscValue0` | `int` | YES |  |  |  |
| `EffectMiscValue1` | `int` | YES |  |  |  |
| `EffectMiscValue2` | `int` | YES |  |  |  |
| `EffectMiscValueB0` | `int` | YES |  |  |  |
| `EffectMiscValueB1` | `int` | YES |  |  |  |
| `EffectMiscValueB2` | `int` | YES |  |  |  |
| `EffectTriggerSpell0` | `int` | YES |  |  |  |
| `EffectTriggerSpell1` | `int` | YES |  |  |  |
| `EffectTriggerSpell2` | `int` | YES |  |  |  |
| `EffectPointsPerCombo0` | `float` | YES |  |  |  |
| `EffectPointsPerCombo1` | `float` | YES |  |  |  |
| `EffectPointsPerCombo2` | `float` | YES |  |  |  |
| `EffectSpellClassMaskA0` | `int` | YES |  |  |  |
| `EffectSpellClassMaskA1` | `int` | YES |  |  |  |
| `EffectSpellClassMaskA2` | `int` | YES |  |  |  |
| `EffectSpellClassMaskB0` | `int` | YES |  |  |  |
| `EffectSpellClassMaskB1` | `int` | YES |  |  |  |
| `EffectSpellClassMaskB2` | `int` | YES |  |  |  |
| `EffectSpellClassMaskC0` | `int` | YES |  |  |  |
| `EffectSpellClassMaskC1` | `int` | YES |  |  |  |
| `EffectSpellClassMaskC2` | `int` | YES |  |  |  |
| `SpellVisualID0` | `int` | YES |  |  |  |
| `SpellVisualID1` | `int` | YES |  |  |  |
| `SpellIconID` | `int` | YES |  |  |  |
| `ActiveIconID` | `int` | YES |  |  |  |
| `SpellPriority` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `NameSubtext_lang_enUS` | `text` | YES |  |  |  |
| `NameSubtext_lang_koKR` | `text` | YES |  |  |  |
| `NameSubtext_lang_frFR` | `text` | YES |  |  |  |
| `NameSubtext_lang_deDE` | `text` | YES |  |  |  |
| `NameSubtext_lang_zhCN` | `text` | YES |  |  |  |
| `NameSubtext_lang_zhTW` | `text` | YES |  |  |  |
| `NameSubtext_lang_esES` | `text` | YES |  |  |  |
| `NameSubtext_lang_esMX` | `text` | YES |  |  |  |
| `NameSubtext_lang_ruRU` | `text` | YES |  |  |  |
| `NameSubtext_lang_jaJP` | `text` | YES |  |  |  |
| `NameSubtext_lang_ptPT` | `text` | YES |  |  |  |
| `NameSubtext_lang_ptBR` | `text` | YES |  |  |  |
| `NameSubtext_lang_itIT` | `text` | YES |  |  |  |
| `NameSubtext_lang_unk1` | `text` | YES |  |  |  |
| `NameSubtext_lang_unk2` | `text` | YES |  |  |  |
| `NameSubtext_lang_unk3` | `text` | YES |  |  |  |
| `NameSubtext_lang_Flags` | `int` | YES |  |  |  |
| `Description_lang_enUS` | `text` | YES |  |  |  |
| `Description_lang_koKR` | `text` | YES |  |  |  |
| `Description_lang_frFR` | `text` | YES |  |  |  |
| `Description_lang_deDE` | `text` | YES |  |  |  |
| `Description_lang_zhCN` | `text` | YES |  |  |  |
| `Description_lang_zhTW` | `text` | YES |  |  |  |
| `Description_lang_esES` | `text` | YES |  |  |  |
| `Description_lang_esMX` | `text` | YES |  |  |  |
| `Description_lang_ruRU` | `text` | YES |  |  |  |
| `Description_lang_jaJP` | `text` | YES |  |  |  |
| `Description_lang_ptPT` | `text` | YES |  |  |  |
| `Description_lang_ptBR` | `text` | YES |  |  |  |
| `Description_lang_itIT` | `text` | YES |  |  |  |
| `Description_lang_unk1` | `text` | YES |  |  |  |
| `Description_lang_unk2` | `text` | YES |  |  |  |
| `Description_lang_unk3` | `text` | YES |  |  |  |
| `Description_lang_Flags` | `int` | YES |  |  |  |
| `AuraDescription_lang_enUS` | `text` | YES |  |  |  |
| `AuraDescription_lang_koKR` | `text` | YES |  |  |  |
| `AuraDescription_lang_frFR` | `text` | YES |  |  |  |
| `AuraDescription_lang_deDE` | `text` | YES |  |  |  |
| `AuraDescription_lang_zhCN` | `text` | YES |  |  |  |
| `AuraDescription_lang_zhTW` | `text` | YES |  |  |  |
| `AuraDescription_lang_esES` | `text` | YES |  |  |  |
| `AuraDescription_lang_esMX` | `text` | YES |  |  |  |
| `AuraDescription_lang_ruRU` | `text` | YES |  |  |  |
| `AuraDescription_lang_jaJP` | `text` | YES |  |  |  |
| `AuraDescription_lang_ptPT` | `text` | YES |  |  |  |
| `AuraDescription_lang_ptBR` | `text` | YES |  |  |  |
| `AuraDescription_lang_itIT` | `text` | YES |  |  |  |
| `AuraDescription_lang_unk1` | `text` | YES |  |  |  |
| `AuraDescription_lang_unk2` | `text` | YES |  |  |  |
| `AuraDescription_lang_unk3` | `text` | YES |  |  |  |
| `AuraDescription_lang_Flags` | `int` | YES |  |  |  |
| `ManaCostPct` | `int` | YES |  |  |  |
| `StartRecoveryCategory` | `int` | YES |  |  |  |
| `StartRecoveryTime` | `int` | YES |  |  |  |
| `MaxTargetLevel` | `int` | YES |  |  |  |
| `SpellClassSet` | `int` | YES |  |  |  |
| `SpellClassMask0` | `int` | YES |  |  |  |
| `SpellClassMask1` | `int` | YES |  |  |  |
| `SpellClassMask2` | `int` | YES |  |  |  |
| `MaxTargets` | `int` | YES |  |  |  |
| `DefenseType` | `int` | YES |  |  |  |
| `PreventionType` | `int` | YES |  |  |  |
| `StanceBarOrder` | `int` | YES |  |  |  |
| `EffectChainAmplitude0` | `float` | YES |  |  |  |
| `EffectChainAmplitude1` | `float` | YES |  |  |  |
| `EffectChainAmplitude2` | `float` | YES |  |  |  |
| `MinFactionID` | `int` | YES |  |  |  |
| `MinReputation` | `int` | YES |  |  |  |
| `RequiredAuraVision` | `int` | YES |  |  |  |
| `RequiredTotemCategoryID0` | `int` | YES |  |  |  |
| `RequiredTotemCategoryID1` | `int` | YES |  |  |  |
| `RequiredAreasID` | `int` | YES |  |  |  |
| `SchoolMask` | `int` | YES |  |  |  |
| `RuneCostID` | `int` | YES |  |  |  |
| `SpellMissileID` | `int` | YES |  |  |  |
| `PowerDisplayID` | `int` | YES |  |  |  |
| `EffectBonusCoefficient0` | `float` | YES |  |  |  |
| `EffectBonusCoefficient1` | `float` | YES |  |  |  |
| `EffectBonusCoefficient2` | `float` | YES |  |  |  |
| `DescriptionVariablesID` | `int` | YES |  |  |  |
| `Difficulty` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_spell` (
  `ID` int NOT NULL,
  `Category` int DEFAULT NULL,
  `DispelType` int DEFAULT NULL,
  `Mechanic` int DEFAULT NULL,
  `Attributes` int DEFAULT NULL,
  `AttributesEx` int DEFAULT NULL,
  `AttributesExB` int DEFAULT NULL,
  `AttributesExC` int DEFAULT NULL,
  `AttributesExD` int DEFAULT NULL,
  `AttributesExE` int DEFAULT NULL,
  `AttributesExF` int DEFAULT NULL,
  `AttributesExG` int DEFAULT NULL,
  `ShapeshiftMask0` int DEFAULT NULL,
  `ShapeshiftMask1` int DEFAULT NULL,
  `ShapeshiftExclude0` int DEFAULT NULL,
  `ShapeshiftExclude1` int DEFAULT NULL,
  `Targets` int DEFAULT NULL,
  `TargetCreatureType` int DEFAULT NULL,
  `RequiresSpellFocus` int DEFAULT NULL,
  `FacingCasterFlags` int DEFAULT NULL,
  `CasterAuraState` int DEFAULT NULL,
  `TargetAuraState` int DEFAULT NULL,
  `ExcludeCasterAuraState` int DEFAULT NULL,
  `ExcludeTargetAuraState` int DEFAULT NULL,
  `CasterAuraSpell` int DEFAULT NULL,
  `TargetAuraSpell` int DEFAULT NULL,
  `ExcludeCasterAuraSpell` int DEFAULT NULL,
  `ExcludeTargetAuraSpell` int DEFAULT NULL,
  `CastingTimeIndex` int DEFAULT NULL,
  `RecoveryTime` int DEFAULT NULL,
  `CategoryRecoveryTime` int DEFAULT NULL,
  `InterruptFlags` int DEFAULT NULL,
  `AuraInterruptFlags` int DEFAULT NULL,
  `ChannelInterruptFlags` int DEFAULT NULL,
  `ProcTypeMask` int DEFAULT NULL,
  `ProcChance` int DEFAULT NULL,
  `ProcCharges` int DEFAULT NULL,
  `MaxLevel` int DEFAULT NULL,
  `BaseLevel` int DEFAULT NULL,
  `SpellLevel` int DEFAULT NULL,
  `DurationIndex` int DEFAULT NULL,
  `PowerType` int DEFAULT NULL,
  `ManaCost` int DEFAULT NULL,
  `ManaCostPerLevel` int DEFAULT NULL,
  `ManaPerSecond` int DEFAULT NULL,
  `ManaPerSecondPerLevel` int DEFAULT NULL,
  `RangeIndex` int DEFAULT NULL,
  `Speed` float DEFAULT NULL,
  `ModalNextSpell` int DEFAULT NULL,
  `CumulativeAura` int DEFAULT NULL,
  `Totem0` int DEFAULT NULL,
  `Totem1` int DEFAULT NULL,
  `Reagent0` int DEFAULT NULL,
  `Reagent1` int DEFAULT NULL,
  `Reagent2` int DEFAULT NULL,
  `Reagent3` int DEFAULT NULL,
  `Reagent4` int DEFAULT NULL,
  `Reagent5` int DEFAULT NULL,
  `Reagent6` int DEFAULT NULL,
  `Reagent7` int DEFAULT NULL,
  `ReagentCount0` int DEFAULT NULL,
  `ReagentCount1` int DEFAULT NULL,
  `ReagentCount2` int DEFAULT NULL,
  `ReagentCount3` int DEFAULT NULL,
  `ReagentCount4` int DEFAULT NULL,
  `ReagentCount5` int DEFAULT NULL,
  `ReagentCount6` int DEFAULT NULL,
  `ReagentCount7` int DEFAULT NULL,
  `EquippedItemClass` int DEFAULT NULL,
  `EquippedItemSubclass` int DEFAULT NULL,
  `EquippedItemInvTypes` int DEFAULT NULL,
  `Effect0` int DEFAULT NULL,
  `Effect1` int DEFAULT NULL,
  `Effect2` int DEFAULT NULL,
  `EffectDieSides0` int DEFAULT NULL,
  `EffectDieSides1` int DEFAULT NULL,
  `EffectDieSides2` int DEFAULT NULL,
  `EffectRealPointsPerLevel0` float DEFAULT NULL,
  `EffectRealPointsPerLevel1` float DEFAULT NULL,
  `EffectRealPointsPerLevel2` float DEFAULT NULL,
  `EffectBasePoints0` int DEFAULT NULL,
  `EffectBasePoints1` int DEFAULT NULL,
  `EffectBasePoints2` int DEFAULT NULL,
  `EffectMechanic0` int DEFAULT NULL,
  `EffectMechanic1` int DEFAULT NULL,
  `EffectMechanic2` int DEFAULT NULL,
  `ImplicitTargetA0` int DEFAULT NULL,
  `ImplicitTargetA1` int DEFAULT NULL,
  `ImplicitTargetA2` int DEFAULT NULL,
  `ImplicitTargetB0` int DEFAULT NULL,
  `ImplicitTargetB1` int DEFAULT NULL,
  `ImplicitTargetB2` int DEFAULT NULL,
  `EffectRadiusIndex0` int DEFAULT NULL,
  `EffectRadiusIndex1` int DEFAULT NULL,
  `EffectRadiusIndex2` int DEFAULT NULL,
  `EffectAura0` int DEFAULT NULL,
  `EffectAura1` int DEFAULT NULL,
  `EffectAura2` int DEFAULT NULL,
  `EffectAuraPeriod0` int DEFAULT NULL,
  `EffectAuraPeriod1` int DEFAULT NULL,
  `EffectAuraPeriod2` int DEFAULT NULL,
  `EffectAmplitude0` float DEFAULT NULL,
  `EffectAmplitude1` float DEFAULT NULL,
  `EffectAmplitude2` float DEFAULT NULL,
  `EffectChainTargets0` int DEFAULT NULL,
  `EffectChainTargets1` int DEFAULT NULL,
  `EffectChainTargets2` int DEFAULT NULL,
  `EffectItemType0` int DEFAULT NULL,
  `EffectItemType1` int DEFAULT NULL,
  `EffectItemType2` int DEFAULT NULL,
  `EffectMiscValue0` int DEFAULT NULL,
  `EffectMiscValue1` int DEFAULT NULL,
  `EffectMiscValue2` int DEFAULT NULL,
  `EffectMiscValueB0` int DEFAULT NULL,
  `EffectMiscValueB1` int DEFAULT NULL,
  `EffectMiscValueB2` int DEFAULT NULL,
  `EffectTriggerSpell0` int DEFAULT NULL,
  `EffectTriggerSpell1` int DEFAULT NULL,
  `EffectTriggerSpell2` int DEFAULT NULL,
  `EffectPointsPerCombo0` float DEFAULT NULL,
  `EffectPointsPerCombo1` float DEFAULT NULL,
  `EffectPointsPerCombo2` float DEFAULT NULL,
  `EffectSpellClassMaskA0` int DEFAULT NULL,
  `EffectSpellClassMaskA1` int DEFAULT NULL,
  `EffectSpellClassMaskA2` int DEFAULT NULL,
  `EffectSpellClassMaskB0` int DEFAULT NULL,
  `EffectSpellClassMaskB1` int DEFAULT NULL,
  `EffectSpellClassMaskB2` int DEFAULT NULL,
  `EffectSpellClassMaskC0` int DEFAULT NULL,
  `EffectSpellClassMaskC1` int DEFAULT NULL,
  `EffectSpellClassMaskC2` int DEFAULT NULL,
  `SpellVisualID0` int DEFAULT NULL,
  `SpellVisualID1` int DEFAULT NULL,
  `SpellIconID` int DEFAULT NULL,
  `ActiveIconID` int DEFAULT NULL,
  `SpellPriority` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `NameSubtext_lang_enUS` text,
  `NameSubtext_lang_koKR` text,
  `NameSubtext_lang_frFR` text,
  `NameSubtext_lang_deDE` text,
  `NameSubtext_lang_zhCN` text,
  `NameSubtext_lang_zhTW` text,
  `NameSubtext_lang_esES` text,
  `NameSubtext_lang_esMX` text,
  `NameSubtext_lang_ruRU` text,
  `NameSubtext_lang_jaJP` text,
  `NameSubtext_lang_ptPT` text,
  `NameSubtext_lang_ptBR` text,
  `NameSubtext_lang_itIT` text,
  `NameSubtext_lang_unk1` text,
  `NameSubtext_lang_unk2` text,
  `NameSubtext_lang_unk3` text,
  `NameSubtext_lang_Flags` int DEFAULT NULL,
  `Description_lang_enUS` text,
  `Description_lang_koKR` text,
  `Description_lang_frFR` text,
  `Description_lang_deDE` text,
  `Description_lang_zhCN` text,
  `Description_lang_zhTW` text,
  `Description_lang_esES` text,
  `Description_lang_esMX` text,
  `Description_lang_ruRU` text,
  `Description_lang_jaJP` text,
  `Description_lang_ptPT` text,
  `Description_lang_ptBR` text,
  `Description_lang_itIT` text,
  `Description_lang_unk1` text,
  `Description_lang_unk2` text,
  `Description_lang_unk3` text,
  `Description_lang_Flags` int DEFAULT NULL,
  `AuraDescription_lang_enUS` text,
  `AuraDescription_lang_koKR` text,
  `AuraDescription_lang_frFR` text,
  `AuraDescription_lang_deDE` text,
  `AuraDescription_lang_zhCN` text,
  `AuraDescription_lang_zhTW` text,
  `AuraDescription_lang_esES` text,
  `AuraDescription_lang_esMX` text,
  `AuraDescription_lang_ruRU` text,
  `AuraDescription_lang_jaJP` text,
  `AuraDescription_lang_ptPT` text,
  `AuraDescription_lang_ptBR` text,
  `AuraDescription_lang_itIT` text,
  `AuraDescription_lang_unk1` text,
  `AuraDescription_lang_unk2` text,
  `AuraDescription_lang_unk3` text,
  `AuraDescription_lang_Flags` int DEFAULT NULL,
  `ManaCostPct` int DEFAULT NULL,
  `StartRecoveryCategory` int DEFAULT NULL,
  `StartRecoveryTime` int DEFAULT NULL,
  `MaxTargetLevel` int DEFAULT NULL,
  `SpellClassSet` int DEFAULT NULL,
  `SpellClassMask0` int DEFAULT NULL,
  `SpellClassMask1` int DEFAULT NULL,
  `SpellClassMask2` int DEFAULT NULL,
  `MaxTargets` int DEFAULT NULL,
  `DefenseType` int DEFAULT NULL,
  `PreventionType` int DEFAULT NULL,
  `StanceBarOrder` int DEFAULT NULL,
  `EffectChainAmplitude0` float DEFAULT NULL,
  `EffectChainAmplitude1` float DEFAULT NULL,
  `EffectChainAmplitude2` float DEFAULT NULL,
  `MinFactionID` int DEFAULT NULL,
  `MinReputation` int DEFAULT NULL,
  `RequiredAuraVision` int DEFAULT NULL,
  `RequiredTotemCategoryID0` int DEFAULT NULL,
  `RequiredTotemCategoryID1` int DEFAULT NULL,
  `RequiredAreasID` int DEFAULT NULL,
  `SchoolMask` int DEFAULT NULL,
  `RuneCostID` int DEFAULT NULL,
  `SpellMissileID` int DEFAULT NULL,
  `PowerDisplayID` int DEFAULT NULL,
  `EffectBonusCoefficient0` float DEFAULT NULL,
  `EffectBonusCoefficient1` float DEFAULT NULL,
  `EffectBonusCoefficient2` float DEFAULT NULL,
  `DescriptionVariablesID` int DEFAULT NULL,
  `Difficulty` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_spell_duration

- 存储引擎: InnoDB
- 行数: 130

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Duration` | `int` | YES |  |  |  |
| `DurationPerLevel` | `int` | YES |  |  |  |
| `MaxDuration` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_spell_duration` (
  `ID` int NOT NULL,
  `Duration` int DEFAULT NULL,
  `DurationPerLevel` int DEFAULT NULL,
  `MaxDuration` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_spell_icon

- 存储引擎: InnoDB
- 行数: 3226

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `TextureFilename` | `text` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_spell_icon` (
  `ID` int NOT NULL,
  `TextureFilename` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_spell_item_enchantment

- 存储引擎: InnoDB
- 行数: 2657

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Charges` | `int` | YES |  |  |  |
| `Effect0` | `int` | YES |  |  |  |
| `Effect1` | `int` | YES |  |  |  |
| `Effect2` | `int` | YES |  |  |  |
| `EffectPointsMin0` | `int` | YES |  |  |  |
| `EffectPointsMin1` | `int` | YES |  |  |  |
| `EffectPointsMin2` | `int` | YES |  |  |  |
| `EffectPointsMax0` | `int` | YES |  |  |  |
| `EffectPointsMax1` | `int` | YES |  |  |  |
| `EffectPointsMax2` | `int` | YES |  |  |  |
| `EffectArg0` | `int` | YES |  |  |  |
| `EffectArg1` | `int` | YES |  |  |  |
| `EffectArg2` | `int` | YES |  |  |  |
| `Name_lang_enUS` | `text` | YES |  |  |  |
| `Name_lang_koKR` | `text` | YES |  |  |  |
| `Name_lang_frFR` | `text` | YES |  |  |  |
| `Name_lang_deDE` | `text` | YES |  |  |  |
| `Name_lang_zhCN` | `text` | YES |  |  |  |
| `Name_lang_zhTW` | `text` | YES |  |  |  |
| `Name_lang_esES` | `text` | YES |  |  |  |
| `Name_lang_esMX` | `text` | YES |  |  |  |
| `Name_lang_ruRU` | `text` | YES |  |  |  |
| `Name_lang_jaJP` | `text` | YES |  |  |  |
| `Name_lang_ptPT` | `text` | YES |  |  |  |
| `Name_lang_ptBR` | `text` | YES |  |  |  |
| `Name_lang_itIT` | `text` | YES |  |  |  |
| `Name_lang_unk1` | `text` | YES |  |  |  |
| `Name_lang_unk2` | `text` | YES |  |  |  |
| `Name_lang_unk3` | `text` | YES |  |  |  |
| `Name_lang_Flags` | `int` | YES |  |  |  |
| `ItemVisual` | `int` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `Src_itemID` | `int` | YES |  |  |  |
| `Condition_ID` | `int` | YES |  |  |  |
| `RequiredSkillID` | `int` | YES |  |  |  |
| `RequiredSkillRank` | `int` | YES |  |  |  |
| `MinLevel` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_spell_item_enchantment` (
  `ID` int NOT NULL,
  `Charges` int DEFAULT NULL,
  `Effect0` int DEFAULT NULL,
  `Effect1` int DEFAULT NULL,
  `Effect2` int DEFAULT NULL,
  `EffectPointsMin0` int DEFAULT NULL,
  `EffectPointsMin1` int DEFAULT NULL,
  `EffectPointsMin2` int DEFAULT NULL,
  `EffectPointsMax0` int DEFAULT NULL,
  `EffectPointsMax1` int DEFAULT NULL,
  `EffectPointsMax2` int DEFAULT NULL,
  `EffectArg0` int DEFAULT NULL,
  `EffectArg1` int DEFAULT NULL,
  `EffectArg2` int DEFAULT NULL,
  `Name_lang_enUS` text,
  `Name_lang_koKR` text,
  `Name_lang_frFR` text,
  `Name_lang_deDE` text,
  `Name_lang_zhCN` text,
  `Name_lang_zhTW` text,
  `Name_lang_esES` text,
  `Name_lang_esMX` text,
  `Name_lang_ruRU` text,
  `Name_lang_jaJP` text,
  `Name_lang_ptPT` text,
  `Name_lang_ptBR` text,
  `Name_lang_itIT` text,
  `Name_lang_unk1` text,
  `Name_lang_unk2` text,
  `Name_lang_unk3` text,
  `Name_lang_Flags` int DEFAULT NULL,
  `ItemVisual` int DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `Src_itemID` int DEFAULT NULL,
  `Condition_ID` int DEFAULT NULL,
  `RequiredSkillID` int DEFAULT NULL,
  `RequiredSkillRank` int DEFAULT NULL,
  `MinLevel` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_spell_radius

- 存储引擎: InnoDB
- 行数: 58

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Radius` | `float` | YES |  |  |  |
| `RadiusPerLevel` | `float` | YES |  |  |  |
| `RadiusMax` | `float` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_spell_radius` (
  `ID` int NOT NULL,
  `Radius` float DEFAULT NULL,
  `RadiusPerLevel` float DEFAULT NULL,
  `RadiusMax` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_spell_range

- 存储引擎: InnoDB
- 行数: 64

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `RangeMin0` | `float` | YES |  |  |  |
| `RangeMin1` | `float` | YES |  |  |  |
| `RangeMax0` | `float` | YES |  |  |  |
| `RangeMax1` | `float` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `DisplayName_lang_enUS` | `text` | YES |  |  |  |
| `DisplayName_lang_koKR` | `text` | YES |  |  |  |
| `DisplayName_lang_frFR` | `text` | YES |  |  |  |
| `DisplayName_lang_deDE` | `text` | YES |  |  |  |
| `DisplayName_lang_zhCN` | `text` | YES |  |  |  |
| `DisplayName_lang_zhTW` | `text` | YES |  |  |  |
| `DisplayName_lang_esES` | `text` | YES |  |  |  |
| `DisplayName_lang_esMX` | `text` | YES |  |  |  |
| `DisplayName_lang_ruRU` | `text` | YES |  |  |  |
| `DisplayName_lang_jaJP` | `text` | YES |  |  |  |
| `DisplayName_lang_ptPT` | `text` | YES |  |  |  |
| `DisplayName_lang_ptBR` | `text` | YES |  |  |  |
| `DisplayName_lang_itIT` | `text` | YES |  |  |  |
| `DisplayName_lang_unk1` | `text` | YES |  |  |  |
| `DisplayName_lang_unk2` | `text` | YES |  |  |  |
| `DisplayName_lang_unk3` | `text` | YES |  |  |  |
| `DisplayName_lang_Flags` | `int` | YES |  |  |  |
| `DisplayNameShort_lang_enUS` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_koKR` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_frFR` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_deDE` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_zhCN` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_zhTW` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_esES` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_esMX` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_ruRU` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_jaJP` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_ptPT` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_ptBR` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_itIT` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_unk1` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_unk2` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_unk3` | `text` | YES |  |  |  |
| `DisplayNameShort_lang_Flags` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_spell_range` (
  `ID` int NOT NULL,
  `RangeMin0` float DEFAULT NULL,
  `RangeMin1` float DEFAULT NULL,
  `RangeMax0` float DEFAULT NULL,
  `RangeMax1` float DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `DisplayName_lang_enUS` text,
  `DisplayName_lang_koKR` text,
  `DisplayName_lang_frFR` text,
  `DisplayName_lang_deDE` text,
  `DisplayName_lang_zhCN` text,
  `DisplayName_lang_zhTW` text,
  `DisplayName_lang_esES` text,
  `DisplayName_lang_esMX` text,
  `DisplayName_lang_ruRU` text,
  `DisplayName_lang_jaJP` text,
  `DisplayName_lang_ptPT` text,
  `DisplayName_lang_ptBR` text,
  `DisplayName_lang_itIT` text,
  `DisplayName_lang_unk1` text,
  `DisplayName_lang_unk2` text,
  `DisplayName_lang_unk3` text,
  `DisplayName_lang_Flags` int DEFAULT NULL,
  `DisplayNameShort_lang_enUS` text,
  `DisplayNameShort_lang_koKR` text,
  `DisplayNameShort_lang_frFR` text,
  `DisplayNameShort_lang_deDE` text,
  `DisplayNameShort_lang_zhCN` text,
  `DisplayNameShort_lang_zhTW` text,
  `DisplayNameShort_lang_esES` text,
  `DisplayNameShort_lang_esMX` text,
  `DisplayNameShort_lang_ruRU` text,
  `DisplayNameShort_lang_jaJP` text,
  `DisplayNameShort_lang_ptPT` text,
  `DisplayNameShort_lang_ptBR` text,
  `DisplayNameShort_lang_itIT` text,
  `DisplayNameShort_lang_unk1` text,
  `DisplayNameShort_lang_unk2` text,
  `DisplayNameShort_lang_unk3` text,
  `DisplayNameShort_lang_Flags` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## dbc_vehicle

- 存储引擎: InnoDB
- 行数: 412

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `TurnSpeed` | `float` | YES |  |  |  |
| `PitchSpeed` | `float` | YES |  |  |  |
| `PitchMin` | `float` | YES |  |  |  |
| `PitchMax` | `float` | YES |  |  |  |
| `SeatID0` | `int` | YES |  |  |  |
| `SeatID1` | `int` | YES |  |  |  |
| `SeatID2` | `int` | YES |  |  |  |
| `SeatID3` | `int` | YES |  |  |  |
| `SeatID4` | `int` | YES |  |  |  |
| `SeatID5` | `int` | YES |  |  |  |
| `SeatID6` | `int` | YES |  |  |  |
| `SeatID7` | `int` | YES |  |  |  |
| `MouseLookOffsetPitch` | `float` | YES |  |  |  |
| `CameraFadeDistScalarMin` | `float` | YES |  |  |  |
| `CameraFadeDistScalarMax` | `float` | YES |  |  |  |
| `CameraPitchOffset` | `float` | YES |  |  |  |
| `FacingLimitRight` | `float` | YES |  |  |  |
| `FacingLimitLeft` | `float` | YES |  |  |  |
| `MsslTrgtTurnLingering` | `float` | YES |  |  |  |
| `MsslTrgtPitchLingering` | `float` | YES |  |  |  |
| `MsslTrgtMouseLingering` | `float` | YES |  |  |  |
| `MsslTrgtEndOpacity` | `float` | YES |  |  |  |
| `MsslTrgtArcSpeed` | `float` | YES |  |  |  |
| `MsslTrgtArcRepeat` | `float` | YES |  |  |  |
| `MsslTrgtArcWidth` | `float` | YES |  |  |  |
| `MsslTrgtImpactRadius0` | `float` | YES |  |  |  |
| `MsslTrgtImpactRadius1` | `float` | YES |  |  |  |
| `MsslTrgtArcTexture` | `text` | YES |  |  |  |
| `MsslTrgtImpactTexture` | `text` | YES |  |  |  |
| `MsslTrgtImpactModel0` | `text` | YES |  |  |  |
| `MsslTrgtImpactModel1` | `text` | YES |  |  |  |
| `CameraYawOffset` | `float` | YES |  |  |  |
| `UiLocomotionType` | `int` | YES |  |  |  |
| `MsslTrgtImpactTexRadius` | `float` | YES |  |  |  |
| `VehicleUIIndicatorID` | `int` | YES |  |  |  |
| `PowerDisplayID0` | `int` | YES |  |  |  |
| `PowerDisplayID1` | `int` | YES |  |  |  |
| `PowerDisplayID2` | `int` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `dbc_vehicle` (
  `ID` int NOT NULL,
  `Flags` int DEFAULT NULL,
  `TurnSpeed` float DEFAULT NULL,
  `PitchSpeed` float DEFAULT NULL,
  `PitchMin` float DEFAULT NULL,
  `PitchMax` float DEFAULT NULL,
  `SeatID0` int DEFAULT NULL,
  `SeatID1` int DEFAULT NULL,
  `SeatID2` int DEFAULT NULL,
  `SeatID3` int DEFAULT NULL,
  `SeatID4` int DEFAULT NULL,
  `SeatID5` int DEFAULT NULL,
  `SeatID6` int DEFAULT NULL,
  `SeatID7` int DEFAULT NULL,
  `MouseLookOffsetPitch` float DEFAULT NULL,
  `CameraFadeDistScalarMin` float DEFAULT NULL,
  `CameraFadeDistScalarMax` float DEFAULT NULL,
  `CameraPitchOffset` float DEFAULT NULL,
  `FacingLimitRight` float DEFAULT NULL,
  `FacingLimitLeft` float DEFAULT NULL,
  `MsslTrgtTurnLingering` float DEFAULT NULL,
  `MsslTrgtPitchLingering` float DEFAULT NULL,
  `MsslTrgtMouseLingering` float DEFAULT NULL,
  `MsslTrgtEndOpacity` float DEFAULT NULL,
  `MsslTrgtArcSpeed` float DEFAULT NULL,
  `MsslTrgtArcRepeat` float DEFAULT NULL,
  `MsslTrgtArcWidth` float DEFAULT NULL,
  `MsslTrgtImpactRadius0` float DEFAULT NULL,
  `MsslTrgtImpactRadius1` float DEFAULT NULL,
  `MsslTrgtArcTexture` text,
  `MsslTrgtImpactTexture` text,
  `MsslTrgtImpactModel0` text,
  `MsslTrgtImpactModel1` text,
  `CameraYawOffset` float DEFAULT NULL,
  `UiLocomotionType` int DEFAULT NULL,
  `MsslTrgtImpactTexRadius` float DEFAULT NULL,
  `VehicleUIIndicatorID` int DEFAULT NULL,
  `PowerDisplayID0` int DEFAULT NULL,
  `PowerDisplayID1` int DEFAULT NULL,
  `PowerDisplayID2` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## features

- 存储引擎: InnoDB
- 行数: 7

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int` | NO | PRI |  | auto_increment |
| `name` | `varchar(100)` | NO |  |  |  |
| `description` | `varchar(255)` | NO |  |  |  |
| `icon` | `varchar(50)` | NO |  |  |  |
| `router_menu` | `varchar(50)` | NO |  |  |  |
| `category` | `varchar(20)` | NO |  | database |  |
| `is_pinned` | `tinyint(1)` | NO |  | 0 |  |
| `is_favorite` | `tinyint(1)` | NO |  | 0 |  |
| `sort_order` | `int` | NO |  | 0 |  |
| `created_at` | `timestamp` | YES |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| `updated_at` | `timestamp` | YES |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '功能名称',
  `description` varchar(255) NOT NULL COMMENT '功能描述',
  `icon` varchar(50) NOT NULL COMMENT 'LucideIcons 图标标识',
  `router_menu` varchar(50) NOT NULL COMMENT 'RouterMenu 枚举值',
  `category` varchar(20) NOT NULL DEFAULT 'database' COMMENT '分类: database/dbc',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否钉到侧边栏',
  `is_favorite` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否收藏到首页常用功能',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序号',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## migrations

- 存储引擎: InnoDB
- 行数: 2

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `name` | `varchar(200)` | NO | PRI |  |  |
| `applied_at` | `timestamp` | YES |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `name` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `migrations` (
  `name` varchar(200) NOT NULL,
  `applied_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

