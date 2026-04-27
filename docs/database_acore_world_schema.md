# acore_world 数据库表结构文档

> 生成时间: 2026-04-27 12:44:00.810606
> 数据库: acore_world
> 表数量: 308

---

## achievement_category_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Parent` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Ui_Order` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `achievement_category_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Parent` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Ui_Order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## achievement_criteria_data

- 存储引擎: InnoDB
- 行数: 2816
- 注释: Achievment system

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `criteria_id` | `int` | NO | PRI |  |  |
| `type` | `tinyint unsigned` | NO | PRI | 0 |  |
| `value1` | `int unsigned` | NO |  | 0 |  |
| `value2` | `int unsigned` | NO |  | 0 |  |
| `ScriptName` | `char(64)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `criteria_id` | 是 | BTREE |
| PRIMARY | `type` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `achievement_criteria_data` (
  `criteria_id` int NOT NULL,
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `value1` int unsigned NOT NULL DEFAULT '0',
  `value2` int unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`criteria_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Achievment system'
```

---

## achievement_criteria_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Achievement_Id` | `int` | NO |  | 0 |  |
| `Type` | `int` | NO |  | 0 |  |
| `Asset_Id` | `int` | NO |  | 0 |  |
| `Quantity` | `int` | NO |  | 0 |  |
| `Start_Event` | `int` | NO |  | 0 |  |
| `Start_Asset` | `int` | NO |  | 0 |  |
| `Fail_Event` | `int` | NO |  | 0 |  |
| `Fail_Asset` | `int` | NO |  | 0 |  |
| `Description_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `Timer_Start_Event` | `int` | NO |  | 0 |  |
| `Timer_Asset_Id` | `int` | NO |  | 0 |  |
| `Timer_Time` | `int` | NO |  | 0 |  |
| `Ui_Order` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `achievement_criteria_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Achievement_Id` int NOT NULL DEFAULT '0',
  `Type` int NOT NULL DEFAULT '0',
  `Asset_Id` int NOT NULL DEFAULT '0',
  `Quantity` int NOT NULL DEFAULT '0',
  `Start_Event` int NOT NULL DEFAULT '0',
  `Start_Asset` int NOT NULL DEFAULT '0',
  `Fail_Event` int NOT NULL DEFAULT '0',
  `Fail_Asset` int NOT NULL DEFAULT '0',
  `Description_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `Timer_Start_Event` int NOT NULL DEFAULT '0',
  `Timer_Asset_Id` int NOT NULL DEFAULT '0',
  `Timer_Time` int NOT NULL DEFAULT '0',
  `Ui_Order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## achievement_dbc

- 存储引擎: InnoDB
- 行数: 3

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Faction` | `int` | NO |  | 0 |  |
| `Instance_Id` | `int` | NO |  | 0 |  |
| `Supercedes` | `int` | NO |  | 0 |  |
| `Title_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Title_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Description_Lang_enUS` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_enGB` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_koKR` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_frFR` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_deDE` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_enCN` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_zhCN` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_enTW` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_zhTW` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_esES` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_esMX` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_ruRU` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_ptPT` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_ptBR` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_itIT` | `varchar(200)` | YES |  |  |  |
| `Description_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Category` | `int` | NO |  | 0 |  |
| `Points` | `int` | NO |  | 0 |  |
| `Ui_Order` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `IconID` | `int` | NO |  | 0 |  |
| `Reward_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Reward_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Minimum_Criteria` | `int` | NO |  | 0 |  |
| `Shares_Criteria` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `achievement_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Faction` int NOT NULL DEFAULT '0',
  `Instance_Id` int NOT NULL DEFAULT '0',
  `Supercedes` int NOT NULL DEFAULT '0',
  `Title_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Title_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Description_Lang_enUS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enGB` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_koKR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_frFR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_deDE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enCN` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhCN` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enTW` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhTW` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esES` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esMX` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ruRU` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptPT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptBR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_itIT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Category` int NOT NULL DEFAULT '0',
  `Points` int NOT NULL DEFAULT '0',
  `Ui_Order` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `IconID` int NOT NULL DEFAULT '0',
  `Reward_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Reward_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Minimum_Criteria` int NOT NULL DEFAULT '0',
  `Shares_Criteria` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## achievement_reward

- 存储引擎: InnoDB
- 行数: 115
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `TitleA` | `int unsigned` | NO |  | 0 |  |
| `TitleH` | `int unsigned` | NO |  | 0 |  |
| `ItemID` | `int unsigned` | NO |  | 0 |  |
| `Sender` | `int unsigned` | NO |  | 0 |  |
| `Subject` | `varchar(255)` | YES |  |  |  |
| `Body` | `text` | YES |  |  |  |
| `MailTemplateID` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `achievement_reward` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `TitleA` int unsigned NOT NULL DEFAULT '0',
  `TitleH` int unsigned NOT NULL DEFAULT '0',
  `ItemID` int unsigned NOT NULL DEFAULT '0',
  `Sender` int unsigned NOT NULL DEFAULT '0',
  `Subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MailTemplateID` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## achievement_reward_locale

- 存储引擎: InnoDB
- 行数: 229

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `Locale` | `varchar(4)` | NO | PRI |  |  |
| `Subject` | `text` | YES |  |  |  |
| `Text` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `Locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `achievement_reward_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `Locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Subject` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID`,`Locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## acore_string

- 存储引擎: InnoDB
- 行数: 1271

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `content_default` | `text` | NO |  |  |  |
| `locale_koKR` | `text` | YES |  |  |  |
| `locale_frFR` | `text` | YES |  |  |  |
| `locale_deDE` | `text` | YES |  |  |  |
| `locale_zhCN` | `text` | YES |  |  |  |
| `locale_zhTW` | `text` | YES |  |  |  |
| `locale_esES` | `text` | YES |  |  |  |
| `locale_esMX` | `text` | YES |  |  |  |
| `locale_ruRU` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `acore_string` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `content_default` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `locale_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `locale_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## antidos_opcode_policies

- 存储引擎: InnoDB
- 行数: 102

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Opcode` | `smallint unsigned` | NO | PRI |  |  |
| `Policy` | `tinyint unsigned` | NO |  |  |  |
| `MaxAllowedCount` | `smallint unsigned` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Opcode` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `antidos_opcode_policies` (
  `Opcode` smallint unsigned NOT NULL,
  `Policy` tinyint unsigned NOT NULL,
  `MaxAllowedCount` smallint unsigned NOT NULL,
  PRIMARY KEY (`Opcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## areagroup_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `AreaID_1` | `int` | NO |  | 0 |  |
| `AreaID_2` | `int` | NO |  | 0 |  |
| `AreaID_3` | `int` | NO |  | 0 |  |
| `AreaID_4` | `int` | NO |  | 0 |  |
| `AreaID_5` | `int` | NO |  | 0 |  |
| `AreaID_6` | `int` | NO |  | 0 |  |
| `NextAreaID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `areagroup_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `AreaID_1` int NOT NULL DEFAULT '0',
  `AreaID_2` int NOT NULL DEFAULT '0',
  `AreaID_3` int NOT NULL DEFAULT '0',
  `AreaID_4` int NOT NULL DEFAULT '0',
  `AreaID_5` int NOT NULL DEFAULT '0',
  `AreaID_6` int NOT NULL DEFAULT '0',
  `NextAreaID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## areapoi_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Importance` | `int` | NO |  | 0 |  |
| `Icon_1` | `int` | NO |  | 0 |  |
| `Icon_2` | `int` | NO |  | 0 |  |
| `Icon_3` | `int` | NO |  | 0 |  |
| `Icon_4` | `int` | NO |  | 0 |  |
| `Icon_5` | `int` | NO |  | 0 |  |
| `Icon_6` | `int` | NO |  | 0 |  |
| `Icon_7` | `int` | NO |  | 0 |  |
| `Icon_8` | `int` | NO |  | 0 |  |
| `Icon_9` | `int` | NO |  | 0 |  |
| `FactionID` | `int` | NO |  | 0 |  |
| `X` | `float` | NO |  | 0 |  |
| `Y` | `float` | NO |  | 0 |  |
| `Z` | `float` | NO |  | 0 |  |
| `ContinentID` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `AreaID` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Description_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `WorldStateID` | `int` | NO |  | 0 |  |
| `WorldMapLink` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `areapoi_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Importance` int NOT NULL DEFAULT '0',
  `Icon_1` int NOT NULL DEFAULT '0',
  `Icon_2` int NOT NULL DEFAULT '0',
  `Icon_3` int NOT NULL DEFAULT '0',
  `Icon_4` int NOT NULL DEFAULT '0',
  `Icon_5` int NOT NULL DEFAULT '0',
  `Icon_6` int NOT NULL DEFAULT '0',
  `Icon_7` int NOT NULL DEFAULT '0',
  `Icon_8` int NOT NULL DEFAULT '0',
  `Icon_9` int NOT NULL DEFAULT '0',
  `FactionID` int NOT NULL DEFAULT '0',
  `X` float NOT NULL DEFAULT '0',
  `Y` float NOT NULL DEFAULT '0',
  `Z` float NOT NULL DEFAULT '0',
  `ContinentID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `AreaID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Description_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `WorldStateID` int NOT NULL DEFAULT '0',
  `WorldMapLink` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## areatable_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ContinentID` | `int` | NO |  | 0 |  |
| `ParentAreaID` | `int` | NO |  | 0 |  |
| `AreaBit` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `SoundProviderPref` | `int` | NO |  | 0 |  |
| `SoundProviderPrefUnderwater` | `int` | NO |  | 0 |  |
| `AmbienceID` | `int` | NO |  | 0 |  |
| `ZoneMusic` | `int` | NO |  | 0 |  |
| `IntroSound` | `int` | NO |  | 0 |  |
| `ExplorationLevel` | `int` | NO |  | 0 |  |
| `AreaName_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `FactionGroupMask` | `int` | NO |  | 0 |  |
| `LiquidTypeID_1` | `int` | NO |  | 0 |  |
| `LiquidTypeID_2` | `int` | NO |  | 0 |  |
| `LiquidTypeID_3` | `int` | NO |  | 0 |  |
| `LiquidTypeID_4` | `int` | NO |  | 0 |  |
| `MinElevation` | `float` | NO |  | 0 |  |
| `Ambient_Multiplier` | `float` | NO |  | 0 |  |
| `Lightid` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `areatable_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ContinentID` int NOT NULL DEFAULT '0',
  `ParentAreaID` int NOT NULL DEFAULT '0',
  `AreaBit` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `SoundProviderPref` int NOT NULL DEFAULT '0',
  `SoundProviderPrefUnderwater` int NOT NULL DEFAULT '0',
  `AmbienceID` int NOT NULL DEFAULT '0',
  `ZoneMusic` int NOT NULL DEFAULT '0',
  `IntroSound` int NOT NULL DEFAULT '0',
  `ExplorationLevel` int NOT NULL DEFAULT '0',
  `AreaName_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `FactionGroupMask` int NOT NULL DEFAULT '0',
  `LiquidTypeID_1` int NOT NULL DEFAULT '0',
  `LiquidTypeID_2` int NOT NULL DEFAULT '0',
  `LiquidTypeID_3` int NOT NULL DEFAULT '0',
  `LiquidTypeID_4` int NOT NULL DEFAULT '0',
  `MinElevation` float NOT NULL DEFAULT '0',
  `Ambient_Multiplier` float NOT NULL DEFAULT '0',
  `Lightid` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## areatrigger

- 存储引擎: InnoDB
- 行数: 1217

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI |  | auto_increment |
| `map` | `int unsigned` | NO |  | 0 |  |
| `x` | `float` | NO |  | 0 |  |
| `y` | `float` | NO |  | 0 |  |
| `z` | `float` | NO |  | 0 |  |
| `radius` | `float` | NO |  | 0 |  |
| `length` | `float` | NO |  | 0 |  |
| `width` | `float` | NO |  | 0 |  |
| `height` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `areatrigger` (
  `entry` int unsigned NOT NULL AUTO_INCREMENT,
  `map` int unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `radius` float NOT NULL DEFAULT '0' COMMENT 'Seems to be a box of size yards with center at x,y,z',
  `length` float NOT NULL DEFAULT '0' COMMENT 'Most commonly used when size is 0, but not always',
  `width` float NOT NULL DEFAULT '0' COMMENT 'Most commonly used when size is 0, but not always',
  `height` float NOT NULL DEFAULT '0' COMMENT 'Most commonly used when size is 0, but not always',
  `orientation` float NOT NULL DEFAULT '0' COMMENT 'Most commonly used when size is 0, but not always',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB AUTO_INCREMENT=5873 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## areatrigger_involvedrelation

- 存储引擎: InnoDB
- 行数: 76
- 注释: Trigger System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `quest` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `areatrigger_involvedrelation` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Trigger System'
```

---

## areatrigger_scripts

- 存储引擎: InnoDB
- 行数: 176

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int` | NO | PRI |  |  |
| `ScriptName` | `char(64)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `areatrigger_scripts` (
  `entry` int NOT NULL,
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## areatrigger_tavern

- 存储引擎: InnoDB
- 行数: 113
- 注释: Trigger System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `name` | `text` | YES |  |  |  |
| `faction` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `areatrigger_tavern` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `faction` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Trigger System'
```

---

## areatrigger_teleport

- 存储引擎: InnoDB
- 行数: 276
- 注释: Trigger System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `Name` | `text` | YES | MUL |  |  |
| `target_map` | `smallint unsigned` | NO |  | 0 |  |
| `target_position_x` | `float` | NO |  | 0 |  |
| `target_position_y` | `float` | NO |  | 0 |  |
| `target_position_z` | `float` | NO |  | 0 |  |
| `target_orientation` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| name | `Name` | 否 | FULLTEXT |

### CREATE TABLE

```sql
CREATE TABLE `areatrigger_teleport` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `target_map` smallint unsigned NOT NULL DEFAULT '0',
  `target_position_x` float NOT NULL DEFAULT '0',
  `target_position_y` float NOT NULL DEFAULT '0',
  `target_position_z` float NOT NULL DEFAULT '0',
  `target_orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  FULLTEXT KEY `name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Trigger System'
```

---

## arena_season_reward

- 存储引擎: InnoDB
- 行数: 47

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `group_id` | `int` | NO | PRI |  |  |
| `type` | `enum('achievement','item')` | NO | PRI | achievement |  |
| `entry` | `int unsigned` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `group_id` | 是 | BTREE |
| PRIMARY | `type` | 是 | BTREE |
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `arena_season_reward` (
  `group_id` int NOT NULL COMMENT 'id from arena_season_reward_group table',
  `type` enum('achievement','item') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'achievement',
  `entry` int unsigned NOT NULL COMMENT 'For item type - item entry, for achievement - achevement id.',
  PRIMARY KEY (`group_id`,`type`,`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## arena_season_reward_group

- 存储引擎: InnoDB
- 行数: 39

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int` | NO | PRI |  | auto_increment |
| `arena_season` | `tinyint unsigned` | NO |  |  |  |
| `criteria_type` | `enum('pct','abs')` | NO |  | pct |  |
| `min_criteria` | `float` | NO |  |  |  |
| `max_criteria` | `float` | NO |  |  |  |
| `reward_mail_template_id` | `int unsigned` | YES |  |  |  |
| `reward_mail_subject` | `varchar(255)` | YES |  |  |  |
| `reward_mail_body` | `text` | YES |  |  |  |
| `gold_reward` | `int unsigned` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `arena_season_reward_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `arena_season` tinyint unsigned NOT NULL,
  `criteria_type` enum('pct','abs') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pct' COMMENT 'Determines how rankings are evaluated: "pct" - percentage-based (e.g., top 20% of the ladder), "abs" - absolute position-based (e.g., top 10 players).',
  `min_criteria` float NOT NULL,
  `max_criteria` float NOT NULL,
  `reward_mail_template_id` int unsigned DEFAULT NULL,
  `reward_mail_subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reward_mail_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `gold_reward` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## auctionhouse_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `FactionID` | `int` | NO |  | 0 |  |
| `DepositRate` | `int` | NO |  | 0 |  |
| `ConsignmentRate` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `auctionhouse_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `FactionID` int NOT NULL DEFAULT '0',
  `DepositRate` int NOT NULL DEFAULT '0',
  `ConsignmentRate` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## bankbagslotprices_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Cost` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `bankbagslotprices_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Cost` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## barbershopstyle_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Type` | `int` | NO |  | 0 |  |
| `DisplayName_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Description_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Cost_Modifier` | `float` | NO |  | 0 |  |
| `Race` | `int` | NO |  | 0 |  |
| `Sex` | `int` | NO |  | 0 |  |
| `Data` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `barbershopstyle_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Type` int NOT NULL DEFAULT '0',
  `DisplayName_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Description_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Cost_Modifier` float NOT NULL DEFAULT '0',
  `Race` int NOT NULL DEFAULT '0',
  `Sex` int NOT NULL DEFAULT '0',
  `Data` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## battleground_template

- 存储引擎: InnoDB
- 行数: 13

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `MinPlayersPerTeam` | `smallint unsigned` | NO |  | 0 |  |
| `MaxPlayersPerTeam` | `smallint unsigned` | NO |  | 0 |  |
| `MinLvl` | `tinyint unsigned` | NO |  | 0 |  |
| `MaxLvl` | `tinyint unsigned` | NO |  | 0 |  |
| `AllianceStartLoc` | `int unsigned` | YES |  |  |  |
| `AllianceStartO` | `float` | NO |  |  |  |
| `HordeStartLoc` | `int unsigned` | YES |  |  |  |
| `HordeStartO` | `float` | NO |  |  |  |
| `StartMaxDist` | `float` | NO |  | 0 |  |
| `Weight` | `tinyint unsigned` | NO |  | 1 |  |
| `ScriptName` | `char(64)` | NO |  |  |  |
| `Comment` | `char(38)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `battleground_template` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `MinPlayersPerTeam` smallint unsigned NOT NULL DEFAULT '0',
  `MaxPlayersPerTeam` smallint unsigned NOT NULL DEFAULT '0',
  `MinLvl` tinyint unsigned NOT NULL DEFAULT '0',
  `MaxLvl` tinyint unsigned NOT NULL DEFAULT '0',
  `AllianceStartLoc` int unsigned DEFAULT NULL,
  `AllianceStartO` float NOT NULL,
  `HordeStartLoc` int unsigned DEFAULT NULL,
  `HordeStartO` float NOT NULL,
  `StartMaxDist` float NOT NULL DEFAULT '0',
  `Weight` tinyint unsigned NOT NULL DEFAULT '1',
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Comment` char(38) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## battlemaster_entry

- 存储引擎: InnoDB
- 行数: 146

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `bg_template` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `battlemaster_entry` (
  `entry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Entry of a creature',
  `bg_template` int unsigned NOT NULL DEFAULT '0' COMMENT 'Battleground template id',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## battlemasterlist_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `MapID_1` | `int` | NO |  | 0 |  |
| `MapID_2` | `int` | NO |  | 0 |  |
| `MapID_3` | `int` | NO |  | 0 |  |
| `MapID_4` | `int` | NO |  | 0 |  |
| `MapID_5` | `int` | NO |  | 0 |  |
| `MapID_6` | `int` | NO |  | 0 |  |
| `MapID_7` | `int` | NO |  | 0 |  |
| `MapID_8` | `int` | NO |  | 0 |  |
| `InstanceType` | `int` | NO |  | 0 |  |
| `GroupsAllowed` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `MaxGroupSize` | `int` | NO |  | 0 |  |
| `HolidayWorldState` | `int` | NO |  | 0 |  |
| `Minlevel` | `int` | NO |  | 0 |  |
| `Maxlevel` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `battlemasterlist_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `MapID_1` int NOT NULL DEFAULT '0',
  `MapID_2` int NOT NULL DEFAULT '0',
  `MapID_3` int NOT NULL DEFAULT '0',
  `MapID_4` int NOT NULL DEFAULT '0',
  `MapID_5` int NOT NULL DEFAULT '0',
  `MapID_6` int NOT NULL DEFAULT '0',
  `MapID_7` int NOT NULL DEFAULT '0',
  `MapID_8` int NOT NULL DEFAULT '0',
  `InstanceType` int NOT NULL DEFAULT '0',
  `GroupsAllowed` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `MaxGroupSize` int NOT NULL DEFAULT '0',
  `HolidayWorldState` int NOT NULL DEFAULT '0',
  `Minlevel` int NOT NULL DEFAULT '0',
  `Maxlevel` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## broadcast_text

- 存储引擎: InnoDB
- 行数: 76632

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `LanguageID` | `int` | YES |  |  |  |
| `MaleText` | `longtext` | YES |  |  |  |
| `FemaleText` | `longtext` | YES |  |  |  |
| `EmoteID1` | `int` | YES |  |  |  |
| `EmoteID2` | `int` | YES |  |  |  |
| `EmoteID3` | `int` | YES |  |  |  |
| `EmoteDelay1` | `int` | YES |  |  |  |
| `EmoteDelay2` | `int` | YES |  |  |  |
| `EmoteDelay3` | `int` | YES |  |  |  |
| `SoundEntriesId` | `int` | YES |  |  |  |
| `EmotesID` | `int` | YES |  |  |  |
| `Flags` | `int` | YES |  |  |  |
| `VerifiedBuild` | `smallint` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `broadcast_text` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `LanguageID` int DEFAULT NULL,
  `MaleText` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `FemaleText` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `EmoteID1` int DEFAULT NULL,
  `EmoteID2` int DEFAULT NULL,
  `EmoteID3` int DEFAULT NULL,
  `EmoteDelay1` int DEFAULT NULL,
  `EmoteDelay2` int DEFAULT NULL,
  `EmoteDelay3` int DEFAULT NULL,
  `SoundEntriesId` int DEFAULT NULL,
  `EmotesID` int DEFAULT NULL,
  `Flags` int DEFAULT NULL,
  `VerifiedBuild` smallint DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## broadcast_text_locale

- 存储引擎: InnoDB
- 行数: 541505

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `MaleText` | `text` | YES |  |  |  |
| `FemaleText` | `text` | YES |  |  |  |
| `VerifiedBuild` | `smallint` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `broadcast_text_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `MaleText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `FemaleText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` smallint DEFAULT '0',
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## charstartoutfit_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `RaceID` | `tinyint unsigned` | NO |  | 0 |  |
| `ClassID` | `tinyint unsigned` | NO |  | 0 |  |
| `SexID` | `tinyint unsigned` | NO |  | 0 |  |
| `OutfitID` | `tinyint unsigned` | NO |  | 0 |  |
| `ItemID_1` | `int` | NO |  | 0 |  |
| `ItemID_2` | `int` | NO |  | 0 |  |
| `ItemID_3` | `int` | NO |  | 0 |  |
| `ItemID_4` | `int` | NO |  | 0 |  |
| `ItemID_5` | `int` | NO |  | 0 |  |
| `ItemID_6` | `int` | NO |  | 0 |  |
| `ItemID_7` | `int` | NO |  | 0 |  |
| `ItemID_8` | `int` | NO |  | 0 |  |
| `ItemID_9` | `int` | NO |  | 0 |  |
| `ItemID_10` | `int` | NO |  | 0 |  |
| `ItemID_11` | `int` | NO |  | 0 |  |
| `ItemID_12` | `int` | NO |  | 0 |  |
| `ItemID_13` | `int` | NO |  | 0 |  |
| `ItemID_14` | `int` | NO |  | 0 |  |
| `ItemID_15` | `int` | NO |  | 0 |  |
| `ItemID_16` | `int` | NO |  | 0 |  |
| `ItemID_17` | `int` | NO |  | 0 |  |
| `ItemID_18` | `int` | NO |  | 0 |  |
| `ItemID_19` | `int` | NO |  | 0 |  |
| `ItemID_20` | `int` | NO |  | 0 |  |
| `ItemID_21` | `int` | NO |  | 0 |  |
| `ItemID_22` | `int` | NO |  | 0 |  |
| `ItemID_23` | `int` | NO |  | 0 |  |
| `ItemID_24` | `int` | NO |  | 0 |  |
| `DisplayItemID_1` | `int` | NO |  | 0 |  |
| `DisplayItemID_2` | `int` | NO |  | 0 |  |
| `DisplayItemID_3` | `int` | NO |  | 0 |  |
| `DisplayItemID_4` | `int` | NO |  | 0 |  |
| `DisplayItemID_5` | `int` | NO |  | 0 |  |
| `DisplayItemID_6` | `int` | NO |  | 0 |  |
| `DisplayItemID_7` | `int` | NO |  | 0 |  |
| `DisplayItemID_8` | `int` | NO |  | 0 |  |
| `DisplayItemID_9` | `int` | NO |  | 0 |  |
| `DisplayItemID_10` | `int` | NO |  | 0 |  |
| `DisplayItemID_11` | `int` | NO |  | 0 |  |
| `DisplayItemID_12` | `int` | NO |  | 0 |  |
| `DisplayItemID_13` | `int` | NO |  | 0 |  |
| `DisplayItemID_14` | `int` | NO |  | 0 |  |
| `DisplayItemID_15` | `int` | NO |  | 0 |  |
| `DisplayItemID_16` | `int` | NO |  | 0 |  |
| `DisplayItemID_17` | `int` | NO |  | 0 |  |
| `DisplayItemID_18` | `int` | NO |  | 0 |  |
| `DisplayItemID_19` | `int` | NO |  | 0 |  |
| `DisplayItemID_20` | `int` | NO |  | 0 |  |
| `DisplayItemID_21` | `int` | NO |  | 0 |  |
| `DisplayItemID_22` | `int` | NO |  | 0 |  |
| `DisplayItemID_23` | `int` | NO |  | 0 |  |
| `DisplayItemID_24` | `int` | NO |  | 0 |  |
| `InventoryType_1` | `int` | NO |  | 0 |  |
| `InventoryType_2` | `int` | NO |  | 0 |  |
| `InventoryType_3` | `int` | NO |  | 0 |  |
| `InventoryType_4` | `int` | NO |  | 0 |  |
| `InventoryType_5` | `int` | NO |  | 0 |  |
| `InventoryType_6` | `int` | NO |  | 0 |  |
| `InventoryType_7` | `int` | NO |  | 0 |  |
| `InventoryType_8` | `int` | NO |  | 0 |  |
| `InventoryType_9` | `int` | NO |  | 0 |  |
| `InventoryType_10` | `int` | NO |  | 0 |  |
| `InventoryType_11` | `int` | NO |  | 0 |  |
| `InventoryType_12` | `int` | NO |  | 0 |  |
| `InventoryType_13` | `int` | NO |  | 0 |  |
| `InventoryType_14` | `int` | NO |  | 0 |  |
| `InventoryType_15` | `int` | NO |  | 0 |  |
| `InventoryType_16` | `int` | NO |  | 0 |  |
| `InventoryType_17` | `int` | NO |  | 0 |  |
| `InventoryType_18` | `int` | NO |  | 0 |  |
| `InventoryType_19` | `int` | NO |  | 0 |  |
| `InventoryType_20` | `int` | NO |  | 0 |  |
| `InventoryType_21` | `int` | NO |  | 0 |  |
| `InventoryType_22` | `int` | NO |  | 0 |  |
| `InventoryType_23` | `int` | NO |  | 0 |  |
| `InventoryType_24` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `charstartoutfit_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `RaceID` tinyint unsigned NOT NULL DEFAULT '0',
  `ClassID` tinyint unsigned NOT NULL DEFAULT '0',
  `SexID` tinyint unsigned NOT NULL DEFAULT '0',
  `OutfitID` tinyint unsigned NOT NULL DEFAULT '0',
  `ItemID_1` int NOT NULL DEFAULT '0',
  `ItemID_2` int NOT NULL DEFAULT '0',
  `ItemID_3` int NOT NULL DEFAULT '0',
  `ItemID_4` int NOT NULL DEFAULT '0',
  `ItemID_5` int NOT NULL DEFAULT '0',
  `ItemID_6` int NOT NULL DEFAULT '0',
  `ItemID_7` int NOT NULL DEFAULT '0',
  `ItemID_8` int NOT NULL DEFAULT '0',
  `ItemID_9` int NOT NULL DEFAULT '0',
  `ItemID_10` int NOT NULL DEFAULT '0',
  `ItemID_11` int NOT NULL DEFAULT '0',
  `ItemID_12` int NOT NULL DEFAULT '0',
  `ItemID_13` int NOT NULL DEFAULT '0',
  `ItemID_14` int NOT NULL DEFAULT '0',
  `ItemID_15` int NOT NULL DEFAULT '0',
  `ItemID_16` int NOT NULL DEFAULT '0',
  `ItemID_17` int NOT NULL DEFAULT '0',
  `ItemID_18` int NOT NULL DEFAULT '0',
  `ItemID_19` int NOT NULL DEFAULT '0',
  `ItemID_20` int NOT NULL DEFAULT '0',
  `ItemID_21` int NOT NULL DEFAULT '0',
  `ItemID_22` int NOT NULL DEFAULT '0',
  `ItemID_23` int NOT NULL DEFAULT '0',
  `ItemID_24` int NOT NULL DEFAULT '0',
  `DisplayItemID_1` int NOT NULL DEFAULT '0',
  `DisplayItemID_2` int NOT NULL DEFAULT '0',
  `DisplayItemID_3` int NOT NULL DEFAULT '0',
  `DisplayItemID_4` int NOT NULL DEFAULT '0',
  `DisplayItemID_5` int NOT NULL DEFAULT '0',
  `DisplayItemID_6` int NOT NULL DEFAULT '0',
  `DisplayItemID_7` int NOT NULL DEFAULT '0',
  `DisplayItemID_8` int NOT NULL DEFAULT '0',
  `DisplayItemID_9` int NOT NULL DEFAULT '0',
  `DisplayItemID_10` int NOT NULL DEFAULT '0',
  `DisplayItemID_11` int NOT NULL DEFAULT '0',
  `DisplayItemID_12` int NOT NULL DEFAULT '0',
  `DisplayItemID_13` int NOT NULL DEFAULT '0',
  `DisplayItemID_14` int NOT NULL DEFAULT '0',
  `DisplayItemID_15` int NOT NULL DEFAULT '0',
  `DisplayItemID_16` int NOT NULL DEFAULT '0',
  `DisplayItemID_17` int NOT NULL DEFAULT '0',
  `DisplayItemID_18` int NOT NULL DEFAULT '0',
  `DisplayItemID_19` int NOT NULL DEFAULT '0',
  `DisplayItemID_20` int NOT NULL DEFAULT '0',
  `DisplayItemID_21` int NOT NULL DEFAULT '0',
  `DisplayItemID_22` int NOT NULL DEFAULT '0',
  `DisplayItemID_23` int NOT NULL DEFAULT '0',
  `DisplayItemID_24` int NOT NULL DEFAULT '0',
  `InventoryType_1` int NOT NULL DEFAULT '0',
  `InventoryType_2` int NOT NULL DEFAULT '0',
  `InventoryType_3` int NOT NULL DEFAULT '0',
  `InventoryType_4` int NOT NULL DEFAULT '0',
  `InventoryType_5` int NOT NULL DEFAULT '0',
  `InventoryType_6` int NOT NULL DEFAULT '0',
  `InventoryType_7` int NOT NULL DEFAULT '0',
  `InventoryType_8` int NOT NULL DEFAULT '0',
  `InventoryType_9` int NOT NULL DEFAULT '0',
  `InventoryType_10` int NOT NULL DEFAULT '0',
  `InventoryType_11` int NOT NULL DEFAULT '0',
  `InventoryType_12` int NOT NULL DEFAULT '0',
  `InventoryType_13` int NOT NULL DEFAULT '0',
  `InventoryType_14` int NOT NULL DEFAULT '0',
  `InventoryType_15` int NOT NULL DEFAULT '0',
  `InventoryType_16` int NOT NULL DEFAULT '0',
  `InventoryType_17` int NOT NULL DEFAULT '0',
  `InventoryType_18` int NOT NULL DEFAULT '0',
  `InventoryType_19` int NOT NULL DEFAULT '0',
  `InventoryType_20` int NOT NULL DEFAULT '0',
  `InventoryType_21` int NOT NULL DEFAULT '0',
  `InventoryType_22` int NOT NULL DEFAULT '0',
  `InventoryType_23` int NOT NULL DEFAULT '0',
  `InventoryType_24` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## chartitles_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Condition_ID` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Name1_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name1_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Mask_ID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `chartitles_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Condition_ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Name1_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name1_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Mask_ID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## chatchannels_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `FactionGroup` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Shortcut_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Shortcut_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `chatchannels_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `FactionGroup` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Shortcut_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Shortcut_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## chrclasses_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Field01` | `int` | NO |  | 0 |  |
| `DisplayPower` | `int` | NO |  | 0 |  |
| `PetNameToken` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Name_Female_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Name_Male_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Filename` | `varchar(100)` | YES |  |  |  |
| `SpellClassSet` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `CinematicSequenceID` | `int` | NO |  | 0 |  |
| `Required_Expansion` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `chrclasses_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Field01` int NOT NULL DEFAULT '0',
  `DisplayPower` int NOT NULL DEFAULT '0',
  `PetNameToken` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Name_Female_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Name_Male_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SpellClassSet` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `CinematicSequenceID` int NOT NULL DEFAULT '0',
  `Required_Expansion` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## chrraces_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `FactionID` | `int` | NO |  | 0 |  |
| `ExplorationSoundID` | `int` | NO |  | 0 |  |
| `MaleDisplayId` | `int` | NO |  | 0 |  |
| `FemaleDisplayId` | `int` | NO |  | 0 |  |
| `ClientPrefix` | `varchar(100)` | YES |  |  |  |
| `BaseLanguage` | `int` | NO |  | 0 |  |
| `CreatureType` | `int` | NO |  | 0 |  |
| `ResSicknessSpellID` | `int` | NO |  | 0 |  |
| `SplashSoundID` | `int` | NO |  | 0 |  |
| `ClientFilestring` | `varchar(100)` | YES |  |  |  |
| `CinematicSequenceID` | `int` | NO |  | 0 |  |
| `Alliance` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Name_Female_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Female_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Name_Male_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Male_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `FacialHairCustomization_1` | `varchar(100)` | YES |  |  |  |
| `FacialHairCustomization_2` | `varchar(100)` | YES |  |  |  |
| `HairCustomization` | `varchar(100)` | YES |  |  |  |
| `Required_Expansion` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `chrraces_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `FactionID` int NOT NULL DEFAULT '0',
  `ExplorationSoundID` int NOT NULL DEFAULT '0',
  `MaleDisplayId` int NOT NULL DEFAULT '0',
  `FemaleDisplayId` int NOT NULL DEFAULT '0',
  `ClientPrefix` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BaseLanguage` int NOT NULL DEFAULT '0',
  `CreatureType` int NOT NULL DEFAULT '0',
  `ResSicknessSpellID` int NOT NULL DEFAULT '0',
  `SplashSoundID` int NOT NULL DEFAULT '0',
  `ClientFilestring` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CinematicSequenceID` int NOT NULL DEFAULT '0',
  `Alliance` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Name_Female_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Female_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Name_Male_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Male_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `FacialHairCustomization_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FacialHairCustomization_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `HairCustomization` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Required_Expansion` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## cinematiccamera_dbc

- 存储引擎: InnoDB
- 行数: 0
- 注释: Cinematic camera DBC

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `model` | `varchar(100)` | YES |  |  |  |
| `soundEntry` | `int` | NO |  | 0 |  |
| `locationX` | `float` | NO |  | 0 |  |
| `locationY` | `float` | NO |  | 0 |  |
| `locationZ` | `float` | NO |  | 0 |  |
| `rotation` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `cinematiccamera_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soundEntry` int NOT NULL DEFAULT '0',
  `locationX` float NOT NULL DEFAULT '0',
  `locationY` float NOT NULL DEFAULT '0',
  `locationZ` float NOT NULL DEFAULT '0',
  `rotation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cinematic camera DBC'
```

---

## cinematicsequences_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `SoundID` | `int` | NO |  | 0 |  |
| `Camera_1` | `int` | NO |  | 0 |  |
| `Camera_2` | `int` | NO |  | 0 |  |
| `Camera_3` | `int` | NO |  | 0 |  |
| `Camera_4` | `int` | NO |  | 0 |  |
| `Camera_5` | `int` | NO |  | 0 |  |
| `Camera_6` | `int` | NO |  | 0 |  |
| `Camera_7` | `int` | NO |  | 0 |  |
| `Camera_8` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `cinematicsequences_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `SoundID` int NOT NULL DEFAULT '0',
  `Camera_1` int NOT NULL DEFAULT '0',
  `Camera_2` int NOT NULL DEFAULT '0',
  `Camera_3` int NOT NULL DEFAULT '0',
  `Camera_4` int NOT NULL DEFAULT '0',
  `Camera_5` int NOT NULL DEFAULT '0',
  `Camera_6` int NOT NULL DEFAULT '0',
  `Camera_7` int NOT NULL DEFAULT '0',
  `Camera_8` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## command

- 存储引擎: InnoDB
- 行数: 683
- 注释: Chat System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `name` | `varchar(50)` | NO | PRI |  |  |
| `security` | `tinyint unsigned` | NO |  | 0 |  |
| `help` | `longtext` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `name` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `command` (
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `security` tinyint unsigned NOT NULL DEFAULT '0',
  `help` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Chat System'
```

---

## conditions

- 存储引擎: InnoDB
- 行数: 14623
- 注释: Condition System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `SourceTypeOrReferenceId` | `int` | NO | PRI | 0 |  |
| `SourceGroup` | `int unsigned` | NO | PRI | 0 |  |
| `SourceEntry` | `int` | NO | PRI | 0 |  |
| `SourceId` | `int` | NO | PRI | 0 |  |
| `ElseGroup` | `int unsigned` | NO | PRI | 0 |  |
| `ConditionTypeOrReference` | `int` | NO | PRI | 0 |  |
| `ConditionTarget` | `tinyint unsigned` | NO | PRI | 0 |  |
| `ConditionValue1` | `int unsigned` | NO | PRI | 0 |  |
| `ConditionValue2` | `int unsigned` | NO | PRI | 0 |  |
| `ConditionValue3` | `int unsigned` | NO | PRI | 0 |  |
| `NegativeCondition` | `tinyint unsigned` | NO |  | 0 |  |
| `ErrorType` | `int unsigned` | NO |  | 0 |  |
| `ErrorTextId` | `int unsigned` | NO |  | 0 |  |
| `ScriptName` | `char(64)` | NO |  |  |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `SourceTypeOrReferenceId` | 是 | BTREE |
| PRIMARY | `SourceGroup` | 是 | BTREE |
| PRIMARY | `SourceEntry` | 是 | BTREE |
| PRIMARY | `SourceId` | 是 | BTREE |
| PRIMARY | `ElseGroup` | 是 | BTREE |
| PRIMARY | `ConditionTypeOrReference` | 是 | BTREE |
| PRIMARY | `ConditionTarget` | 是 | BTREE |
| PRIMARY | `ConditionValue1` | 是 | BTREE |
| PRIMARY | `ConditionValue2` | 是 | BTREE |
| PRIMARY | `ConditionValue3` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `conditions` (
  `SourceTypeOrReferenceId` int NOT NULL DEFAULT '0',
  `SourceGroup` int unsigned NOT NULL DEFAULT '0',
  `SourceEntry` int NOT NULL DEFAULT '0',
  `SourceId` int NOT NULL DEFAULT '0',
  `ElseGroup` int unsigned NOT NULL DEFAULT '0',
  `ConditionTypeOrReference` int NOT NULL DEFAULT '0',
  `ConditionTarget` tinyint unsigned NOT NULL DEFAULT '0',
  `ConditionValue1` int unsigned NOT NULL DEFAULT '0',
  `ConditionValue2` int unsigned NOT NULL DEFAULT '0',
  `ConditionValue3` int unsigned NOT NULL DEFAULT '0',
  `NegativeCondition` tinyint unsigned NOT NULL DEFAULT '0',
  `ErrorType` int unsigned NOT NULL DEFAULT '0',
  `ErrorTextId` int unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Condition System'
```

---

## creature

- 存储引擎: InnoDB
- 行数: 148408
- 注释: Creature System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI |  | auto_increment |
| `id1` | `int unsigned` | NO | MUL | 0 |  |
| `id2` | `int unsigned` | NO |  | 0 |  |
| `id3` | `int unsigned` | NO |  | 0 |  |
| `map` | `smallint unsigned` | NO | MUL | 0 |  |
| `zoneId` | `smallint unsigned` | NO |  | 0 |  |
| `areaId` | `smallint unsigned` | NO |  | 0 |  |
| `spawnMask` | `tinyint unsigned` | NO |  | 1 |  |
| `phaseMask` | `int unsigned` | NO |  | 1 |  |
| `equipment_id` | `tinyint` | NO |  | 0 |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |
| `spawntimesecs` | `int unsigned` | NO |  | 120 |  |
| `wander_distance` | `float` | NO |  | 0 |  |
| `currentwaypoint` | `int unsigned` | NO |  | 0 |  |
| `curhealth` | `int unsigned` | NO |  | 1 |  |
| `curmana` | `int unsigned` | NO |  | 0 |  |
| `MovementType` | `tinyint unsigned` | NO |  | 0 |  |
| `npcflag` | `int unsigned` | NO |  | 0 |  |
| `unit_flags` | `int unsigned` | NO |  | 0 |  |
| `dynamicflags` | `int unsigned` | NO |  | 0 |  |
| `ScriptName` | `char(64)` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |
| `CreateObject` | `tinyint unsigned` | NO |  | 0 |  |
| `Comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| idx_map | `map` | 否 | BTREE |
| idx_id | `id1` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature` (
  `guid` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id1` int unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `id2` int unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `id3` int unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `map` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `zoneId` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'Zone Identifier',
  `areaId` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'Area Identifier',
  `spawnMask` tinyint unsigned NOT NULL DEFAULT '1',
  `phaseMask` int unsigned NOT NULL DEFAULT '1',
  `equipment_id` tinyint NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `spawntimesecs` int unsigned NOT NULL DEFAULT '120',
  `wander_distance` float NOT NULL DEFAULT '0',
  `currentwaypoint` int unsigned NOT NULL DEFAULT '0',
  `curhealth` int unsigned NOT NULL DEFAULT '1',
  `curmana` int unsigned NOT NULL DEFAULT '0',
  `MovementType` tinyint unsigned NOT NULL DEFAULT '0',
  `npcflag` int unsigned NOT NULL DEFAULT '0',
  `unit_flags` int unsigned NOT NULL DEFAULT '0',
  `dynamicflags` int unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `VerifiedBuild` int DEFAULT NULL,
  `CreateObject` tinyint unsigned NOT NULL DEFAULT '0',
  `Comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`guid`),
  KEY `idx_map` (`map`),
  KEY `idx_id` (`id1`)
) ENGINE=InnoDB AUTO_INCREMENT=5300679 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature System'
```

---

## creature_addon

- 存储引擎: InnoDB
- 行数: 35375

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `path_id` | `int unsigned` | NO |  | 0 |  |
| `mount` | `int unsigned` | NO |  | 0 |  |
| `bytes1` | `int unsigned` | NO |  | 0 |  |
| `bytes2` | `int unsigned` | NO |  | 0 |  |
| `emote` | `int unsigned` | NO |  | 0 |  |
| `visibilityDistanceType` | `tinyint unsigned` | NO |  | 0 |  |
| `auras` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_addon` (
  `guid` int unsigned NOT NULL DEFAULT '0',
  `path_id` int unsigned NOT NULL DEFAULT '0',
  `mount` int unsigned NOT NULL DEFAULT '0',
  `bytes1` int unsigned NOT NULL DEFAULT '0',
  `bytes2` int unsigned NOT NULL DEFAULT '0',
  `emote` int unsigned NOT NULL DEFAULT '0',
  `visibilityDistanceType` tinyint unsigned NOT NULL DEFAULT '0',
  `auras` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_classlevelstats

- 存储引擎: InnoDB
- 行数: 400

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `level` | `tinyint unsigned` | NO | PRI |  |  |
| `class` | `tinyint unsigned` | NO | PRI |  |  |
| `basehp0` | `int unsigned` | NO |  | 1 |  |
| `basehp1` | `int unsigned` | NO |  | 1 |  |
| `basehp2` | `int unsigned` | NO |  | 1 |  |
| `basemana` | `int unsigned` | NO |  | 0 |  |
| `basearmor` | `int unsigned` | NO |  | 1 |  |
| `attackpower` | `int unsigned` | NO |  | 0 |  |
| `rangedattackpower` | `int unsigned` | NO |  | 0 |  |
| `damage_base` | `float` | NO |  | 0 |  |
| `damage_exp1` | `float` | NO |  | 0 |  |
| `damage_exp2` | `float` | NO |  | 0 |  |
| `Strength` | `int` | NO |  | 0 |  |
| `Agility` | `int` | NO |  | 0 |  |
| `Stamina` | `int` | NO |  | 0 |  |
| `Intellect` | `int` | NO |  | 0 |  |
| `Spirit` | `int` | NO |  | 0 |  |
| `comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `level` | 是 | BTREE |
| PRIMARY | `class` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_classlevelstats` (
  `level` tinyint unsigned NOT NULL,
  `class` tinyint unsigned NOT NULL,
  `basehp0` int unsigned NOT NULL DEFAULT '1',
  `basehp1` int unsigned NOT NULL DEFAULT '1',
  `basehp2` int unsigned NOT NULL DEFAULT '1',
  `basemana` int unsigned NOT NULL DEFAULT '0',
  `basearmor` int unsigned NOT NULL DEFAULT '1',
  `attackpower` int unsigned NOT NULL DEFAULT '0',
  `rangedattackpower` int unsigned NOT NULL DEFAULT '0',
  `damage_base` float NOT NULL DEFAULT '0',
  `damage_exp1` float NOT NULL DEFAULT '0',
  `damage_exp2` float NOT NULL DEFAULT '0',
  `Strength` int NOT NULL DEFAULT '0',
  `Agility` int NOT NULL DEFAULT '0',
  `Stamina` int NOT NULL DEFAULT '0',
  `Intellect` int NOT NULL DEFAULT '0',
  `Spirit` int NOT NULL DEFAULT '0',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`level`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_default_trainer

- 存储引擎: InnoDB
- 行数: 806

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureId` | `int unsigned` | NO | PRI |  |  |
| `TrainerId` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_default_trainer` (
  `CreatureId` int unsigned NOT NULL,
  `TrainerId` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`CreatureId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
```

---

## creature_equip_template

- 存储引擎: InnoDB
- 行数: 10854

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureID` | `int unsigned` | NO | PRI | 0 |  |
| `ID` | `tinyint unsigned` | NO | PRI | 1 |  |
| `ItemID1` | `int unsigned` | NO |  | 0 |  |
| `ItemID2` | `int unsigned` | NO |  | 0 |  |
| `ItemID3` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureID` | 是 | BTREE |
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_equip_template` (
  `CreatureID` int unsigned NOT NULL DEFAULT '0',
  `ID` tinyint unsigned NOT NULL DEFAULT '1',
  `ItemID1` int unsigned NOT NULL DEFAULT '0',
  `ItemID2` int unsigned NOT NULL DEFAULT '0',
  `ItemID3` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`CreatureID`,`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_formations

- 存储引擎: InnoDB
- 行数: 6010

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `leaderGUID` | `int unsigned` | NO |  | 0 |  |
| `memberGUID` | `int unsigned` | NO | PRI | 0 |  |
| `dist` | `float` | NO |  | 0 |  |
| `angle` | `float` | NO |  | 0 |  |
| `groupAI` | `int unsigned` | NO |  | 0 |  |
| `point_1` | `smallint unsigned` | NO |  | 0 |  |
| `point_2` | `smallint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `memberGUID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_formations` (
  `leaderGUID` int unsigned NOT NULL DEFAULT '0',
  `memberGUID` int unsigned NOT NULL DEFAULT '0',
  `dist` float NOT NULL DEFAULT '0',
  `angle` float NOT NULL DEFAULT '0',
  `groupAI` int unsigned NOT NULL DEFAULT '0',
  `point_1` smallint unsigned NOT NULL DEFAULT '0',
  `point_2` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`memberGUID`),
  CONSTRAINT `creature_formations_chk_1` CHECK (((`dist` >= 0) and (`angle` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_immunities

- 存储引擎: InnoDB
- 行数: 456

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI |  |  |
| `SchoolMask` | `tinyint` | NO |  | 0 |  |
| `DispelTypeMask` | `smallint` | NO |  | 0 |  |
| `MechanicsMask` | `bigint` | NO |  | 0 |  |
| `Effects` | `mediumtext` | NO |  |  |  |
| `Auras` | `mediumtext` | NO |  |  |  |
| `ImmuneAoE` | `tinyint(1)` | NO |  | 0 |  |
| `ImmuneChain` | `tinyint(1)` | NO |  | 0 |  |
| `Comment` | `mediumtext` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_immunities` (
  `ID` int NOT NULL,
  `SchoolMask` tinyint NOT NULL DEFAULT '0',
  `DispelTypeMask` smallint NOT NULL DEFAULT '0',
  `MechanicsMask` bigint NOT NULL DEFAULT '0',
  `Effects` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Auras` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ImmuneAoE` tinyint(1) NOT NULL DEFAULT '0',
  `ImmuneChain` tinyint(1) NOT NULL DEFAULT '0',
  `Comment` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_loot_template

- 存储引擎: InnoDB
- 行数: 93051
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO | PRI | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO | PRI | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |
| PRIMARY | `Reference` | 是 | BTREE |
| PRIMARY | `GroupId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`,`Reference`,`GroupId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## creature_model_info

- 存储引擎: InnoDB
- 行数: 23958
- 注释: Creature System (Model related info)

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `DisplayID` | `int unsigned` | NO | PRI | 0 |  |
| `BoundingRadius` | `float` | NO |  | 0 |  |
| `CombatReach` | `float` | NO |  | 0 |  |
| `Gender` | `tinyint unsigned` | NO |  | 2 |  |
| `DisplayID_Other_Gender` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `mediumint` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `DisplayID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_model_info` (
  `DisplayID` int unsigned NOT NULL DEFAULT '0',
  `BoundingRadius` float NOT NULL DEFAULT '0',
  `CombatReach` float NOT NULL DEFAULT '0',
  `Gender` tinyint unsigned NOT NULL DEFAULT '2',
  `DisplayID_Other_Gender` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` mediumint DEFAULT NULL,
  PRIMARY KEY (`DisplayID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature System (Model related info)'
```

---

## creature_movement_override

- 存储引擎: InnoDB
- 行数: 10

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `SpawnId` | `int unsigned` | NO | PRI | 0 |  |
| `Ground` | `tinyint unsigned` | YES |  |  |  |
| `Swim` | `tinyint unsigned` | YES |  |  |  |
| `Flight` | `tinyint unsigned` | YES |  |  |  |
| `Rooted` | `tinyint unsigned` | YES |  |  |  |
| `Chase` | `tinyint unsigned` | YES |  |  |  |
| `Random` | `tinyint unsigned` | YES |  |  |  |
| `InteractionPauseTimer` | `int unsigned` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `SpawnId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_movement_override` (
  `SpawnId` int unsigned NOT NULL DEFAULT '0',
  `Ground` tinyint unsigned DEFAULT NULL,
  `Swim` tinyint unsigned DEFAULT NULL,
  `Flight` tinyint unsigned DEFAULT NULL,
  `Rooted` tinyint unsigned DEFAULT NULL,
  `Chase` tinyint unsigned DEFAULT NULL,
  `Random` tinyint unsigned DEFAULT NULL,
  `InteractionPauseTimer` int unsigned DEFAULT NULL COMMENT 'Time (in milliseconds) during which creature will not move after interaction with player',
  PRIMARY KEY (`SpawnId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_onkill_reputation

- 存储引擎: InnoDB
- 行数: 2070
- 注释: Creature OnKill Reputation gain

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `creature_id` | `int unsigned` | NO | PRI | 0 |  |
| `RewOnKillRepFaction1` | `smallint` | NO |  | 0 |  |
| `RewOnKillRepFaction2` | `smallint` | NO |  | 0 |  |
| `MaxStanding1` | `tinyint` | NO |  | 0 |  |
| `IsTeamAward1` | `tinyint` | NO |  | 0 |  |
| `RewOnKillRepValue1` | `float` | NO |  | 0 |  |
| `MaxStanding2` | `tinyint` | NO |  | 0 |  |
| `IsTeamAward2` | `tinyint` | NO |  | 0 |  |
| `RewOnKillRepValue2` | `float` | NO |  | 0 |  |
| `TeamDependent` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `creature_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_onkill_reputation` (
  `creature_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Creature Identifier',
  `RewOnKillRepFaction1` smallint NOT NULL DEFAULT '0',
  `RewOnKillRepFaction2` smallint NOT NULL DEFAULT '0',
  `MaxStanding1` tinyint NOT NULL DEFAULT '0',
  `IsTeamAward1` tinyint NOT NULL DEFAULT '0',
  `RewOnKillRepValue1` float NOT NULL DEFAULT '0',
  `MaxStanding2` tinyint NOT NULL DEFAULT '0',
  `IsTeamAward2` tinyint NOT NULL DEFAULT '0',
  `RewOnKillRepValue2` float NOT NULL DEFAULT '0',
  `TeamDependent` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`creature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature OnKill Reputation gain'
```

---

## creature_questender

- 存储引擎: InnoDB
- 行数: 7901
- 注释: Creature System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `quest` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `quest` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_questender` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature System'
```

---

## creature_questitem

- 存储引擎: InnoDB
- 行数: 4416

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureEntry` | `int unsigned` | NO | PRI | 0 |  |
| `Idx` | `int unsigned` | NO | PRI | 0 |  |
| `ItemId` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureEntry` | 是 | BTREE |
| PRIMARY | `Idx` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_questitem` (
  `CreatureEntry` int unsigned NOT NULL DEFAULT '0',
  `Idx` int unsigned NOT NULL DEFAULT '0',
  `ItemId` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`CreatureEntry`,`Idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_queststarter

- 存储引擎: InnoDB
- 行数: 7447
- 注释: Creature System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `quest` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `quest` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_queststarter` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `quest` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature System'
```

---

## creature_sparring

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `GUID` | `int unsigned` | NO | PRI |  |  |
| `SparringPCT` | `float` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `GUID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_sparring` (
  `GUID` int unsigned NOT NULL,
  `SparringPCT` float NOT NULL,
  PRIMARY KEY (`GUID`),
  CONSTRAINT `creature_sparring_ibfk_1` FOREIGN KEY (`GUID`) REFERENCES `creature` (`guid`),
  CONSTRAINT `creature_sparring_chk_1` CHECK ((`SparringPCT` between 0 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_summon_groups

- 存储引擎: InnoDB
- 行数: 1256

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `summonerId` | `int unsigned` | NO |  | 0 |  |
| `summonerType` | `tinyint unsigned` | NO |  | 0 |  |
| `groupId` | `tinyint unsigned` | NO |  | 0 |  |
| `entry` | `int unsigned` | NO |  | 0 |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |
| `summonType` | `tinyint unsigned` | NO |  | 0 |  |
| `summonTime` | `int unsigned` | NO |  | 0 |  |
| `Comment` | `varchar(255)` | NO |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `creature_summon_groups` (
  `summonerId` int unsigned NOT NULL DEFAULT '0',
  `summonerType` tinyint unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint unsigned NOT NULL DEFAULT '0',
  `entry` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `summonType` tinyint unsigned NOT NULL DEFAULT '0',
  `summonTime` int unsigned NOT NULL DEFAULT '0',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_template

- 存储引擎: InnoDB
- 行数: 29321
- 注释: Creature System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `difficulty_entry_1` | `int unsigned` | NO |  | 0 |  |
| `difficulty_entry_2` | `int unsigned` | NO |  | 0 |  |
| `difficulty_entry_3` | `int unsigned` | NO |  | 0 |  |
| `KillCredit1` | `int unsigned` | NO |  | 0 |  |
| `KillCredit2` | `int unsigned` | NO |  | 0 |  |
| `name` | `char(100)` | NO | MUL | 0 |  |
| `subname` | `char(100)` | YES |  |  |  |
| `IconName` | `char(100)` | YES |  |  |  |
| `gossip_menu_id` | `int unsigned` | NO |  | 0 |  |
| `minlevel` | `tinyint unsigned` | NO |  | 1 |  |
| `maxlevel` | `tinyint unsigned` | NO |  | 1 |  |
| `exp` | `smallint` | NO |  | 0 |  |
| `faction` | `smallint unsigned` | NO |  | 0 |  |
| `npcflag` | `int unsigned` | NO |  | 0 |  |
| `speed_walk` | `float` | NO |  | 1 |  |
| `speed_run` | `float` | NO |  | 1.14286 |  |
| `speed_swim` | `float` | NO |  | 1 |  |
| `speed_flight` | `float` | NO |  | 1 |  |
| `detection_range` | `float` | NO |  | 20 |  |
| `rank` | `tinyint unsigned` | NO |  | 0 |  |
| `dmgschool` | `tinyint` | NO |  | 0 |  |
| `DamageModifier` | `float` | NO |  | 1 |  |
| `BaseAttackTime` | `int unsigned` | NO |  | 0 |  |
| `RangeAttackTime` | `int unsigned` | NO |  | 0 |  |
| `BaseVariance` | `float` | NO |  | 1 |  |
| `RangeVariance` | `float` | NO |  | 1 |  |
| `unit_class` | `tinyint unsigned` | NO |  | 0 |  |
| `unit_flags` | `int unsigned` | NO |  | 0 |  |
| `unit_flags2` | `int unsigned` | NO |  | 0 |  |
| `dynamicflags` | `int unsigned` | NO |  | 0 |  |
| `family` | `tinyint` | NO |  | 0 |  |
| `type` | `tinyint unsigned` | NO |  | 0 |  |
| `type_flags` | `int unsigned` | NO |  | 0 |  |
| `lootid` | `int unsigned` | NO |  | 0 |  |
| `pickpocketloot` | `int unsigned` | NO |  | 0 |  |
| `skinloot` | `int unsigned` | NO |  | 0 |  |
| `PetSpellDataId` | `int unsigned` | NO |  | 0 |  |
| `VehicleId` | `int unsigned` | NO |  | 0 |  |
| `mingold` | `int unsigned` | NO |  | 0 |  |
| `maxgold` | `int unsigned` | NO |  | 0 |  |
| `AIName` | `char(64)` | NO |  |  |  |
| `MovementType` | `tinyint unsigned` | NO |  | 0 |  |
| `HoverHeight` | `float` | NO |  | 1 |  |
| `HealthModifier` | `float` | NO |  | 1 |  |
| `ManaModifier` | `float` | NO |  | 1 |  |
| `ArmorModifier` | `float` | NO |  | 1 |  |
| `ExperienceModifier` | `float` | NO |  | 1 |  |
| `RacialLeader` | `tinyint unsigned` | NO |  | 0 |  |
| `movementId` | `int unsigned` | NO |  | 0 |  |
| `RegenHealth` | `tinyint unsigned` | NO |  | 1 |  |
| `CreatureImmunitiesId` | `int` | NO |  | 0 |  |
| `flags_extra` | `int unsigned` | NO |  | 0 |  |
| `ScriptName` | `char(64)` | NO |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| idx_name | `name` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_template` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `difficulty_entry_1` int unsigned NOT NULL DEFAULT '0',
  `difficulty_entry_2` int unsigned NOT NULL DEFAULT '0',
  `difficulty_entry_3` int unsigned NOT NULL DEFAULT '0',
  `KillCredit1` int unsigned NOT NULL DEFAULT '0',
  `KillCredit2` int unsigned NOT NULL DEFAULT '0',
  `name` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `subname` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IconName` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gossip_menu_id` int unsigned NOT NULL DEFAULT '0',
  `minlevel` tinyint unsigned NOT NULL DEFAULT '1',
  `maxlevel` tinyint unsigned NOT NULL DEFAULT '1',
  `exp` smallint NOT NULL DEFAULT '0',
  `faction` smallint unsigned NOT NULL DEFAULT '0',
  `npcflag` int unsigned NOT NULL DEFAULT '0',
  `speed_walk` float NOT NULL DEFAULT '1' COMMENT 'Result of 2.5/2.5, most common value',
  `speed_run` float NOT NULL DEFAULT '1.14286' COMMENT 'Result of 8.0/7.0, most common value',
  `speed_swim` float NOT NULL DEFAULT '1',
  `speed_flight` float NOT NULL DEFAULT '1',
  `detection_range` float NOT NULL DEFAULT '20',
  `rank` tinyint unsigned NOT NULL DEFAULT '0',
  `dmgschool` tinyint NOT NULL DEFAULT '0',
  `DamageModifier` float NOT NULL DEFAULT '1',
  `BaseAttackTime` int unsigned NOT NULL DEFAULT '0',
  `RangeAttackTime` int unsigned NOT NULL DEFAULT '0',
  `BaseVariance` float NOT NULL DEFAULT '1',
  `RangeVariance` float NOT NULL DEFAULT '1',
  `unit_class` tinyint unsigned NOT NULL DEFAULT '0',
  `unit_flags` int unsigned NOT NULL DEFAULT '0',
  `unit_flags2` int unsigned NOT NULL DEFAULT '0',
  `dynamicflags` int unsigned NOT NULL DEFAULT '0',
  `family` tinyint NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `type_flags` int unsigned NOT NULL DEFAULT '0',
  `lootid` int unsigned NOT NULL DEFAULT '0',
  `pickpocketloot` int unsigned NOT NULL DEFAULT '0',
  `skinloot` int unsigned NOT NULL DEFAULT '0',
  `PetSpellDataId` int unsigned NOT NULL DEFAULT '0',
  `VehicleId` int unsigned NOT NULL DEFAULT '0',
  `mingold` int unsigned NOT NULL DEFAULT '0',
  `maxgold` int unsigned NOT NULL DEFAULT '0',
  `AIName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `MovementType` tinyint unsigned NOT NULL DEFAULT '0',
  `HoverHeight` float NOT NULL DEFAULT '1',
  `HealthModifier` float NOT NULL DEFAULT '1',
  `ManaModifier` float NOT NULL DEFAULT '1',
  `ArmorModifier` float NOT NULL DEFAULT '1',
  `ExperienceModifier` float NOT NULL DEFAULT '1',
  `RacialLeader` tinyint unsigned NOT NULL DEFAULT '0',
  `movementId` int unsigned NOT NULL DEFAULT '0',
  `RegenHealth` tinyint unsigned NOT NULL DEFAULT '1',
  `CreatureImmunitiesId` int NOT NULL DEFAULT '0',
  `flags_extra` int unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`entry`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature System'
```

---

## creature_template_addon

- 存储引擎: InnoDB
- 行数: 11976

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `path_id` | `int unsigned` | NO |  | 0 |  |
| `mount` | `int unsigned` | NO |  | 0 |  |
| `bytes1` | `int unsigned` | NO |  | 0 |  |
| `bytes2` | `int unsigned` | NO |  | 0 |  |
| `emote` | `int unsigned` | NO |  | 0 |  |
| `visibilityDistanceType` | `tinyint unsigned` | NO |  | 0 |  |
| `auras` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_template_addon` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `path_id` int unsigned NOT NULL DEFAULT '0',
  `mount` int unsigned NOT NULL DEFAULT '0',
  `bytes1` int unsigned NOT NULL DEFAULT '0',
  `bytes2` int unsigned NOT NULL DEFAULT '0',
  `emote` int unsigned NOT NULL DEFAULT '0',
  `visibilityDistanceType` tinyint unsigned NOT NULL DEFAULT '0',
  `auras` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_template_locale

- 存储引擎: InnoDB
- 行数: 197718

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Name` | `text` | YES |  |  |  |
| `Title` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_template_locale` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`entry`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_template_model

- 存储引擎: InnoDB
- 行数: 39207

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureID` | `int unsigned` | NO | PRI |  |  |
| `Idx` | `smallint unsigned` | NO | PRI | 0 |  |
| `CreatureDisplayID` | `int unsigned` | NO |  |  |  |
| `DisplayScale` | `float` | NO |  | 1 |  |
| `Probability` | `float` | NO |  | 0 |  |
| `VerifiedBuild` | `smallint unsigned` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureID` | 是 | BTREE |
| PRIMARY | `Idx` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_template_model` (
  `CreatureID` int unsigned NOT NULL,
  `Idx` smallint unsigned NOT NULL DEFAULT '0',
  `CreatureDisplayID` int unsigned NOT NULL,
  `DisplayScale` float NOT NULL DEFAULT '1',
  `Probability` float NOT NULL DEFAULT '0',
  `VerifiedBuild` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`CreatureID`,`Idx`),
  CONSTRAINT `creature_template_model_chk_1` CHECK ((`Idx` <= 3))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_template_movement

- 存储引擎: InnoDB
- 行数: 4529

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureId` | `int unsigned` | NO | PRI | 0 |  |
| `Ground` | `tinyint unsigned` | YES |  |  |  |
| `Swim` | `tinyint unsigned` | YES |  |  |  |
| `Flight` | `tinyint unsigned` | YES |  |  |  |
| `Rooted` | `tinyint unsigned` | YES |  |  |  |
| `Chase` | `tinyint unsigned` | YES |  |  |  |
| `Random` | `tinyint unsigned` | YES |  |  |  |
| `InteractionPauseTimer` | `int unsigned` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_template_movement` (
  `CreatureId` int unsigned NOT NULL DEFAULT '0',
  `Ground` tinyint unsigned DEFAULT NULL,
  `Swim` tinyint unsigned DEFAULT NULL,
  `Flight` tinyint unsigned DEFAULT NULL,
  `Rooted` tinyint unsigned DEFAULT NULL,
  `Chase` tinyint unsigned DEFAULT NULL,
  `Random` tinyint unsigned DEFAULT NULL,
  `InteractionPauseTimer` int unsigned DEFAULT NULL COMMENT 'Time (in milliseconds) during which creature will not move after interaction with player',
  PRIMARY KEY (`CreatureId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_template_resistance

- 存储引擎: InnoDB
- 行数: 2209

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureID` | `int unsigned` | NO | PRI |  |  |
| `School` | `tinyint unsigned` | NO | PRI |  |  |
| `Resistance` | `smallint` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureID` | 是 | BTREE |
| PRIMARY | `School` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_template_resistance` (
  `CreatureID` int unsigned NOT NULL,
  `School` tinyint unsigned NOT NULL,
  `Resistance` smallint DEFAULT NULL,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`CreatureID`,`School`),
  CONSTRAINT `creature_template_resistance_chk_1` CHECK (((`School` >= 1) and (`School` <= 6)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_template_spell

- 存储引擎: InnoDB
- 行数: 9556

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureID` | `int unsigned` | NO | PRI |  |  |
| `Index` | `tinyint unsigned` | NO | PRI | 0 |  |
| `Spell` | `int unsigned` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureID` | 是 | BTREE |
| PRIMARY | `Index` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_template_spell` (
  `CreatureID` int unsigned NOT NULL,
  `Index` tinyint unsigned NOT NULL DEFAULT '0',
  `Spell` int unsigned DEFAULT NULL,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`CreatureID`,`Index`),
  CONSTRAINT `creature_template_spell_chk_1` CHECK (((`Index` >= 0) and (`Index` <= 7)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_text

- 存储引擎: InnoDB
- 行数: 18895

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureID` | `int unsigned` | NO | PRI | 0 |  |
| `GroupID` | `tinyint unsigned` | NO | PRI | 0 |  |
| `ID` | `tinyint unsigned` | NO | PRI | 0 |  |
| `Text` | `longtext` | YES |  |  |  |
| `Type` | `tinyint unsigned` | NO |  | 0 |  |
| `Language` | `tinyint` | NO |  | 0 |  |
| `Probability` | `float` | NO |  | 0 |  |
| `Emote` | `int unsigned` | NO |  | 0 |  |
| `Duration` | `int unsigned` | NO |  | 0 |  |
| `Sound` | `int unsigned` | NO |  | 0 |  |
| `BroadcastTextId` | `int` | NO |  | 0 |  |
| `TextRange` | `tinyint unsigned` | NO |  | 0 |  |
| `comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureID` | 是 | BTREE |
| PRIMARY | `GroupID` | 是 | BTREE |
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_text` (
  `CreatureID` int unsigned NOT NULL DEFAULT '0',
  `GroupID` tinyint unsigned NOT NULL DEFAULT '0',
  `ID` tinyint unsigned NOT NULL DEFAULT '0',
  `Text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Type` tinyint unsigned NOT NULL DEFAULT '0',
  `Language` tinyint NOT NULL DEFAULT '0',
  `Probability` float NOT NULL DEFAULT '0',
  `Emote` int unsigned NOT NULL DEFAULT '0',
  `Duration` int unsigned NOT NULL DEFAULT '0',
  `Sound` int unsigned NOT NULL DEFAULT '0',
  `BroadcastTextId` int NOT NULL DEFAULT '0',
  `TextRange` tinyint unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`CreatureID`,`GroupID`,`ID`),
  CONSTRAINT `creature_text_chk_1` CHECK ((`Probability` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creature_text_locale

- 存储引擎: InnoDB
- 行数: 14868

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `CreatureID` | `int unsigned` | NO | PRI | 0 |  |
| `GroupID` | `tinyint unsigned` | NO | PRI | 0 |  |
| `ID` | `tinyint unsigned` | NO | PRI | 0 |  |
| `Locale` | `varchar(4)` | NO | PRI |  |  |
| `Text` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `CreatureID` | 是 | BTREE |
| PRIMARY | `GroupID` | 是 | BTREE |
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `Locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creature_text_locale` (
  `CreatureID` int unsigned NOT NULL DEFAULT '0',
  `GroupID` tinyint unsigned NOT NULL DEFAULT '0',
  `ID` tinyint unsigned NOT NULL DEFAULT '0',
  `Locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`CreatureID`,`GroupID`,`ID`,`Locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creaturedisplayinfo_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ModelID` | `int` | NO |  | 0 |  |
| `SoundID` | `int` | NO |  | 0 |  |
| `ExtendedDisplayInfoID` | `int` | NO |  | 0 |  |
| `CreatureModelScale` | `float` | NO |  | 0 |  |
| `CreatureModelAlpha` | `int` | NO |  | 0 |  |
| `TextureVariation_1` | `varchar(100)` | YES |  |  |  |
| `TextureVariation_2` | `varchar(100)` | YES |  |  |  |
| `TextureVariation_3` | `varchar(100)` | YES |  |  |  |
| `PortraitTextureName` | `varchar(100)` | YES |  |  |  |
| `BloodLevel` | `int` | NO |  | 0 |  |
| `BloodID` | `int` | NO |  | 0 |  |
| `NPCSoundID` | `int` | NO |  | 0 |  |
| `ParticleColorID` | `int` | NO |  | 0 |  |
| `CreatureGeosetData` | `int` | NO |  | 0 |  |
| `ObjectEffectPackageID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creaturedisplayinfo_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ModelID` int NOT NULL DEFAULT '0',
  `SoundID` int NOT NULL DEFAULT '0',
  `ExtendedDisplayInfoID` int NOT NULL DEFAULT '0',
  `CreatureModelScale` float NOT NULL DEFAULT '0',
  `CreatureModelAlpha` int NOT NULL DEFAULT '0',
  `TextureVariation_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TextureVariation_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TextureVariation_3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PortraitTextureName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BloodLevel` int NOT NULL DEFAULT '0',
  `BloodID` int NOT NULL DEFAULT '0',
  `NPCSoundID` int NOT NULL DEFAULT '0',
  `ParticleColorID` int NOT NULL DEFAULT '0',
  `CreatureGeosetData` int NOT NULL DEFAULT '0',
  `ObjectEffectPackageID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creaturedisplayinfoextra_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `DisplayRaceID` | `int unsigned` | NO |  | 0 |  |
| `DisplaySexID` | `int unsigned` | NO |  | 0 |  |
| `SkinID` | `int unsigned` | NO |  | 0 |  |
| `FaceID` | `int unsigned` | NO |  | 0 |  |
| `HairStyleID` | `int unsigned` | NO |  | 0 |  |
| `HairColorID` | `int unsigned` | NO |  | 0 |  |
| `FacialHairID` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay1` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay2` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay3` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay4` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay5` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay6` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay7` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay8` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay9` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay10` | `int unsigned` | NO |  | 0 |  |
| `NPCItemDisplay11` | `int unsigned` | NO |  | 0 |  |
| `Flags` | `int unsigned` | NO |  | 0 |  |
| `BakeName` | `varchar(100)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creaturedisplayinfoextra_dbc` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `DisplayRaceID` int unsigned NOT NULL DEFAULT '0',
  `DisplaySexID` int unsigned NOT NULL DEFAULT '0',
  `SkinID` int unsigned NOT NULL DEFAULT '0',
  `FaceID` int unsigned NOT NULL DEFAULT '0',
  `HairStyleID` int unsigned NOT NULL DEFAULT '0',
  `HairColorID` int unsigned NOT NULL DEFAULT '0',
  `FacialHairID` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay1` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay2` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay3` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay4` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay5` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay6` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay7` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay8` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay9` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay10` int unsigned NOT NULL DEFAULT '0',
  `NPCItemDisplay11` int unsigned NOT NULL DEFAULT '0',
  `Flags` int unsigned NOT NULL DEFAULT '0',
  `BakeName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creaturefamily_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `MinScale` | `float` | NO |  | 0 |  |
| `MinScaleLevel` | `int` | NO |  | 0 |  |
| `MaxScale` | `float` | NO |  | 0 |  |
| `MaxScaleLevel` | `int` | NO |  | 0 |  |
| `SkillLine_1` | `int` | NO |  | 0 |  |
| `SkillLine_2` | `int` | NO |  | 0 |  |
| `PetFoodMask` | `int` | NO |  | 0 |  |
| `PetTalentType` | `int` | NO |  | 0 |  |
| `CategoryEnumID` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `IconFile` | `varchar(100)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creaturefamily_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `MinScale` float NOT NULL DEFAULT '0',
  `MinScaleLevel` int NOT NULL DEFAULT '0',
  `MaxScale` float NOT NULL DEFAULT '0',
  `MaxScaleLevel` int NOT NULL DEFAULT '0',
  `SkillLine_1` int NOT NULL DEFAULT '0',
  `SkillLine_2` int NOT NULL DEFAULT '0',
  `PetFoodMask` int NOT NULL DEFAULT '0',
  `PetTalentType` int NOT NULL DEFAULT '0',
  `CategoryEnumID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `IconFile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creaturemodeldata_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `ModelName` | `varchar(100)` | YES |  |  |  |
| `SizeClass` | `int` | NO |  | 0 |  |
| `ModelScale` | `float` | NO |  | 0 |  |
| `BloodID` | `int` | NO |  | 0 |  |
| `FootprintTextureID` | `int` | NO |  | 0 |  |
| `FootprintTextureLength` | `float` | NO |  | 0 |  |
| `FootprintTextureWidth` | `float` | NO |  | 0 |  |
| `FootprintParticleScale` | `float` | NO |  | 0 |  |
| `FoleyMaterialID` | `int` | NO |  | 0 |  |
| `FootstepShakeSize` | `int` | NO |  | 0 |  |
| `DeathThudShakeSize` | `int` | NO |  | 0 |  |
| `SoundID` | `int` | NO |  | 0 |  |
| `CollisionWidth` | `float` | NO |  | 0 |  |
| `CollisionHeight` | `float` | NO |  | 0 |  |
| `MountHeight` | `float` | NO |  | 0 |  |
| `GeoBoxMinX` | `float` | NO |  | 0 |  |
| `GeoBoxMinY` | `float` | NO |  | 0 |  |
| `GeoBoxMinZ` | `float` | NO |  | 0 |  |
| `GeoBoxMaxX` | `float` | NO |  | 0 |  |
| `GeoBoxMaxY` | `float` | NO |  | 0 |  |
| `GeoBoxMaxZ` | `float` | NO |  | 0 |  |
| `WorldEffectScale` | `float` | NO |  | 0 |  |
| `AttachedEffectScale` | `float` | NO |  | 0 |  |
| `MissileCollisionRadius` | `float` | NO |  | 0 |  |
| `MissileCollisionPush` | `float` | NO |  | 0 |  |
| `MissileCollisionRaise` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creaturemodeldata_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `ModelName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SizeClass` int NOT NULL DEFAULT '0',
  `ModelScale` float NOT NULL DEFAULT '0',
  `BloodID` int NOT NULL DEFAULT '0',
  `FootprintTextureID` int NOT NULL DEFAULT '0',
  `FootprintTextureLength` float NOT NULL DEFAULT '0',
  `FootprintTextureWidth` float NOT NULL DEFAULT '0',
  `FootprintParticleScale` float NOT NULL DEFAULT '0',
  `FoleyMaterialID` int NOT NULL DEFAULT '0',
  `FootstepShakeSize` int NOT NULL DEFAULT '0',
  `DeathThudShakeSize` int NOT NULL DEFAULT '0',
  `SoundID` int NOT NULL DEFAULT '0',
  `CollisionWidth` float NOT NULL DEFAULT '0',
  `CollisionHeight` float NOT NULL DEFAULT '0',
  `MountHeight` float NOT NULL DEFAULT '0',
  `GeoBoxMinX` float NOT NULL DEFAULT '0',
  `GeoBoxMinY` float NOT NULL DEFAULT '0',
  `GeoBoxMinZ` float NOT NULL DEFAULT '0',
  `GeoBoxMaxX` float NOT NULL DEFAULT '0',
  `GeoBoxMaxY` float NOT NULL DEFAULT '0',
  `GeoBoxMaxZ` float NOT NULL DEFAULT '0',
  `WorldEffectScale` float NOT NULL DEFAULT '0',
  `AttachedEffectScale` float NOT NULL DEFAULT '0',
  `MissileCollisionRadius` float NOT NULL DEFAULT '0',
  `MissileCollisionPush` float NOT NULL DEFAULT '0',
  `MissileCollisionRaise` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creaturespelldata_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Spells_1` | `int` | NO |  | 0 |  |
| `Spells_2` | `int` | NO |  | 0 |  |
| `Spells_3` | `int` | NO |  | 0 |  |
| `Spells_4` | `int` | NO |  | 0 |  |
| `Availability_1` | `int` | NO |  | 0 |  |
| `Availability_2` | `int` | NO |  | 0 |  |
| `Availability_3` | `int` | NO |  | 0 |  |
| `Availability_4` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creaturespelldata_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Spells_1` int NOT NULL DEFAULT '0',
  `Spells_2` int NOT NULL DEFAULT '0',
  `Spells_3` int NOT NULL DEFAULT '0',
  `Spells_4` int NOT NULL DEFAULT '0',
  `Availability_1` int NOT NULL DEFAULT '0',
  `Availability_2` int NOT NULL DEFAULT '0',
  `Availability_3` int NOT NULL DEFAULT '0',
  `Availability_4` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## creaturetype_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `creaturetype_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## currencytypes_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ItemID` | `int` | NO |  | 0 |  |
| `CategoryID` | `int` | NO |  | 0 |  |
| `BitIndex` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `currencytypes_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ItemID` int NOT NULL DEFAULT '0',
  `CategoryID` int NOT NULL DEFAULT '0',
  `BitIndex` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## destructiblemodeldata_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `State0Wmo` | `int` | NO |  | 0 |  |
| `State0DestructionDoodadSet` | `int` | NO |  | 0 |  |
| `State0ImpactEffectDoodadSet` | `int` | NO |  | 0 |  |
| `State0AmbientDoodadSet` | `int` | NO |  | 0 |  |
| `State1Wmo` | `int` | NO |  | 0 |  |
| `State1DestructionDoodadSet` | `int` | NO |  | 0 |  |
| `State1ImpactEffectDoodadSet` | `int` | NO |  | 0 |  |
| `State1AmbientDoodadSet` | `int` | NO |  | 0 |  |
| `State2Wmo` | `int` | NO |  | 0 |  |
| `State2DestructionDoodadSet` | `int` | NO |  | 0 |  |
| `State2ImpactEffectDoodadSet` | `int` | NO |  | 0 |  |
| `State2AmbientDoodadSet` | `int` | NO |  | 0 |  |
| `State3Wmo` | `int` | NO |  | 0 |  |
| `State3DestructionDoodadSet` | `int` | NO |  | 0 |  |
| `State3ImpactEffectDoodadSet` | `int` | NO |  | 0 |  |
| `State3AmbientDoodadSet` | `int` | NO |  | 0 |  |
| `Field17` | `int` | NO |  | 0 |  |
| `Field18` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `destructiblemodeldata_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `State0Wmo` int NOT NULL DEFAULT '0',
  `State0DestructionDoodadSet` int NOT NULL DEFAULT '0',
  `State0ImpactEffectDoodadSet` int NOT NULL DEFAULT '0',
  `State0AmbientDoodadSet` int NOT NULL DEFAULT '0',
  `State1Wmo` int NOT NULL DEFAULT '0',
  `State1DestructionDoodadSet` int NOT NULL DEFAULT '0',
  `State1ImpactEffectDoodadSet` int NOT NULL DEFAULT '0',
  `State1AmbientDoodadSet` int NOT NULL DEFAULT '0',
  `State2Wmo` int NOT NULL DEFAULT '0',
  `State2DestructionDoodadSet` int NOT NULL DEFAULT '0',
  `State2ImpactEffectDoodadSet` int NOT NULL DEFAULT '0',
  `State2AmbientDoodadSet` int NOT NULL DEFAULT '0',
  `State3Wmo` int NOT NULL DEFAULT '0',
  `State3DestructionDoodadSet` int NOT NULL DEFAULT '0',
  `State3ImpactEffectDoodadSet` int NOT NULL DEFAULT '0',
  `State3AmbientDoodadSet` int NOT NULL DEFAULT '0',
  `Field17` int NOT NULL DEFAULT '0',
  `Field18` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## disables

- 存储引擎: InnoDB
- 行数: 893

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `sourceType` | `int unsigned` | NO | PRI |  |  |
| `entry` | `int unsigned` | NO | PRI |  |  |
| `flags` | `tinyint unsigned` | NO |  | 0 |  |
| `params_0` | `varchar(255)` | NO |  |  |  |
| `params_1` | `varchar(255)` | NO |  |  |  |
| `comment` | `varchar(255)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `sourceType` | 是 | BTREE |
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `disables` (
  `sourceType` int unsigned NOT NULL,
  `entry` int unsigned NOT NULL,
  `flags` tinyint unsigned NOT NULL DEFAULT '0',
  `params_0` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `params_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`sourceType`,`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## disenchant_loot_template

- 存储引擎: InnoDB
- 行数: 123
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `disenchant_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## dungeon_access_requirements

- 存储引擎: InnoDB
- 行数: 35
- 注释: Add (multiple) requirements before being able to enter a dungeon/raid

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `dungeon_access_id` | `tinyint unsigned` | NO | PRI |  |  |
| `requirement_type` | `tinyint unsigned` | NO | PRI |  |  |
| `requirement_id` | `int unsigned` | NO | PRI |  |  |
| `requirement_note` | `varchar(255)` | YES |  |  |  |
| `faction` | `tinyint unsigned` | NO |  | 2 |  |
| `priority` | `tinyint unsigned` | YES |  |  |  |
| `leader_only` | `tinyint` | NO |  | 0 |  |
| `comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `dungeon_access_id` | 是 | BTREE |
| PRIMARY | `requirement_type` | 是 | BTREE |
| PRIMARY | `requirement_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `dungeon_access_requirements` (
  `dungeon_access_id` tinyint unsigned NOT NULL COMMENT 'ID from dungeon_access_template',
  `requirement_type` tinyint unsigned NOT NULL COMMENT '0 = achiev, 1 = quest, 2 = item',
  `requirement_id` int unsigned NOT NULL COMMENT 'Achiev/quest/item ID',
  `requirement_note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Optional msg shown ingame to player if he cannot enter. You can add extra info',
  `faction` tinyint unsigned NOT NULL DEFAULT '2' COMMENT '0 = Alliance, 1 = Horde, 2 = Both factions',
  `priority` tinyint unsigned DEFAULT NULL COMMENT 'Priority order for the requirement, sorted by type. 0 is the highest priority',
  `leader_only` tinyint NOT NULL DEFAULT '0' COMMENT '0 = check the requirement for the player trying to enter, 1 = check the requirement for the party leader',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`dungeon_access_id`,`requirement_type`,`requirement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Add (multiple) requirements before being able to enter a dungeon/raid'
```

---

## dungeon_access_template

- 存储引擎: InnoDB
- 行数: 121
- 注释: Dungeon/raid access template and single requirements

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `tinyint unsigned` | NO | PRI |  | auto_increment |
| `map_id` | `int unsigned` | YES | MUL |  |  |
| `difficulty` | `tinyint unsigned` | NO |  | 0 |  |
| `min_level` | `tinyint unsigned` | YES |  |  |  |
| `max_level` | `tinyint unsigned` | YES |  |  |  |
| `min_avg_item_level` | `smallint unsigned` | YES |  |  |  |
| `comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| FK_dungeon_access_template__instance_template | `map_id` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `dungeon_access_template` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT COMMENT 'The dungeon template ID',
  `map_id` int unsigned DEFAULT NULL COMMENT 'Map ID from instance_template',
  `difficulty` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '5 man: 0 = normal, 1 = heroic, 2 = epic (not implemented) | 10 man: 0 = normal, 2 = heroic | 25 man: 1 = normal, 3 = heroic',
  `min_level` tinyint unsigned DEFAULT NULL,
  `max_level` tinyint unsigned DEFAULT NULL,
  `min_avg_item_level` smallint unsigned DEFAULT NULL COMMENT 'Min average ilvl required to enter',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Dungeon Name 5/10/25/40 man - Normal/Heroic',
  PRIMARY KEY (`id`),
  KEY `FK_dungeon_access_template__instance_template` (`map_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Dungeon/raid access template and single requirements'
```

---

## dungeonencounter_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `MapID` | `int` | NO |  | 0 |  |
| `Difficulty` | `int` | NO |  | 0 |  |
| `OrderIndex` | `int` | NO |  | 0 |  |
| `Bit` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `SpellIconID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `dungeonencounter_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `MapID` int NOT NULL DEFAULT '0',
  `Difficulty` int NOT NULL DEFAULT '0',
  `OrderIndex` int NOT NULL DEFAULT '0',
  `Bit` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `SpellIconID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## durabilitycosts_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `WeaponSubClassCost_1` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_2` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_3` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_4` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_5` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_6` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_7` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_8` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_9` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_10` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_11` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_12` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_13` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_14` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_15` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_16` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_17` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_18` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_19` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_20` | `int` | NO |  | 0 |  |
| `WeaponSubClassCost_21` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_1` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_2` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_3` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_4` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_5` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_6` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_7` | `int` | NO |  | 0 |  |
| `ArmorSubClassCost_8` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `durabilitycosts_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_1` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_2` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_3` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_4` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_5` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_6` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_7` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_8` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_9` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_10` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_11` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_12` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_13` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_14` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_15` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_16` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_17` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_18` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_19` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_20` int NOT NULL DEFAULT '0',
  `WeaponSubClassCost_21` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_1` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_2` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_3` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_4` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_5` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_6` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_7` int NOT NULL DEFAULT '0',
  `ArmorSubClassCost_8` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## durabilityquality_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `durabilityquality_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## emotes_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `EmoteSlashCommand` | `varchar(100)` | YES |  |  |  |
| `AnimID` | `int` | NO |  | 0 |  |
| `EmoteFlags` | `int` | NO |  | 0 |  |
| `EmoteSpecProc` | `int` | NO |  | 0 |  |
| `EmoteSpecProcParam` | `int` | NO |  | 0 |  |
| `EventSoundID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `emotes_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `EmoteSlashCommand` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AnimID` int NOT NULL DEFAULT '0',
  `EmoteFlags` int NOT NULL DEFAULT '0',
  `EmoteSpecProc` int NOT NULL DEFAULT '0',
  `EmoteSpecProcParam` int NOT NULL DEFAULT '0',
  `EventSoundID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## emotestext_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name` | `varchar(100)` | YES |  |  |  |
| `EmoteID` | `int` | NO |  | 0 |  |
| `EmoteText_1` | `int` | NO |  | 0 |  |
| `EmoteText_2` | `int` | NO |  | 0 |  |
| `EmoteText_3` | `int` | NO |  | 0 |  |
| `EmoteText_4` | `int` | NO |  | 0 |  |
| `EmoteText_5` | `int` | NO |  | 0 |  |
| `EmoteText_6` | `int` | NO |  | 0 |  |
| `EmoteText_7` | `int` | NO |  | 0 |  |
| `EmoteText_8` | `int` | NO |  | 0 |  |
| `EmoteText_9` | `int` | NO |  | 0 |  |
| `EmoteText_10` | `int` | NO |  | 0 |  |
| `EmoteText_11` | `int` | NO |  | 0 |  |
| `EmoteText_12` | `int` | NO |  | 0 |  |
| `EmoteText_13` | `int` | NO |  | 0 |  |
| `EmoteText_14` | `int` | NO |  | 0 |  |
| `EmoteText_15` | `int` | NO |  | 0 |  |
| `EmoteText_16` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `emotestext_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmoteID` int NOT NULL DEFAULT '0',
  `EmoteText_1` int NOT NULL DEFAULT '0',
  `EmoteText_2` int NOT NULL DEFAULT '0',
  `EmoteText_3` int NOT NULL DEFAULT '0',
  `EmoteText_4` int NOT NULL DEFAULT '0',
  `EmoteText_5` int NOT NULL DEFAULT '0',
  `EmoteText_6` int NOT NULL DEFAULT '0',
  `EmoteText_7` int NOT NULL DEFAULT '0',
  `EmoteText_8` int NOT NULL DEFAULT '0',
  `EmoteText_9` int NOT NULL DEFAULT '0',
  `EmoteText_10` int NOT NULL DEFAULT '0',
  `EmoteText_11` int NOT NULL DEFAULT '0',
  `EmoteText_12` int NOT NULL DEFAULT '0',
  `EmoteText_13` int NOT NULL DEFAULT '0',
  `EmoteText_14` int NOT NULL DEFAULT '0',
  `EmoteText_15` int NOT NULL DEFAULT '0',
  `EmoteText_16` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## event_scripts

- 存储引擎: InnoDB
- 行数: 461

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO |  | 0 |  |
| `delay` | `int unsigned` | NO |  | 0 |  |
| `command` | `int unsigned` | NO |  | 0 |  |
| `datalong` | `int unsigned` | NO |  | 0 |  |
| `datalong2` | `int unsigned` | NO |  | 0 |  |
| `dataint` | `int` | NO |  | 0 |  |
| `x` | `float` | NO |  | 0 |  |
| `y` | `float` | NO |  | 0 |  |
| `z` | `float` | NO |  | 0 |  |
| `o` | `float` | NO |  | 0 |  |

### CREATE TABLE

```sql
CREATE TABLE `event_scripts` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `delay` int unsigned NOT NULL DEFAULT '0',
  `command` int unsigned NOT NULL DEFAULT '0',
  `datalong` int unsigned NOT NULL DEFAULT '0',
  `datalong2` int unsigned NOT NULL DEFAULT '0',
  `dataint` int NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## exploration_basexp

- 存储引擎: InnoDB
- 行数: 80
- 注释: Exploration System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `level` | `tinyint unsigned` | NO | PRI | 0 |  |
| `basexp` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `level` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `exploration_basexp` (
  `level` tinyint unsigned NOT NULL DEFAULT '0',
  `basexp` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Exploration System'
```

---

## faction_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ReputationIndex` | `int` | NO |  | 0 |  |
| `ReputationRaceMask_1` | `int` | NO |  | 0 |  |
| `ReputationRaceMask_2` | `int` | NO |  | 0 |  |
| `ReputationRaceMask_3` | `int` | NO |  | 0 |  |
| `ReputationRaceMask_4` | `int` | NO |  | 0 |  |
| `ReputationClassMask_1` | `int` | NO |  | 0 |  |
| `ReputationClassMask_2` | `int` | NO |  | 0 |  |
| `ReputationClassMask_3` | `int` | NO |  | 0 |  |
| `ReputationClassMask_4` | `int` | NO |  | 0 |  |
| `ReputationBase_1` | `int` | NO |  | 0 |  |
| `ReputationBase_2` | `int` | NO |  | 0 |  |
| `ReputationBase_3` | `int` | NO |  | 0 |  |
| `ReputationBase_4` | `int` | NO |  | 0 |  |
| `ReputationFlags_1` | `int` | NO |  | 0 |  |
| `ReputationFlags_2` | `int` | NO |  | 0 |  |
| `ReputationFlags_3` | `int` | NO |  | 0 |  |
| `ReputationFlags_4` | `int` | NO |  | 0 |  |
| `ParentFactionID` | `int` | NO |  | 0 |  |
| `ParentFactionMod_1` | `float` | NO |  | 0 |  |
| `ParentFactionMod_2` | `float` | NO |  | 0 |  |
| `ParentFactionCap_1` | `int` | NO |  | 0 |  |
| `ParentFactionCap_2` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Description_Lang_enUS` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_enGB` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_koKR` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_frFR` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_deDE` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_enCN` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_zhCN` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_enTW` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_zhTW` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_esES` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_esMX` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_ruRU` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_ptPT` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_ptBR` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_itIT` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `faction_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ReputationIndex` int NOT NULL DEFAULT '0',
  `ReputationRaceMask_1` int NOT NULL DEFAULT '0',
  `ReputationRaceMask_2` int NOT NULL DEFAULT '0',
  `ReputationRaceMask_3` int NOT NULL DEFAULT '0',
  `ReputationRaceMask_4` int NOT NULL DEFAULT '0',
  `ReputationClassMask_1` int NOT NULL DEFAULT '0',
  `ReputationClassMask_2` int NOT NULL DEFAULT '0',
  `ReputationClassMask_3` int NOT NULL DEFAULT '0',
  `ReputationClassMask_4` int NOT NULL DEFAULT '0',
  `ReputationBase_1` int NOT NULL DEFAULT '0',
  `ReputationBase_2` int NOT NULL DEFAULT '0',
  `ReputationBase_3` int NOT NULL DEFAULT '0',
  `ReputationBase_4` int NOT NULL DEFAULT '0',
  `ReputationFlags_1` int NOT NULL DEFAULT '0',
  `ReputationFlags_2` int NOT NULL DEFAULT '0',
  `ReputationFlags_3` int NOT NULL DEFAULT '0',
  `ReputationFlags_4` int NOT NULL DEFAULT '0',
  `ParentFactionID` int NOT NULL DEFAULT '0',
  `ParentFactionMod_1` float NOT NULL DEFAULT '0',
  `ParentFactionMod_2` float NOT NULL DEFAULT '0',
  `ParentFactionCap_1` int NOT NULL DEFAULT '0',
  `ParentFactionCap_2` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Description_Lang_enUS` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enGB` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_koKR` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_frFR` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_deDE` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enCN` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhCN` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enTW` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhTW` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esES` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esMX` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ruRU` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptPT` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptBR` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_itIT` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## factiontemplate_dbc

- 存储引擎: InnoDB
- 行数: 841

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Faction` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `FactionGroup` | `int` | NO |  | 0 |  |
| `FriendGroup` | `int` | NO |  | 0 |  |
| `EnemyGroup` | `int` | NO |  | 0 |  |
| `Enemies_1` | `int` | NO |  | 0 |  |
| `Enemies_2` | `int` | NO |  | 0 |  |
| `Enemies_3` | `int` | NO |  | 0 |  |
| `Enemies_4` | `int` | NO |  | 0 |  |
| `Friend_1` | `int` | NO |  | 0 |  |
| `Friend_2` | `int` | NO |  | 0 |  |
| `Friend_3` | `int` | NO |  | 0 |  |
| `Friend_4` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `factiontemplate_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Faction` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `FactionGroup` int NOT NULL DEFAULT '0',
  `FriendGroup` int NOT NULL DEFAULT '0',
  `EnemyGroup` int NOT NULL DEFAULT '0',
  `Enemies_1` int NOT NULL DEFAULT '0',
  `Enemies_2` int NOT NULL DEFAULT '0',
  `Enemies_3` int NOT NULL DEFAULT '0',
  `Enemies_4` int NOT NULL DEFAULT '0',
  `Friend_1` int NOT NULL DEFAULT '0',
  `Friend_2` int NOT NULL DEFAULT '0',
  `Friend_3` int NOT NULL DEFAULT '0',
  `Friend_4` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## fishing_loot_template

- 存储引擎: InnoDB
- 行数: 251
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `fishing_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## game_event

- 存储引擎: InnoDB
- 行数: 181

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO | PRI |  |  |
| `start_time` | `timestamp` | YES |  | 2000-01-01 18:00:00 |  |
| `end_time` | `timestamp` | YES |  | 2000-01-01 18:00:00 |  |
| `occurence` | `bigint unsigned` | NO |  | 5184000 |  |
| `length` | `bigint unsigned` | NO |  | 2592000 |  |
| `holiday` | `int unsigned` | NO |  | 0 |  |
| `holidayStage` | `tinyint unsigned` | NO |  | 0 |  |
| `description` | `varchar(255)` | YES |  |  |  |
| `world_event` | `tinyint unsigned` | NO |  | 0 |  |
| `announce` | `tinyint unsigned` | NO |  | 2 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `eventEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `start_time` timestamp NULL DEFAULT '2000-01-01 18:00:00' COMMENT 'Absolute start date, the event will never start before',
  `end_time` timestamp NULL DEFAULT '2000-01-01 18:00:00' COMMENT 'Absolute end date, the event will never start after',
  `occurence` bigint unsigned NOT NULL DEFAULT '5184000' COMMENT 'Delay in minutes between occurences of the event',
  `length` bigint unsigned NOT NULL DEFAULT '2592000' COMMENT 'Length in minutes of the event',
  `holiday` int unsigned NOT NULL DEFAULT '0' COMMENT 'Client side holiday id',
  `holidayStage` tinyint unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Description of the event displayed in console',
  `world_event` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0 if normal event, 1 if world event',
  `announce` tinyint unsigned NOT NULL DEFAULT '2' COMMENT '0 dont announce, 1 announce, 2 value from config',
  PRIMARY KEY (`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_arena_seasons

- 存储引擎: InnoDB
- 行数: 8

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO | PRI |  |  |
| `season` | `tinyint unsigned` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| season | `season` | 是 | BTREE |
| season | `eventEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_arena_seasons` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `season` tinyint unsigned NOT NULL COMMENT 'Arena season number',
  UNIQUE KEY `season` (`season`,`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_battleground_holiday

- 存储引擎: InnoDB
- 行数: 6

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO | PRI |  |  |
| `bgflag` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `eventEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_battleground_holiday` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `bgflag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_condition

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO | PRI |  |  |
| `condition_id` | `int unsigned` | NO | PRI | 0 |  |
| `req_num` | `float` | YES |  | 0 |  |
| `max_world_state_field` | `smallint unsigned` | NO |  | 0 |  |
| `done_world_state_field` | `smallint unsigned` | NO |  | 0 |  |
| `description` | `varchar(25)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `eventEntry` | 是 | BTREE |
| PRIMARY | `condition_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_condition` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `condition_id` int unsigned NOT NULL DEFAULT '0',
  `req_num` float DEFAULT '0',
  `max_world_state_field` smallint unsigned NOT NULL DEFAULT '0',
  `done_world_state_field` smallint unsigned NOT NULL DEFAULT '0',
  `description` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`eventEntry`,`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_creature

- 存储引擎: InnoDB
- 行数: 11779

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `smallint` | NO | PRI |  |  |
| `guid` | `int unsigned` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| PRIMARY | `eventEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_creature` (
  `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.',
  `guid` int unsigned NOT NULL,
  PRIMARY KEY (`guid`,`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_creature_quest

- 存储引擎: InnoDB
- 行数: 242

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO |  |  |  |
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `quest` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `quest` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_creature_quest` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event.',
  `id` int unsigned NOT NULL DEFAULT '0',
  `quest` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_gameobject

- 存储引擎: InnoDB
- 行数: 31463

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `smallint` | NO | PRI |  |  |
| `guid` | `int unsigned` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| PRIMARY | `eventEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_gameobject` (
  `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.',
  `guid` int unsigned NOT NULL,
  PRIMARY KEY (`guid`,`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_gameobject_quest

- 存储引擎: InnoDB
- 行数: 78

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO | PRI |  |  |
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `quest` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `quest` | 是 | BTREE |
| PRIMARY | `eventEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_gameobject_quest` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `id` int unsigned NOT NULL DEFAULT '0',
  `quest` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`quest`,`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_model_equip

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO |  |  |  |
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `modelid` | `int unsigned` | NO |  | 0 |  |
| `equipment_id` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_model_equip` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event.',
  `guid` int unsigned NOT NULL DEFAULT '0',
  `modelid` int unsigned NOT NULL DEFAULT '0',
  `equipment_id` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_npc_vendor

- 存储引擎: InnoDB
- 行数: 129

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `smallint` | NO | PRI |  |  |
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `slot` | `smallint` | NO | MUL | 0 |  |
| `item` | `int unsigned` | NO | PRI | 0 |  |
| `maxcount` | `int unsigned` | NO |  | 0 |  |
| `incrtime` | `int unsigned` | NO |  | 0 |  |
| `ExtendedCost` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `eventEntry` | 是 | BTREE |
| PRIMARY | `guid` | 是 | BTREE |
| PRIMARY | `item` | 是 | BTREE |
| slot | `slot` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_npc_vendor` (
  `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event.',
  `guid` int unsigned NOT NULL DEFAULT '0',
  `slot` smallint NOT NULL DEFAULT '0',
  `item` int unsigned NOT NULL DEFAULT '0',
  `maxcount` int unsigned NOT NULL DEFAULT '0',
  `incrtime` int unsigned NOT NULL DEFAULT '0',
  `ExtendedCost` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventEntry`,`guid`,`item`) USING BTREE,
  KEY `slot` (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_npcflag

- 存储引擎: InnoDB
- 行数: 5

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO | PRI |  |  |
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `npcflag` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| PRIMARY | `eventEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_npcflag` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `guid` int unsigned NOT NULL DEFAULT '0',
  `npcflag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`eventEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_pool

- 存储引擎: InnoDB
- 行数: 8

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `smallint` | NO |  |  |  |
| `pool_entry` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `pool_entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_pool` (
  `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.',
  `pool_entry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Id of the pool',
  PRIMARY KEY (`pool_entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_prerequisite

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO | PRI |  |  |
| `prerequisite_event` | `int unsigned` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `eventEntry` | 是 | BTREE |
| PRIMARY | `prerequisite_event` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_prerequisite` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event',
  `prerequisite_event` int unsigned NOT NULL,
  PRIMARY KEY (`eventEntry`,`prerequisite_event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_quest_condition

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `eventEntry` | `tinyint unsigned` | NO |  |  |  |
| `quest` | `int unsigned` | NO | PRI | 0 |  |
| `condition_id` | `int unsigned` | NO |  | 0 |  |
| `num` | `float` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `quest` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_quest_condition` (
  `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event.',
  `quest` int unsigned NOT NULL DEFAULT '0',
  `condition_id` int unsigned NOT NULL DEFAULT '0',
  `num` float DEFAULT '0',
  PRIMARY KEY (`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_event_seasonal_questrelation

- 存储引擎: InnoDB
- 行数: 690
- 注释: Player System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `questId` | `int unsigned` | NO | PRI |  |  |
| `eventEntry` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `questId` | 是 | BTREE |
| PRIMARY | `eventEntry` | 是 | BTREE |
| idx_quest | `questId` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_event_seasonal_questrelation` (
  `questId` int unsigned NOT NULL COMMENT 'Quest Identifier',
  `eventEntry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Entry of the game event',
  PRIMARY KEY (`questId`,`eventEntry`),
  KEY `idx_quest` (`questId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Player System'
```

---

## game_graveyard

- 存储引擎: InnoDB
- 行数: 685

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Map` | `int` | NO |  | 0 |  |
| `x` | `float` | NO |  | 0 |  |
| `y` | `float` | NO |  | 0 |  |
| `z` | `float` | NO |  | 0 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_graveyard` (
  `ID` int NOT NULL DEFAULT '0',
  `Map` int NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## game_tele

- 存储引擎: InnoDB
- 行数: 1989
- 注释: Tele Command

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI |  |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |
| `map` | `smallint unsigned` | NO |  | 0 |  |
| `name` | `varchar(100)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_tele` (
  `id` int unsigned NOT NULL,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `map` smallint unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tele Command'
```

---

## game_weather

- 存储引擎: InnoDB
- 行数: 35
- 注释: Weather System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `zone` | `int unsigned` | NO | PRI | 0 |  |
| `spring_rain_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `spring_snow_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `spring_storm_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `summer_rain_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `summer_snow_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `summer_storm_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `fall_rain_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `fall_snow_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `fall_storm_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `winter_rain_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `winter_snow_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `winter_storm_chance` | `tinyint unsigned` | NO |  | 25 |  |
| `ScriptName` | `char(64)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `zone` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `game_weather` (
  `zone` int unsigned NOT NULL DEFAULT '0',
  `spring_rain_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `spring_snow_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `spring_storm_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `summer_rain_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `summer_snow_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `summer_storm_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `fall_rain_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `fall_snow_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `fall_storm_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `winter_rain_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `winter_snow_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `winter_storm_chance` tinyint unsigned NOT NULL DEFAULT '25',
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Weather System'
```

---

## gameobject

- 存储引擎: InnoDB
- 行数: 95790
- 注释: Gameobject System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI |  | auto_increment |
| `id` | `int unsigned` | NO |  | 0 |  |
| `map` | `smallint unsigned` | NO |  | 0 |  |
| `zoneId` | `smallint unsigned` | NO |  | 0 |  |
| `areaId` | `smallint unsigned` | NO |  | 0 |  |
| `spawnMask` | `tinyint unsigned` | NO |  | 1 |  |
| `phaseMask` | `int unsigned` | NO |  | 1 |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |
| `rotation0` | `float` | NO |  | 0 |  |
| `rotation1` | `float` | NO |  | 0 |  |
| `rotation2` | `float` | NO |  | 0 |  |
| `rotation3` | `float` | NO |  | 0 |  |
| `spawntimesecs` | `int` | NO |  | 0 |  |
| `animprogress` | `tinyint unsigned` | NO |  | 0 |  |
| `state` | `tinyint unsigned` | NO |  | 0 |  |
| `ScriptName` | `char(64)` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |
| `Comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject` (
  `guid` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Global Unique Identifier',
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Gameobject Identifier',
  `map` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `zoneId` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'Zone Identifier',
  `areaId` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'Area Identifier',
  `spawnMask` tinyint unsigned NOT NULL DEFAULT '1',
  `phaseMask` int unsigned NOT NULL DEFAULT '1',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `rotation0` float NOT NULL DEFAULT '0',
  `rotation1` float NOT NULL DEFAULT '0',
  `rotation2` float NOT NULL DEFAULT '0',
  `rotation3` float NOT NULL DEFAULT '0',
  `spawntimesecs` int NOT NULL DEFAULT '0',
  `animprogress` tinyint unsigned NOT NULL DEFAULT '0',
  `state` tinyint unsigned NOT NULL DEFAULT '0',
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `VerifiedBuild` int DEFAULT NULL,
  `Comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=5714438 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Gameobject System'
```

---

## gameobject_addon

- 存储引擎: InnoDB
- 行数: 106

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `parent_rotation0` | `float` | NO |  | 0 |  |
| `parent_rotation1` | `float` | NO |  | 0 |  |
| `parent_rotation2` | `float` | NO |  | 0 |  |
| `parent_rotation3` | `float` | NO |  | 1 |  |
| `invisibilityType` | `tinyint unsigned` | NO |  | 0 |  |
| `invisibilityValue` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_addon` (
  `guid` int unsigned NOT NULL DEFAULT '0',
  `parent_rotation0` float NOT NULL DEFAULT '0',
  `parent_rotation1` float NOT NULL DEFAULT '0',
  `parent_rotation2` float NOT NULL DEFAULT '0',
  `parent_rotation3` float NOT NULL DEFAULT '1',
  `invisibilityType` tinyint unsigned NOT NULL DEFAULT '0',
  `invisibilityValue` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobject_loot_template

- 存储引擎: InnoDB
- 行数: 17758
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## gameobject_questender

- 存储引擎: InnoDB
- 行数: 457

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `quest` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `quest` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_questender` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `quest` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobject_questitem

- 存储引擎: InnoDB
- 行数: 862

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `GameObjectEntry` | `int unsigned` | NO | PRI | 0 |  |
| `Idx` | `int unsigned` | NO | PRI | 0 |  |
| `ItemId` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `GameObjectEntry` | 是 | BTREE |
| PRIMARY | `Idx` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_questitem` (
  `GameObjectEntry` int unsigned NOT NULL DEFAULT '0',
  `Idx` int unsigned NOT NULL DEFAULT '0',
  `ItemId` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`GameObjectEntry`,`Idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobject_queststarter

- 存储引擎: InnoDB
- 行数: 457

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `quest` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `quest` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_queststarter` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `quest` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  PRIMARY KEY (`id`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobject_summon_groups

- 存储引擎: InnoDB
- 行数: 52

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `summonerId` | `int unsigned` | NO |  | 0 |  |
| `summonerType` | `tinyint unsigned` | NO |  | 0 |  |
| `groupId` | `tinyint unsigned` | NO |  | 0 |  |
| `entry` | `int unsigned` | NO |  | 0 |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |
| `rotation0` | `float` | NO |  | 0 |  |
| `rotation1` | `float` | NO |  | 0 |  |
| `rotation2` | `float` | NO |  | 0 |  |
| `rotation3` | `float` | NO |  | 0 |  |
| `respawnTime` | `int unsigned` | NO |  | 120 |  |
| `Comment` | `varchar(255)` | NO |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_summon_groups` (
  `summonerId` int unsigned NOT NULL DEFAULT '0',
  `summonerType` tinyint unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint unsigned NOT NULL DEFAULT '0',
  `entry` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `rotation0` float NOT NULL DEFAULT '0',
  `rotation1` float NOT NULL DEFAULT '0',
  `rotation2` float NOT NULL DEFAULT '0',
  `rotation3` float NOT NULL DEFAULT '0',
  `respawnTime` int unsigned NOT NULL DEFAULT '120',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobject_template

- 存储引擎: InnoDB
- 行数: 21262
- 注释: Gameobject System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `type` | `tinyint unsigned` | NO |  | 0 |  |
| `displayId` | `int unsigned` | NO |  | 0 |  |
| `name` | `varchar(100)` | NO | MUL |  |  |
| `IconName` | `varchar(100)` | NO |  |  |  |
| `castBarCaption` | `varchar(100)` | NO |  |  |  |
| `unk1` | `varchar(100)` | NO |  |  |  |
| `size` | `float` | NO |  | 1 |  |
| `Data0` | `int unsigned` | NO |  | 0 |  |
| `Data1` | `int` | NO |  | 0 |  |
| `Data2` | `int unsigned` | NO |  | 0 |  |
| `Data3` | `int unsigned` | NO |  | 0 |  |
| `Data4` | `int unsigned` | NO |  | 0 |  |
| `Data5` | `int unsigned` | NO |  | 0 |  |
| `Data6` | `int` | NO |  | 0 |  |
| `Data7` | `int unsigned` | NO |  | 0 |  |
| `Data8` | `int unsigned` | NO |  | 0 |  |
| `Data9` | `int unsigned` | NO |  | 0 |  |
| `Data10` | `int unsigned` | NO |  | 0 |  |
| `Data11` | `int unsigned` | NO |  | 0 |  |
| `Data12` | `int unsigned` | NO |  | 0 |  |
| `Data13` | `int unsigned` | NO |  | 0 |  |
| `Data14` | `int unsigned` | NO |  | 0 |  |
| `Data15` | `int unsigned` | NO |  | 0 |  |
| `Data16` | `int unsigned` | NO |  | 0 |  |
| `Data17` | `int unsigned` | NO |  | 0 |  |
| `Data18` | `int unsigned` | NO |  | 0 |  |
| `Data19` | `int unsigned` | NO |  | 0 |  |
| `Data20` | `int unsigned` | NO |  | 0 |  |
| `Data21` | `int unsigned` | NO |  | 0 |  |
| `Data22` | `int unsigned` | NO |  | 0 |  |
| `Data23` | `int unsigned` | NO |  | 0 |  |
| `AIName` | `char(64)` | NO |  |  |  |
| `ScriptName` | `varchar(64)` | NO |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| idx_name | `name` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_template` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `displayId` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `IconName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `castBarCaption` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `unk1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `size` float NOT NULL DEFAULT '1',
  `Data0` int unsigned NOT NULL DEFAULT '0',
  `Data1` int NOT NULL DEFAULT '0',
  `Data2` int unsigned NOT NULL DEFAULT '0',
  `Data3` int unsigned NOT NULL DEFAULT '0',
  `Data4` int unsigned NOT NULL DEFAULT '0',
  `Data5` int unsigned NOT NULL DEFAULT '0',
  `Data6` int NOT NULL DEFAULT '0',
  `Data7` int unsigned NOT NULL DEFAULT '0',
  `Data8` int unsigned NOT NULL DEFAULT '0',
  `Data9` int unsigned NOT NULL DEFAULT '0',
  `Data10` int unsigned NOT NULL DEFAULT '0',
  `Data11` int unsigned NOT NULL DEFAULT '0',
  `Data12` int unsigned NOT NULL DEFAULT '0',
  `Data13` int unsigned NOT NULL DEFAULT '0',
  `Data14` int unsigned NOT NULL DEFAULT '0',
  `Data15` int unsigned NOT NULL DEFAULT '0',
  `Data16` int unsigned NOT NULL DEFAULT '0',
  `Data17` int unsigned NOT NULL DEFAULT '0',
  `Data18` int unsigned NOT NULL DEFAULT '0',
  `Data19` int unsigned NOT NULL DEFAULT '0',
  `Data20` int unsigned NOT NULL DEFAULT '0',
  `Data21` int unsigned NOT NULL DEFAULT '0',
  `Data22` int unsigned NOT NULL DEFAULT '0',
  `Data23` int unsigned NOT NULL DEFAULT '0',
  `AIName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ScriptName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`entry`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Gameobject System'
```

---

## gameobject_template_addon

- 存储引擎: InnoDB
- 行数: 21255

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `faction` | `smallint unsigned` | NO |  | 0 |  |
| `flags` | `int unsigned` | NO |  | 0 |  |
| `mingold` | `int unsigned` | NO |  | 0 |  |
| `maxgold` | `int unsigned` | NO |  | 0 |  |
| `artkit0` | `int` | NO |  | 0 |  |
| `artkit1` | `int` | NO |  | 0 |  |
| `artkit2` | `int` | NO |  | 0 |  |
| `artkit3` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_template_addon` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `faction` smallint unsigned NOT NULL DEFAULT '0',
  `flags` int unsigned NOT NULL DEFAULT '0',
  `mingold` int unsigned NOT NULL DEFAULT '0',
  `maxgold` int unsigned NOT NULL DEFAULT '0',
  `artkit0` int NOT NULL DEFAULT '0',
  `artkit1` int NOT NULL DEFAULT '0',
  `artkit2` int NOT NULL DEFAULT '0',
  `artkit3` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobject_template_locale

- 存储引擎: InnoDB
- 行数: 152906

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `name` | `text` | YES |  |  |  |
| `castBarCaption` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobject_template_locale` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `castBarCaption` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`entry`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobjectartkit_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Texture_1` | `int` | NO |  | 0 |  |
| `Texture_2` | `int` | NO |  | 0 |  |
| `Texture_3` | `int` | NO |  | 0 |  |
| `Attach_Model_1` | `int` | NO |  | 0 |  |
| `Attach_Model_2` | `int` | NO |  | 0 |  |
| `Attach_Model_3` | `int` | NO |  | 0 |  |
| `Attach_Model_4` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobjectartkit_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Texture_1` int NOT NULL DEFAULT '0',
  `Texture_2` int NOT NULL DEFAULT '0',
  `Texture_3` int NOT NULL DEFAULT '0',
  `Attach_Model_1` int NOT NULL DEFAULT '0',
  `Attach_Model_2` int NOT NULL DEFAULT '0',
  `Attach_Model_3` int NOT NULL DEFAULT '0',
  `Attach_Model_4` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gameobjectdisplayinfo_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ModelName` | `varchar(200)` | YES |  |  |  |
| `Sound_1` | `int` | NO |  | 0 |  |
| `Sound_2` | `int` | NO |  | 0 |  |
| `Sound_3` | `int` | NO |  | 0 |  |
| `Sound_4` | `int` | NO |  | 0 |  |
| `Sound_5` | `int` | NO |  | 0 |  |
| `Sound_6` | `int` | NO |  | 0 |  |
| `Sound_7` | `int` | NO |  | 0 |  |
| `Sound_8` | `int` | NO |  | 0 |  |
| `Sound_9` | `int` | NO |  | 0 |  |
| `Sound_10` | `int` | NO |  | 0 |  |
| `GeoBoxMinX` | `float` | NO |  | 0 |  |
| `GeoBoxMinY` | `float` | NO |  | 0 |  |
| `GeoBoxMinZ` | `float` | NO |  | 0 |  |
| `GeoBoxMaxX` | `float` | NO |  | 0 |  |
| `GeoBoxMaxY` | `float` | NO |  | 0 |  |
| `GeoBoxMaxZ` | `float` | NO |  | 0 |  |
| `ObjectEffectPackageID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gameobjectdisplayinfo_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ModelName` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Sound_1` int NOT NULL DEFAULT '0',
  `Sound_2` int NOT NULL DEFAULT '0',
  `Sound_3` int NOT NULL DEFAULT '0',
  `Sound_4` int NOT NULL DEFAULT '0',
  `Sound_5` int NOT NULL DEFAULT '0',
  `Sound_6` int NOT NULL DEFAULT '0',
  `Sound_7` int NOT NULL DEFAULT '0',
  `Sound_8` int NOT NULL DEFAULT '0',
  `Sound_9` int NOT NULL DEFAULT '0',
  `Sound_10` int NOT NULL DEFAULT '0',
  `GeoBoxMinX` float NOT NULL DEFAULT '0',
  `GeoBoxMinY` float NOT NULL DEFAULT '0',
  `GeoBoxMinZ` float NOT NULL DEFAULT '0',
  `GeoBoxMaxX` float NOT NULL DEFAULT '0',
  `GeoBoxMaxY` float NOT NULL DEFAULT '0',
  `GeoBoxMaxZ` float NOT NULL DEFAULT '0',
  `ObjectEffectPackageID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gemproperties_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Enchant_Id` | `int` | NO |  | 0 |  |
| `Maxcount_Inv` | `int` | NO |  | 0 |  |
| `Maxcount_Item` | `int` | NO |  | 0 |  |
| `Type` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gemproperties_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Enchant_Id` int NOT NULL DEFAULT '0',
  `Maxcount_Inv` int NOT NULL DEFAULT '0',
  `Maxcount_Item` int NOT NULL DEFAULT '0',
  `Type` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## glyphproperties_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `SpellID` | `int` | NO |  | 0 |  |
| `GlyphSlotFlags` | `int` | NO |  | 0 |  |
| `SpellIconID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `glyphproperties_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `SpellID` int NOT NULL DEFAULT '0',
  `GlyphSlotFlags` int NOT NULL DEFAULT '0',
  `SpellIconID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## glyphslot_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Type` | `int` | NO |  | 0 |  |
| `Tooltip` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `glyphslot_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Type` int NOT NULL DEFAULT '0',
  `Tooltip` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gossip_menu

- 存储引擎: InnoDB
- 行数: 6082

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `MenuID` | `int unsigned` | NO | PRI | 0 |  |
| `TextID` | `int unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `MenuID` | 是 | BTREE |
| PRIMARY | `TextID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gossip_menu` (
  `MenuID` int unsigned NOT NULL DEFAULT '0',
  `TextID` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`MenuID`,`TextID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gossip_menu_option

- 存储引擎: InnoDB
- 行数: 4677

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `MenuID` | `int unsigned` | NO | PRI | 0 |  |
| `OptionID` | `smallint unsigned` | NO | PRI | 0 |  |
| `OptionIcon` | `int unsigned` | NO |  | 0 |  |
| `OptionText` | `text` | YES |  |  |  |
| `OptionBroadcastTextID` | `int` | NO |  | 0 |  |
| `OptionType` | `tinyint unsigned` | NO |  | 0 |  |
| `OptionNpcFlag` | `int unsigned` | NO |  | 0 |  |
| `ActionMenuID` | `int unsigned` | NO |  | 0 |  |
| `ActionPoiID` | `int unsigned` | NO |  | 0 |  |
| `BoxCoded` | `tinyint unsigned` | NO |  | 0 |  |
| `BoxMoney` | `int unsigned` | NO |  | 0 |  |
| `BoxText` | `text` | YES |  |  |  |
| `BoxBroadcastTextID` | `int` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `MenuID` | 是 | BTREE |
| PRIMARY | `OptionID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gossip_menu_option` (
  `MenuID` int unsigned NOT NULL DEFAULT '0',
  `OptionID` smallint unsigned NOT NULL DEFAULT '0',
  `OptionIcon` int unsigned NOT NULL DEFAULT '0',
  `OptionText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `OptionBroadcastTextID` int NOT NULL DEFAULT '0',
  `OptionType` tinyint unsigned NOT NULL DEFAULT '0',
  `OptionNpcFlag` int unsigned NOT NULL DEFAULT '0',
  `ActionMenuID` int unsigned NOT NULL DEFAULT '0',
  `ActionPoiID` int unsigned NOT NULL DEFAULT '0',
  `BoxCoded` tinyint unsigned NOT NULL DEFAULT '0',
  `BoxMoney` int unsigned NOT NULL DEFAULT '0',
  `BoxText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BoxBroadcastTextID` int NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`MenuID`,`OptionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gossip_menu_option_locale

- 存储引擎: InnoDB
- 行数: 36397

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `MenuID` | `int unsigned` | NO | PRI | 0 |  |
| `OptionID` | `smallint unsigned` | NO | PRI | 0 |  |
| `Locale` | `varchar(4)` | NO | PRI |  |  |
| `OptionText` | `text` | YES |  |  |  |
| `BoxText` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `MenuID` | 是 | BTREE |
| PRIMARY | `OptionID` | 是 | BTREE |
| PRIMARY | `Locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gossip_menu_option_locale` (
  `MenuID` int unsigned NOT NULL DEFAULT '0',
  `OptionID` smallint unsigned NOT NULL DEFAULT '0',
  `Locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `OptionText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BoxText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`MenuID`,`OptionID`,`Locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## graveyard_zone

- 存储引擎: InnoDB
- 行数: 704
- 注释: Trigger System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `GhostZone` | `int unsigned` | NO | PRI | 0 |  |
| `Faction` | `smallint unsigned` | NO |  | 0 |  |
| `Comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `GhostZone` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `graveyard_zone` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `GhostZone` int unsigned NOT NULL DEFAULT '0',
  `Faction` smallint unsigned NOT NULL DEFAULT '0',
  `Comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID`,`GhostZone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Trigger System'
```

---

## gtbarbershopcostbase_dbc

- 存储引擎: InnoDB
- 行数: 100

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtbarbershopcostbase_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtchancetomeleecrit_dbc

- 存储引擎: InnoDB
- 行数: 1100

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtchancetomeleecrit_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtchancetomeleecritbase_dbc

- 存储引擎: InnoDB
- 行数: 11

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtchancetomeleecritbase_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtchancetospellcrit_dbc

- 存储引擎: InnoDB
- 行数: 1100

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtchancetospellcrit_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtchancetospellcritbase_dbc

- 存储引擎: InnoDB
- 行数: 11

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtchancetospellcritbase_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtcombatratings_dbc

- 存储引擎: InnoDB
- 行数: 3200

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtcombatratings_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtnpcmanacostscaler_dbc

- 存储引擎: InnoDB
- 行数: 100

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtnpcmanacostscaler_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtoctclasscombatratingscalar_dbc

- 存储引擎: InnoDB
- 行数: 352

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtoctclasscombatratingscalar_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtoctregenhp_dbc

- 存储引擎: InnoDB
- 行数: 1100

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtoctregenhp_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtregenhpperspt_dbc

- 存储引擎: InnoDB
- 行数: 1100

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtregenhpperspt_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## gtregenmpperspt_dbc

- 存储引擎: InnoDB
- 行数: 1100

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `gtregenmpperspt_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## holiday_dates

- 存储引擎: InnoDB
- 行数: 153

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI |  |  |
| `date_id` | `tinyint unsigned` | NO | PRI |  |  |
| `date_value` | `int unsigned` | NO |  |  |  |
| `holiday_duration` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `date_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `holiday_dates` (
  `id` int unsigned NOT NULL,
  `date_id` tinyint unsigned NOT NULL,
  `date_value` int unsigned NOT NULL,
  `holiday_duration` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`date_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## holidays_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Duration_1` | `int` | NO |  | 0 |  |
| `Duration_2` | `int` | NO |  | 0 |  |
| `Duration_3` | `int` | NO |  | 0 |  |
| `Duration_4` | `int` | NO |  | 0 |  |
| `Duration_5` | `int` | NO |  | 0 |  |
| `Duration_6` | `int` | NO |  | 0 |  |
| `Duration_7` | `int` | NO |  | 0 |  |
| `Duration_8` | `int` | NO |  | 0 |  |
| `Duration_9` | `int` | NO |  | 0 |  |
| `Duration_10` | `int` | NO |  | 0 |  |
| `Date_1` | `int` | NO |  | 0 |  |
| `Date_2` | `int` | NO |  | 0 |  |
| `Date_3` | `int` | NO |  | 0 |  |
| `Date_4` | `int` | NO |  | 0 |  |
| `Date_5` | `int` | NO |  | 0 |  |
| `Date_6` | `int` | NO |  | 0 |  |
| `Date_7` | `int` | NO |  | 0 |  |
| `Date_8` | `int` | NO |  | 0 |  |
| `Date_9` | `int` | NO |  | 0 |  |
| `Date_10` | `int` | NO |  | 0 |  |
| `Date_11` | `int` | NO |  | 0 |  |
| `Date_12` | `int` | NO |  | 0 |  |
| `Date_13` | `int` | NO |  | 0 |  |
| `Date_14` | `int` | NO |  | 0 |  |
| `Date_15` | `int` | NO |  | 0 |  |
| `Date_16` | `int` | NO |  | 0 |  |
| `Date_17` | `int` | NO |  | 0 |  |
| `Date_18` | `int` | NO |  | 0 |  |
| `Date_19` | `int` | NO |  | 0 |  |
| `Date_20` | `int` | NO |  | 0 |  |
| `Date_21` | `int` | NO |  | 0 |  |
| `Date_22` | `int` | NO |  | 0 |  |
| `Date_23` | `int` | NO |  | 0 |  |
| `Date_24` | `int` | NO |  | 0 |  |
| `Date_25` | `int` | NO |  | 0 |  |
| `Date_26` | `int` | NO |  | 0 |  |
| `Region` | `int` | NO |  | 0 |  |
| `Looping` | `int` | NO |  | 0 |  |
| `CalendarFlags_1` | `int` | NO |  | 0 |  |
| `CalendarFlags_2` | `int` | NO |  | 0 |  |
| `CalendarFlags_3` | `int` | NO |  | 0 |  |
| `CalendarFlags_4` | `int` | NO |  | 0 |  |
| `CalendarFlags_5` | `int` | NO |  | 0 |  |
| `CalendarFlags_6` | `int` | NO |  | 0 |  |
| `CalendarFlags_7` | `int` | NO |  | 0 |  |
| `CalendarFlags_8` | `int` | NO |  | 0 |  |
| `CalendarFlags_9` | `int` | NO |  | 0 |  |
| `CalendarFlags_10` | `int` | NO |  | 0 |  |
| `HolidayNameID` | `int` | NO |  | 0 |  |
| `HolidayDescriptionID` | `int` | NO |  | 0 |  |
| `TextureFilename` | `varchar(100)` | YES |  |  |  |
| `Priority` | `int` | NO |  | 0 |  |
| `CalendarFilterType` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `holidays_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Duration_1` int NOT NULL DEFAULT '0',
  `Duration_2` int NOT NULL DEFAULT '0',
  `Duration_3` int NOT NULL DEFAULT '0',
  `Duration_4` int NOT NULL DEFAULT '0',
  `Duration_5` int NOT NULL DEFAULT '0',
  `Duration_6` int NOT NULL DEFAULT '0',
  `Duration_7` int NOT NULL DEFAULT '0',
  `Duration_8` int NOT NULL DEFAULT '0',
  `Duration_9` int NOT NULL DEFAULT '0',
  `Duration_10` int NOT NULL DEFAULT '0',
  `Date_1` int NOT NULL DEFAULT '0',
  `Date_2` int NOT NULL DEFAULT '0',
  `Date_3` int NOT NULL DEFAULT '0',
  `Date_4` int NOT NULL DEFAULT '0',
  `Date_5` int NOT NULL DEFAULT '0',
  `Date_6` int NOT NULL DEFAULT '0',
  `Date_7` int NOT NULL DEFAULT '0',
  `Date_8` int NOT NULL DEFAULT '0',
  `Date_9` int NOT NULL DEFAULT '0',
  `Date_10` int NOT NULL DEFAULT '0',
  `Date_11` int NOT NULL DEFAULT '0',
  `Date_12` int NOT NULL DEFAULT '0',
  `Date_13` int NOT NULL DEFAULT '0',
  `Date_14` int NOT NULL DEFAULT '0',
  `Date_15` int NOT NULL DEFAULT '0',
  `Date_16` int NOT NULL DEFAULT '0',
  `Date_17` int NOT NULL DEFAULT '0',
  `Date_18` int NOT NULL DEFAULT '0',
  `Date_19` int NOT NULL DEFAULT '0',
  `Date_20` int NOT NULL DEFAULT '0',
  `Date_21` int NOT NULL DEFAULT '0',
  `Date_22` int NOT NULL DEFAULT '0',
  `Date_23` int NOT NULL DEFAULT '0',
  `Date_24` int NOT NULL DEFAULT '0',
  `Date_25` int NOT NULL DEFAULT '0',
  `Date_26` int NOT NULL DEFAULT '0',
  `Region` int NOT NULL DEFAULT '0',
  `Looping` int NOT NULL DEFAULT '0',
  `CalendarFlags_1` int NOT NULL DEFAULT '0',
  `CalendarFlags_2` int NOT NULL DEFAULT '0',
  `CalendarFlags_3` int NOT NULL DEFAULT '0',
  `CalendarFlags_4` int NOT NULL DEFAULT '0',
  `CalendarFlags_5` int NOT NULL DEFAULT '0',
  `CalendarFlags_6` int NOT NULL DEFAULT '0',
  `CalendarFlags_7` int NOT NULL DEFAULT '0',
  `CalendarFlags_8` int NOT NULL DEFAULT '0',
  `CalendarFlags_9` int NOT NULL DEFAULT '0',
  `CalendarFlags_10` int NOT NULL DEFAULT '0',
  `HolidayNameID` int NOT NULL DEFAULT '0',
  `HolidayDescriptionID` int NOT NULL DEFAULT '0',
  `TextureFilename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Priority` int NOT NULL DEFAULT '0',
  `CalendarFilterType` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## instance_encounters

- 存储引擎: InnoDB
- 行数: 612

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI |  |  |
| `creditType` | `tinyint unsigned` | NO |  | 0 |  |
| `creditEntry` | `int unsigned` | NO |  | 0 |  |
| `lastEncounterDungeon` | `smallint unsigned` | NO |  | 0 |  |
| `comment` | `varchar(255)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `instance_encounters` (
  `entry` int unsigned NOT NULL COMMENT 'Unique entry from DungeonEncounter.dbc',
  `creditType` tinyint unsigned NOT NULL DEFAULT '0',
  `creditEntry` int unsigned NOT NULL DEFAULT '0',
  `lastEncounterDungeon` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'If not 0, LfgDungeon.dbc entry for the instance it is last encounter in',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## instance_template

- 存储引擎: InnoDB
- 行数: 85

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `map` | `smallint unsigned` | NO | PRI |  |  |
| `parent` | `smallint unsigned` | NO |  |  |  |
| `script` | `varchar(128)` | NO |  |  |  |
| `allowMount` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `map` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `instance_template` (
  `map` smallint unsigned NOT NULL,
  `parent` smallint unsigned NOT NULL,
  `script` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `allowMount` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## item_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ClassID` | `int` | NO |  | 0 |  |
| `SubclassID` | `int` | NO |  | 0 |  |
| `Sound_Override_Subclassid` | `int` | NO |  | 0 |  |
| `Material` | `int` | NO |  | 0 |  |
| `DisplayInfoID` | `int` | NO |  | 0 |  |
| `InventoryType` | `int` | NO |  | 0 |  |
| `SheatheType` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `item_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ClassID` int NOT NULL DEFAULT '0',
  `SubclassID` int NOT NULL DEFAULT '0',
  `Sound_Override_Subclassid` int NOT NULL DEFAULT '0',
  `Material` int NOT NULL DEFAULT '0',
  `DisplayInfoID` int NOT NULL DEFAULT '0',
  `InventoryType` int NOT NULL DEFAULT '0',
  `SheatheType` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## item_enchantment_template

- 存储引擎: InnoDB
- 行数: 28884
- 注释: Item Random Enchantment System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `ench` | `int unsigned` | NO | PRI | 0 |  |
| `chance` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| PRIMARY | `ench` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `item_enchantment_template` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `ench` int unsigned NOT NULL DEFAULT '0',
  `chance` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`,`ench`),
  CONSTRAINT `item_enchantment_template_chk_1` CHECK ((`chance` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Item Random Enchantment System'
```

---

## item_loot_template

- 存储引擎: InnoDB
- 行数: 3269
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `item_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## item_set_names

- 存储引擎: InnoDB
- 行数: 2481

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI |  |  |
| `name` | `varchar(255)` | NO |  |  |  |
| `InventoryType` | `tinyint unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `item_set_names` (
  `entry` int unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `InventoryType` tinyint unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## item_set_names_locale

- 存储引擎: InnoDB
- 行数: 13986

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Name` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `item_set_names_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## item_template

- 存储引擎: InnoDB
- 行数: 44422
- 注释: Item System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `class` | `tinyint unsigned` | NO | MUL | 0 |  |
| `subclass` | `tinyint unsigned` | NO |  | 0 |  |
| `SoundOverrideSubclass` | `tinyint` | NO |  | -1 |  |
| `name` | `varchar(255)` | NO | MUL |  |  |
| `displayid` | `int unsigned` | NO |  | 0 |  |
| `Quality` | `tinyint unsigned` | NO |  | 0 |  |
| `Flags` | `int unsigned` | NO |  | 0 |  |
| `FlagsExtra` | `int unsigned` | NO |  | 0 |  |
| `BuyCount` | `tinyint unsigned` | NO |  | 1 |  |
| `BuyPrice` | `bigint` | NO |  | 0 |  |
| `SellPrice` | `int unsigned` | NO |  | 0 |  |
| `InventoryType` | `tinyint unsigned` | NO |  | 0 |  |
| `AllowableClass` | `int` | NO |  | -1 |  |
| `AllowableRace` | `int` | NO |  | -1 |  |
| `ItemLevel` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredLevel` | `tinyint unsigned` | NO |  | 0 |  |
| `RequiredSkill` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredSkillRank` | `smallint unsigned` | NO |  | 0 |  |
| `requiredspell` | `int unsigned` | NO |  | 0 |  |
| `requiredhonorrank` | `int unsigned` | NO |  | 0 |  |
| `RequiredCityRank` | `int unsigned` | NO |  | 0 |  |
| `RequiredReputationFaction` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredReputationRank` | `smallint unsigned` | NO |  | 0 |  |
| `maxcount` | `int` | NO |  | 0 |  |
| `stackable` | `int` | YES |  | 1 |  |
| `ContainerSlots` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_type1` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value1` | `int` | NO |  | 0 |  |
| `stat_type2` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value2` | `int` | NO |  | 0 |  |
| `stat_type3` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value3` | `int` | NO |  | 0 |  |
| `stat_type4` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value4` | `int` | NO |  | 0 |  |
| `stat_type5` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value5` | `int` | NO |  | 0 |  |
| `stat_type6` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value6` | `int` | NO |  | 0 |  |
| `stat_type7` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value7` | `int` | NO |  | 0 |  |
| `stat_type8` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value8` | `int` | NO |  | 0 |  |
| `stat_type9` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value9` | `int` | NO |  | 0 |  |
| `stat_type10` | `tinyint unsigned` | NO |  | 0 |  |
| `stat_value10` | `int` | NO |  | 0 |  |
| `ScalingStatDistribution` | `smallint` | NO |  | 0 |  |
| `ScalingStatValue` | `int unsigned` | NO |  | 0 |  |
| `dmg_min1` | `float` | NO |  | 0 |  |
| `dmg_max1` | `float` | NO |  | 0 |  |
| `dmg_type1` | `tinyint unsigned` | NO |  | 0 |  |
| `dmg_min2` | `float` | NO |  | 0 |  |
| `dmg_max2` | `float` | NO |  | 0 |  |
| `dmg_type2` | `tinyint unsigned` | NO |  | 0 |  |
| `armor` | `int unsigned` | NO |  | 0 |  |
| `holy_res` | `smallint` | YES |  |  |  |
| `fire_res` | `smallint` | YES |  |  |  |
| `nature_res` | `smallint` | YES |  |  |  |
| `frost_res` | `smallint` | YES |  |  |  |
| `shadow_res` | `smallint` | YES |  |  |  |
| `arcane_res` | `smallint` | YES |  |  |  |
| `delay` | `smallint unsigned` | NO |  | 1000 |  |
| `ammo_type` | `tinyint unsigned` | NO |  | 0 |  |
| `RangedModRange` | `float` | NO |  | 0 |  |
| `spellid_1` | `int` | NO |  | 0 |  |
| `spelltrigger_1` | `tinyint unsigned` | NO |  | 0 |  |
| `spellcharges_1` | `smallint` | NO |  | 0 |  |
| `spellppmRate_1` | `float` | NO |  | 0 |  |
| `spellcooldown_1` | `int` | NO |  | -1 |  |
| `spellcategory_1` | `smallint unsigned` | NO |  | 0 |  |
| `spellcategorycooldown_1` | `int` | NO |  | -1 |  |
| `spellid_2` | `int` | NO |  | 0 |  |
| `spelltrigger_2` | `tinyint unsigned` | NO |  | 0 |  |
| `spellcharges_2` | `smallint` | NO |  | 0 |  |
| `spellppmRate_2` | `float` | NO |  | 0 |  |
| `spellcooldown_2` | `int` | NO |  | -1 |  |
| `spellcategory_2` | `smallint unsigned` | NO |  | 0 |  |
| `spellcategorycooldown_2` | `int` | NO |  | -1 |  |
| `spellid_3` | `int` | NO |  | 0 |  |
| `spelltrigger_3` | `tinyint unsigned` | NO |  | 0 |  |
| `spellcharges_3` | `smallint` | NO |  | 0 |  |
| `spellppmRate_3` | `float` | NO |  | 0 |  |
| `spellcooldown_3` | `int` | NO |  | -1 |  |
| `spellcategory_3` | `smallint unsigned` | NO |  | 0 |  |
| `spellcategorycooldown_3` | `int` | NO |  | -1 |  |
| `spellid_4` | `int` | NO |  | 0 |  |
| `spelltrigger_4` | `tinyint unsigned` | NO |  | 0 |  |
| `spellcharges_4` | `smallint` | NO |  | 0 |  |
| `spellppmRate_4` | `float` | NO |  | 0 |  |
| `spellcooldown_4` | `int` | NO |  | -1 |  |
| `spellcategory_4` | `smallint unsigned` | NO |  | 0 |  |
| `spellcategorycooldown_4` | `int` | NO |  | -1 |  |
| `spellid_5` | `int` | NO |  | 0 |  |
| `spelltrigger_5` | `tinyint unsigned` | NO |  | 0 |  |
| `spellcharges_5` | `smallint` | NO |  | 0 |  |
| `spellppmRate_5` | `float` | NO |  | 0 |  |
| `spellcooldown_5` | `int` | NO |  | -1 |  |
| `spellcategory_5` | `smallint unsigned` | NO |  | 0 |  |
| `spellcategorycooldown_5` | `int` | NO |  | -1 |  |
| `bonding` | `tinyint unsigned` | NO |  | 0 |  |
| `description` | `varchar(255)` | NO |  |  |  |
| `PageText` | `int unsigned` | NO |  | 0 |  |
| `LanguageID` | `tinyint unsigned` | NO |  | 0 |  |
| `PageMaterial` | `tinyint unsigned` | NO |  | 0 |  |
| `startquest` | `int unsigned` | NO |  | 0 |  |
| `lockid` | `int unsigned` | NO |  | 0 |  |
| `Material` | `tinyint` | NO |  | 0 |  |
| `sheath` | `tinyint unsigned` | NO |  | 0 |  |
| `RandomProperty` | `int` | NO |  | 0 |  |
| `RandomSuffix` | `int unsigned` | NO |  | 0 |  |
| `block` | `int unsigned` | NO |  | 0 |  |
| `itemset` | `int unsigned` | NO |  | 0 |  |
| `MaxDurability` | `smallint unsigned` | NO |  | 0 |  |
| `area` | `int unsigned` | NO |  | 0 |  |
| `Map` | `smallint` | NO |  | 0 |  |
| `BagFamily` | `int` | NO |  | 0 |  |
| `TotemCategory` | `int` | NO |  | 0 |  |
| `socketColor_1` | `tinyint` | NO |  | 0 |  |
| `socketContent_1` | `int` | NO |  | 0 |  |
| `socketColor_2` | `tinyint` | NO |  | 0 |  |
| `socketContent_2` | `int` | NO |  | 0 |  |
| `socketColor_3` | `tinyint` | NO |  | 0 |  |
| `socketContent_3` | `int` | NO |  | 0 |  |
| `socketBonus` | `int` | NO |  | 0 |  |
| `GemProperties` | `int` | NO |  | 0 |  |
| `RequiredDisenchantSkill` | `smallint` | NO |  | -1 |  |
| `ArmorDamageModifier` | `float` | NO |  | 0 |  |
| `duration` | `int unsigned` | NO |  | 0 |  |
| `ItemLimitCategory` | `smallint` | NO |  | 0 |  |
| `HolidayId` | `int unsigned` | NO |  | 0 |  |
| `ScriptName` | `varchar(64)` | NO |  |  |  |
| `DisenchantID` | `int unsigned` | NO |  | 0 |  |
| `FoodType` | `tinyint unsigned` | NO |  | 0 |  |
| `minMoneyLoot` | `int unsigned` | NO |  | 0 |  |
| `maxMoneyLoot` | `int unsigned` | NO |  | 0 |  |
| `flagsCustom` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| idx_name | `name` | 否 | BTREE |
| items_index | `class` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `item_template` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `subclass` tinyint unsigned NOT NULL DEFAULT '0',
  `SoundOverrideSubclass` tinyint NOT NULL DEFAULT '-1',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `displayid` int unsigned NOT NULL DEFAULT '0',
  `Quality` tinyint unsigned NOT NULL DEFAULT '0',
  `Flags` int unsigned NOT NULL DEFAULT '0',
  `FlagsExtra` int unsigned NOT NULL DEFAULT '0',
  `BuyCount` tinyint unsigned NOT NULL DEFAULT '1',
  `BuyPrice` bigint NOT NULL DEFAULT '0',
  `SellPrice` int unsigned NOT NULL DEFAULT '0',
  `InventoryType` tinyint unsigned NOT NULL DEFAULT '0',
  `AllowableClass` int NOT NULL DEFAULT '-1',
  `AllowableRace` int NOT NULL DEFAULT '-1',
  `ItemLevel` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredLevel` tinyint unsigned NOT NULL DEFAULT '0',
  `RequiredSkill` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredSkillRank` smallint unsigned NOT NULL DEFAULT '0',
  `requiredspell` int unsigned NOT NULL DEFAULT '0',
  `requiredhonorrank` int unsigned NOT NULL DEFAULT '0',
  `RequiredCityRank` int unsigned NOT NULL DEFAULT '0',
  `RequiredReputationFaction` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredReputationRank` smallint unsigned NOT NULL DEFAULT '0',
  `maxcount` int NOT NULL DEFAULT '0',
  `stackable` int DEFAULT '1',
  `ContainerSlots` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_type1` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value1` int NOT NULL DEFAULT '0',
  `stat_type2` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value2` int NOT NULL DEFAULT '0',
  `stat_type3` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value3` int NOT NULL DEFAULT '0',
  `stat_type4` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value4` int NOT NULL DEFAULT '0',
  `stat_type5` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value5` int NOT NULL DEFAULT '0',
  `stat_type6` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value6` int NOT NULL DEFAULT '0',
  `stat_type7` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value7` int NOT NULL DEFAULT '0',
  `stat_type8` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value8` int NOT NULL DEFAULT '0',
  `stat_type9` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value9` int NOT NULL DEFAULT '0',
  `stat_type10` tinyint unsigned NOT NULL DEFAULT '0',
  `stat_value10` int NOT NULL DEFAULT '0',
  `ScalingStatDistribution` smallint NOT NULL DEFAULT '0',
  `ScalingStatValue` int unsigned NOT NULL DEFAULT '0',
  `dmg_min1` float NOT NULL DEFAULT '0',
  `dmg_max1` float NOT NULL DEFAULT '0',
  `dmg_type1` tinyint unsigned NOT NULL DEFAULT '0',
  `dmg_min2` float NOT NULL DEFAULT '0',
  `dmg_max2` float NOT NULL DEFAULT '0',
  `dmg_type2` tinyint unsigned NOT NULL DEFAULT '0',
  `armor` int unsigned NOT NULL DEFAULT '0',
  `holy_res` smallint DEFAULT NULL,
  `fire_res` smallint DEFAULT NULL,
  `nature_res` smallint DEFAULT NULL,
  `frost_res` smallint DEFAULT NULL,
  `shadow_res` smallint DEFAULT NULL,
  `arcane_res` smallint DEFAULT NULL,
  `delay` smallint unsigned NOT NULL DEFAULT '1000',
  `ammo_type` tinyint unsigned NOT NULL DEFAULT '0',
  `RangedModRange` float NOT NULL DEFAULT '0',
  `spellid_1` int NOT NULL DEFAULT '0',
  `spelltrigger_1` tinyint unsigned NOT NULL DEFAULT '0',
  `spellcharges_1` smallint NOT NULL DEFAULT '0',
  `spellppmRate_1` float NOT NULL DEFAULT '0',
  `spellcooldown_1` int NOT NULL DEFAULT '-1',
  `spellcategory_1` smallint unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_1` int NOT NULL DEFAULT '-1',
  `spellid_2` int NOT NULL DEFAULT '0',
  `spelltrigger_2` tinyint unsigned NOT NULL DEFAULT '0',
  `spellcharges_2` smallint NOT NULL DEFAULT '0',
  `spellppmRate_2` float NOT NULL DEFAULT '0',
  `spellcooldown_2` int NOT NULL DEFAULT '-1',
  `spellcategory_2` smallint unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_2` int NOT NULL DEFAULT '-1',
  `spellid_3` int NOT NULL DEFAULT '0',
  `spelltrigger_3` tinyint unsigned NOT NULL DEFAULT '0',
  `spellcharges_3` smallint NOT NULL DEFAULT '0',
  `spellppmRate_3` float NOT NULL DEFAULT '0',
  `spellcooldown_3` int NOT NULL DEFAULT '-1',
  `spellcategory_3` smallint unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_3` int NOT NULL DEFAULT '-1',
  `spellid_4` int NOT NULL DEFAULT '0',
  `spelltrigger_4` tinyint unsigned NOT NULL DEFAULT '0',
  `spellcharges_4` smallint NOT NULL DEFAULT '0',
  `spellppmRate_4` float NOT NULL DEFAULT '0',
  `spellcooldown_4` int NOT NULL DEFAULT '-1',
  `spellcategory_4` smallint unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_4` int NOT NULL DEFAULT '-1',
  `spellid_5` int NOT NULL DEFAULT '0',
  `spelltrigger_5` tinyint unsigned NOT NULL DEFAULT '0',
  `spellcharges_5` smallint NOT NULL DEFAULT '0',
  `spellppmRate_5` float NOT NULL DEFAULT '0',
  `spellcooldown_5` int NOT NULL DEFAULT '-1',
  `spellcategory_5` smallint unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_5` int NOT NULL DEFAULT '-1',
  `bonding` tinyint unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `PageText` int unsigned NOT NULL DEFAULT '0',
  `LanguageID` tinyint unsigned NOT NULL DEFAULT '0',
  `PageMaterial` tinyint unsigned NOT NULL DEFAULT '0',
  `startquest` int unsigned NOT NULL DEFAULT '0',
  `lockid` int unsigned NOT NULL DEFAULT '0',
  `Material` tinyint NOT NULL DEFAULT '0',
  `sheath` tinyint unsigned NOT NULL DEFAULT '0',
  `RandomProperty` int NOT NULL DEFAULT '0',
  `RandomSuffix` int unsigned NOT NULL DEFAULT '0',
  `block` int unsigned NOT NULL DEFAULT '0',
  `itemset` int unsigned NOT NULL DEFAULT '0',
  `MaxDurability` smallint unsigned NOT NULL DEFAULT '0',
  `area` int unsigned NOT NULL DEFAULT '0',
  `Map` smallint NOT NULL DEFAULT '0',
  `BagFamily` int NOT NULL DEFAULT '0',
  `TotemCategory` int NOT NULL DEFAULT '0',
  `socketColor_1` tinyint NOT NULL DEFAULT '0',
  `socketContent_1` int NOT NULL DEFAULT '0',
  `socketColor_2` tinyint NOT NULL DEFAULT '0',
  `socketContent_2` int NOT NULL DEFAULT '0',
  `socketColor_3` tinyint NOT NULL DEFAULT '0',
  `socketContent_3` int NOT NULL DEFAULT '0',
  `socketBonus` int NOT NULL DEFAULT '0',
  `GemProperties` int NOT NULL DEFAULT '0',
  `RequiredDisenchantSkill` smallint NOT NULL DEFAULT '-1',
  `ArmorDamageModifier` float NOT NULL DEFAULT '0',
  `duration` int unsigned NOT NULL DEFAULT '0',
  `ItemLimitCategory` smallint NOT NULL DEFAULT '0',
  `HolidayId` int unsigned NOT NULL DEFAULT '0',
  `ScriptName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `DisenchantID` int unsigned NOT NULL DEFAULT '0',
  `FoodType` tinyint unsigned NOT NULL DEFAULT '0',
  `minMoneyLoot` int unsigned NOT NULL DEFAULT '0',
  `maxMoneyLoot` int unsigned NOT NULL DEFAULT '0',
  `flagsCustom` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`entry`),
  KEY `idx_name` (`name`(250)),
  KEY `items_index` (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Item System'
```

---

## item_template_locale

- 存储引擎: InnoDB
- 行数: 319075

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Name` | `text` | YES |  |  |  |
| `Description` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `item_template_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## itembagfamily_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `itembagfamily_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## itemdisplayinfo_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ModelName_1` | `varchar(100)` | YES |  |  |  |
| `ModelName_2` | `varchar(100)` | YES |  |  |  |
| `ModelTexture_1` | `varchar(100)` | YES |  |  |  |
| `ModelTexture_2` | `varchar(100)` | YES |  |  |  |
| `InventoryIcon_1` | `varchar(100)` | YES |  |  |  |
| `InventoryIcon_2` | `varchar(100)` | YES |  |  |  |
| `GeosetGroup_1` | `int` | NO |  | 0 |  |
| `GeosetGroup_2` | `int` | NO |  | 0 |  |
| `GeosetGroup_3` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `SpellVisualID` | `int` | NO |  | 0 |  |
| `GroupSoundIndex` | `int` | NO |  | 0 |  |
| `HelmetGeosetVis_1` | `int` | NO |  | 0 |  |
| `HelmetGeosetVis_2` | `int` | NO |  | 0 |  |
| `Texture_1` | `varchar(100)` | YES |  |  |  |
| `Texture_2` | `varchar(100)` | YES |  |  |  |
| `Texture_3` | `varchar(100)` | YES |  |  |  |
| `Texture_4` | `varchar(100)` | YES |  |  |  |
| `Texture_5` | `varchar(100)` | YES |  |  |  |
| `Texture_6` | `varchar(100)` | YES |  |  |  |
| `Texture_7` | `varchar(100)` | YES |  |  |  |
| `Texture_8` | `varchar(100)` | YES |  |  |  |
| `ItemVisual` | `int` | NO |  | 0 |  |
| `ParticleColorID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `itemdisplayinfo_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ModelName_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ModelName_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ModelTexture_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ModelTexture_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `InventoryIcon_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `InventoryIcon_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GeosetGroup_1` int NOT NULL DEFAULT '0',
  `GeosetGroup_2` int NOT NULL DEFAULT '0',
  `GeosetGroup_3` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `SpellVisualID` int NOT NULL DEFAULT '0',
  `GroupSoundIndex` int NOT NULL DEFAULT '0',
  `HelmetGeosetVis_1` int NOT NULL DEFAULT '0',
  `HelmetGeosetVis_2` int NOT NULL DEFAULT '0',
  `Texture_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_4` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_6` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_7` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_8` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ItemVisual` int NOT NULL DEFAULT '0',
  `ParticleColorID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## itemextendedcost_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `HonorPoints` | `int` | NO |  | 0 |  |
| `ArenaPoints` | `int` | NO |  | 0 |  |
| `ArenaBracket` | `int` | NO |  | 0 |  |
| `ItemID_1` | `int` | NO |  | 0 |  |
| `ItemID_2` | `int` | NO |  | 0 |  |
| `ItemID_3` | `int` | NO |  | 0 |  |
| `ItemID_4` | `int` | NO |  | 0 |  |
| `ItemID_5` | `int` | NO |  | 0 |  |
| `ItemCount_1` | `int` | NO |  | 0 |  |
| `ItemCount_2` | `int` | NO |  | 0 |  |
| `ItemCount_3` | `int` | NO |  | 0 |  |
| `ItemCount_4` | `int` | NO |  | 0 |  |
| `ItemCount_5` | `int` | NO |  | 0 |  |
| `RequiredArenaRating` | `int` | NO |  | 0 |  |
| `ItemPurchaseGroup` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `itemextendedcost_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `HonorPoints` int NOT NULL DEFAULT '0',
  `ArenaPoints` int NOT NULL DEFAULT '0',
  `ArenaBracket` int NOT NULL DEFAULT '0',
  `ItemID_1` int NOT NULL DEFAULT '0',
  `ItemID_2` int NOT NULL DEFAULT '0',
  `ItemID_3` int NOT NULL DEFAULT '0',
  `ItemID_4` int NOT NULL DEFAULT '0',
  `ItemID_5` int NOT NULL DEFAULT '0',
  `ItemCount_1` int NOT NULL DEFAULT '0',
  `ItemCount_2` int NOT NULL DEFAULT '0',
  `ItemCount_3` int NOT NULL DEFAULT '0',
  `ItemCount_4` int NOT NULL DEFAULT '0',
  `ItemCount_5` int NOT NULL DEFAULT '0',
  `RequiredArenaRating` int NOT NULL DEFAULT '0',
  `ItemPurchaseGroup` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## itemlimitcategory_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Quantity` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `itemlimitcategory_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Quantity` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## itemrandomproperties_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name` | `varchar(100)` | YES |  |  |  |
| `Enchantment_1` | `int` | NO |  | 0 |  |
| `Enchantment_2` | `int` | NO |  | 0 |  |
| `Enchantment_3` | `int` | NO |  | 0 |  |
| `Enchantment_4` | `int` | NO |  | 0 |  |
| `Enchantment_5` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `itemrandomproperties_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Enchantment_1` int NOT NULL DEFAULT '0',
  `Enchantment_2` int NOT NULL DEFAULT '0',
  `Enchantment_3` int NOT NULL DEFAULT '0',
  `Enchantment_4` int NOT NULL DEFAULT '0',
  `Enchantment_5` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## itemrandomsuffix_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `InternalName` | `varchar(100)` | YES |  |  |  |
| `Enchantment_1` | `int` | NO |  | 0 |  |
| `Enchantment_2` | `int` | NO |  | 0 |  |
| `Enchantment_3` | `int` | NO |  | 0 |  |
| `Enchantment_4` | `int` | NO |  | 0 |  |
| `Enchantment_5` | `int` | NO |  | 0 |  |
| `AllocationPct_1` | `int` | NO |  | 0 |  |
| `AllocationPct_2` | `int` | NO |  | 0 |  |
| `AllocationPct_3` | `int` | NO |  | 0 |  |
| `AllocationPct_4` | `int` | NO |  | 0 |  |
| `AllocationPct_5` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `itemrandomsuffix_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `InternalName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Enchantment_1` int NOT NULL DEFAULT '0',
  `Enchantment_2` int NOT NULL DEFAULT '0',
  `Enchantment_3` int NOT NULL DEFAULT '0',
  `Enchantment_4` int NOT NULL DEFAULT '0',
  `Enchantment_5` int NOT NULL DEFAULT '0',
  `AllocationPct_1` int NOT NULL DEFAULT '0',
  `AllocationPct_2` int NOT NULL DEFAULT '0',
  `AllocationPct_3` int NOT NULL DEFAULT '0',
  `AllocationPct_4` int NOT NULL DEFAULT '0',
  `AllocationPct_5` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## itemset_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `ItemID_1` | `int` | NO |  | 0 |  |
| `ItemID_2` | `int` | NO |  | 0 |  |
| `ItemID_3` | `int` | NO |  | 0 |  |
| `ItemID_4` | `int` | NO |  | 0 |  |
| `ItemID_5` | `int` | NO |  | 0 |  |
| `ItemID_6` | `int` | NO |  | 0 |  |
| `ItemID_7` | `int` | NO |  | 0 |  |
| `ItemID_8` | `int` | NO |  | 0 |  |
| `ItemID_9` | `int` | NO |  | 0 |  |
| `ItemID_10` | `int` | NO |  | 0 |  |
| `ItemID_11` | `int` | NO |  | 0 |  |
| `ItemID_12` | `int` | NO |  | 0 |  |
| `ItemID_13` | `int` | NO |  | 0 |  |
| `ItemID_14` | `int` | NO |  | 0 |  |
| `ItemID_15` | `int` | NO |  | 0 |  |
| `ItemID_16` | `int` | NO |  | 0 |  |
| `ItemID_17` | `int` | NO |  | 0 |  |
| `SetSpellID_1` | `int` | NO |  | 0 |  |
| `SetSpellID_2` | `int` | NO |  | 0 |  |
| `SetSpellID_3` | `int` | NO |  | 0 |  |
| `SetSpellID_4` | `int` | NO |  | 0 |  |
| `SetSpellID_5` | `int` | NO |  | 0 |  |
| `SetSpellID_6` | `int` | NO |  | 0 |  |
| `SetSpellID_7` | `int` | NO |  | 0 |  |
| `SetSpellID_8` | `int` | NO |  | 0 |  |
| `SetThreshold_1` | `int` | NO |  | 0 |  |
| `SetThreshold_2` | `int` | NO |  | 0 |  |
| `SetThreshold_3` | `int` | NO |  | 0 |  |
| `SetThreshold_4` | `int` | NO |  | 0 |  |
| `SetThreshold_5` | `int` | NO |  | 0 |  |
| `SetThreshold_6` | `int` | NO |  | 0 |  |
| `SetThreshold_7` | `int` | NO |  | 0 |  |
| `SetThreshold_8` | `int` | NO |  | 0 |  |
| `RequiredSkill` | `int` | NO |  | 0 |  |
| `RequiredSkillRank` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `itemset_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `ItemID_1` int NOT NULL DEFAULT '0',
  `ItemID_2` int NOT NULL DEFAULT '0',
  `ItemID_3` int NOT NULL DEFAULT '0',
  `ItemID_4` int NOT NULL DEFAULT '0',
  `ItemID_5` int NOT NULL DEFAULT '0',
  `ItemID_6` int NOT NULL DEFAULT '0',
  `ItemID_7` int NOT NULL DEFAULT '0',
  `ItemID_8` int NOT NULL DEFAULT '0',
  `ItemID_9` int NOT NULL DEFAULT '0',
  `ItemID_10` int NOT NULL DEFAULT '0',
  `ItemID_11` int NOT NULL DEFAULT '0',
  `ItemID_12` int NOT NULL DEFAULT '0',
  `ItemID_13` int NOT NULL DEFAULT '0',
  `ItemID_14` int NOT NULL DEFAULT '0',
  `ItemID_15` int NOT NULL DEFAULT '0',
  `ItemID_16` int NOT NULL DEFAULT '0',
  `ItemID_17` int NOT NULL DEFAULT '0',
  `SetSpellID_1` int NOT NULL DEFAULT '0',
  `SetSpellID_2` int NOT NULL DEFAULT '0',
  `SetSpellID_3` int NOT NULL DEFAULT '0',
  `SetSpellID_4` int NOT NULL DEFAULT '0',
  `SetSpellID_5` int NOT NULL DEFAULT '0',
  `SetSpellID_6` int NOT NULL DEFAULT '0',
  `SetSpellID_7` int NOT NULL DEFAULT '0',
  `SetSpellID_8` int NOT NULL DEFAULT '0',
  `SetThreshold_1` int NOT NULL DEFAULT '0',
  `SetThreshold_2` int NOT NULL DEFAULT '0',
  `SetThreshold_3` int NOT NULL DEFAULT '0',
  `SetThreshold_4` int NOT NULL DEFAULT '0',
  `SetThreshold_5` int NOT NULL DEFAULT '0',
  `SetThreshold_6` int NOT NULL DEFAULT '0',
  `SetThreshold_7` int NOT NULL DEFAULT '0',
  `SetThreshold_8` int NOT NULL DEFAULT '0',
  `RequiredSkill` int NOT NULL DEFAULT '0',
  `RequiredSkillRank` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## lfg_dungeon_rewards

- 存储引擎: InnoDB
- 行数: 15

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `dungeonId` | `int unsigned` | NO | PRI | 0 |  |
| `maxLevel` | `tinyint unsigned` | NO | PRI | 0 |  |
| `firstQuestId` | `int unsigned` | NO |  | 0 |  |
| `otherQuestId` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `dungeonId` | 是 | BTREE |
| PRIMARY | `maxLevel` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `lfg_dungeon_rewards` (
  `dungeonId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Dungeon entry from dbc',
  `maxLevel` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'Max level at which this reward is rewarded',
  `firstQuestId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for first dungeon this day',
  `otherQuestId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Quest id with rewards for Nth dungeon this day',
  PRIMARY KEY (`dungeonId`,`maxLevel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## lfg_dungeon_template

- 存储引擎: InnoDB
- 行数: 22

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `dungeonId` | `int unsigned` | NO | PRI | 0 |  |
| `name` | `varchar(255)` | YES |  |  |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `dungeonId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `lfg_dungeon_template` (
  `dungeonId` int unsigned NOT NULL DEFAULT '0' COMMENT 'Unique id from LFGDungeons.dbc',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`dungeonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## lfgdungeons_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `text` | YES |  |  |  |
| `Name_Lang_enGB` | `text` | YES |  |  |  |
| `Name_Lang_koKR` | `text` | YES |  |  |  |
| `Name_Lang_frFR` | `text` | YES |  |  |  |
| `Name_Lang_deDE` | `text` | YES |  |  |  |
| `Name_Lang_enCN` | `text` | YES |  |  |  |
| `Name_Lang_zhCN` | `text` | YES |  |  |  |
| `Name_Lang_enTW` | `text` | YES |  |  |  |
| `Name_Lang_zhTW` | `text` | YES |  |  |  |
| `Name_Lang_esES` | `text` | YES |  |  |  |
| `Name_Lang_esMX` | `text` | YES |  |  |  |
| `Name_Lang_ruRU` | `text` | YES |  |  |  |
| `Name_Lang_ptPT` | `text` | YES |  |  |  |
| `Name_Lang_ptBR` | `text` | YES |  |  |  |
| `Name_Lang_itIT` | `text` | YES |  |  |  |
| `Name_Lang_Unk` | `text` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `MinLevel` | `int` | NO |  | 0 |  |
| `MaxLevel` | `int` | NO |  | 0 |  |
| `Target_Level` | `int` | NO |  | 0 |  |
| `Target_Level_Min` | `int` | NO |  | 0 |  |
| `Target_Level_Max` | `int` | NO |  | 0 |  |
| `MapID` | `int` | NO |  | 0 |  |
| `Difficulty` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `TypeID` | `int` | NO |  | 0 |  |
| `Faction` | `int` | NO |  | 0 |  |
| `TextureFilename` | `text` | YES |  |  |  |
| `ExpansionLevel` | `int` | NO |  | 0 |  |
| `Order_Index` | `int` | NO |  | 0 |  |
| `Group_Id` | `int` | NO |  | 0 |  |
| `Description_Lang_enUS` | `text` | YES |  |  |  |
| `Description_Lang_enGB` | `text` | YES |  |  |  |
| `Description_Lang_koKR` | `text` | YES |  |  |  |
| `Description_Lang_frFR` | `text` | YES |  |  |  |
| `Description_Lang_deDE` | `text` | YES |  |  |  |
| `Description_Lang_enCN` | `text` | YES |  |  |  |
| `Description_Lang_zhCN` | `text` | YES |  |  |  |
| `Description_Lang_enTW` | `text` | YES |  |  |  |
| `Description_Lang_zhTW` | `text` | YES |  |  |  |
| `Description_Lang_esES` | `text` | YES |  |  |  |
| `Description_Lang_esMX` | `text` | YES |  |  |  |
| `Description_Lang_ruRU` | `text` | YES |  |  |  |
| `Description_Lang_ptPT` | `text` | YES |  |  |  |
| `Description_Lang_ptBR` | `text` | YES |  |  |  |
| `Description_Lang_itIT` | `text` | YES |  |  |  |
| `Description_Lang_Unk` | `text` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `lfgdungeons_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_Unk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `MinLevel` int NOT NULL DEFAULT '0',
  `MaxLevel` int NOT NULL DEFAULT '0',
  `Target_Level` int NOT NULL DEFAULT '0',
  `Target_Level_Min` int NOT NULL DEFAULT '0',
  `Target_Level_Max` int NOT NULL DEFAULT '0',
  `MapID` int NOT NULL DEFAULT '0',
  `Difficulty` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `TypeID` int NOT NULL DEFAULT '0',
  `Faction` int NOT NULL DEFAULT '0',
  `TextureFilename` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ExpansionLevel` int NOT NULL DEFAULT '0',
  `Order_Index` int NOT NULL DEFAULT '0',
  `Group_Id` int NOT NULL DEFAULT '0',
  `Description_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_Unk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## light_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ContinentID` | `int` | NO |  | 0 |  |
| `X` | `float` | NO |  | 0 |  |
| `Y` | `float` | NO |  | 0 |  |
| `Z` | `float` | NO |  | 0 |  |
| `FalloffStart` | `float` | NO |  | 0 |  |
| `FalloffEnd` | `float` | NO |  | 0 |  |
| `LightParamsID_1` | `int` | NO |  | 0 |  |
| `LightParamsID_2` | `int` | NO |  | 0 |  |
| `LightParamsID_3` | `int` | NO |  | 0 |  |
| `LightParamsID_4` | `int` | NO |  | 0 |  |
| `LightParamsID_5` | `int` | NO |  | 0 |  |
| `LightParamsID_6` | `int` | NO |  | 0 |  |
| `LightParamsID_7` | `int` | NO |  | 0 |  |
| `LightParamsID_8` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `light_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ContinentID` int NOT NULL DEFAULT '0',
  `X` float NOT NULL DEFAULT '0',
  `Y` float NOT NULL DEFAULT '0',
  `Z` float NOT NULL DEFAULT '0',
  `FalloffStart` float NOT NULL DEFAULT '0',
  `FalloffEnd` float NOT NULL DEFAULT '0',
  `LightParamsID_1` int NOT NULL DEFAULT '0',
  `LightParamsID_2` int NOT NULL DEFAULT '0',
  `LightParamsID_3` int NOT NULL DEFAULT '0',
  `LightParamsID_4` int NOT NULL DEFAULT '0',
  `LightParamsID_5` int NOT NULL DEFAULT '0',
  `LightParamsID_6` int NOT NULL DEFAULT '0',
  `LightParamsID_7` int NOT NULL DEFAULT '0',
  `LightParamsID_8` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## linked_respawn

- 存储引擎: InnoDB
- 行数: 4279
- 注释: Creature Respawn Link System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI |  |  |
| `linkedGuid` | `int unsigned` | NO |  |  |  |
| `linkType` | `tinyint unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| PRIMARY | `linkType` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `linked_respawn` (
  `guid` int unsigned NOT NULL COMMENT 'dependent creature',
  `linkedGuid` int unsigned NOT NULL COMMENT 'master creature',
  `linkType` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`linkType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature Respawn Link System'
```

---

## liquidtype_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name` | `varchar(100)` | YES |  |  |  |
| `Flags` | `int` | NO |  | 0 |  |
| `Type` | `int` | NO |  | 0 |  |
| `SoundID` | `int` | NO |  | 0 |  |
| `SpellID` | `int` | NO |  | 0 |  |
| `MaxDarkenDepth` | `float` | NO |  | 0 |  |
| `FogDarkenintensity` | `float` | NO |  | 0 |  |
| `AmbDarkenintensity` | `float` | NO |  | 0 |  |
| `DirDarkenintensity` | `float` | NO |  | 0 |  |
| `LightID` | `int` | NO |  | 0 |  |
| `ParticleScale` | `float` | NO |  | 0 |  |
| `ParticleMovement` | `int` | NO |  | 0 |  |
| `ParticleTexSlots` | `int` | NO |  | 0 |  |
| `MaterialID` | `int` | NO |  | 0 |  |
| `Texture_1` | `varchar(100)` | YES |  |  |  |
| `Texture_2` | `varchar(100)` | YES |  |  |  |
| `Texture_3` | `varchar(100)` | YES |  |  |  |
| `Texture_4` | `varchar(100)` | YES |  |  |  |
| `Texture_5` | `varchar(100)` | YES |  |  |  |
| `Texture_6` | `varchar(100)` | YES |  |  |  |
| `Color_1` | `int` | NO |  | 0 |  |
| `Color_2` | `int` | NO |  | 0 |  |
| `Float_1` | `float` | NO |  | 0 |  |
| `Float_2` | `float` | NO |  | 0 |  |
| `Float_3` | `float` | NO |  | 0 |  |
| `Float_4` | `float` | NO |  | 0 |  |
| `Float_5` | `float` | NO |  | 0 |  |
| `Float_6` | `float` | NO |  | 0 |  |
| `Float_7` | `float` | NO |  | 0 |  |
| `Float_8` | `float` | NO |  | 0 |  |
| `Float_9` | `float` | NO |  | 0 |  |
| `Float_10` | `float` | NO |  | 0 |  |
| `Float_11` | `float` | NO |  | 0 |  |
| `Float_12` | `float` | NO |  | 0 |  |
| `Float_13` | `float` | NO |  | 0 |  |
| `Float_14` | `float` | NO |  | 0 |  |
| `Float_15` | `float` | NO |  | 0 |  |
| `Float_16` | `float` | NO |  | 0 |  |
| `Float_17` | `float` | NO |  | 0 |  |
| `Float_18` | `float` | NO |  | 0 |  |
| `Int_1` | `int` | NO |  | 0 |  |
| `Int_2` | `int` | NO |  | 0 |  |
| `Int_3` | `int` | NO |  | 0 |  |
| `Int_4` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `liquidtype_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Flags` int NOT NULL DEFAULT '0',
  `Type` int NOT NULL DEFAULT '0',
  `SoundID` int NOT NULL DEFAULT '0',
  `SpellID` int NOT NULL DEFAULT '0',
  `MaxDarkenDepth` float NOT NULL DEFAULT '0',
  `FogDarkenintensity` float NOT NULL DEFAULT '0',
  `AmbDarkenintensity` float NOT NULL DEFAULT '0',
  `DirDarkenintensity` float NOT NULL DEFAULT '0',
  `LightID` int NOT NULL DEFAULT '0',
  `ParticleScale` float NOT NULL DEFAULT '0',
  `ParticleMovement` int NOT NULL DEFAULT '0',
  `ParticleTexSlots` int NOT NULL DEFAULT '0',
  `MaterialID` int NOT NULL DEFAULT '0',
  `Texture_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_4` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Texture_6` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Color_1` int NOT NULL DEFAULT '0',
  `Color_2` int NOT NULL DEFAULT '0',
  `Float_1` float NOT NULL DEFAULT '0',
  `Float_2` float NOT NULL DEFAULT '0',
  `Float_3` float NOT NULL DEFAULT '0',
  `Float_4` float NOT NULL DEFAULT '0',
  `Float_5` float NOT NULL DEFAULT '0',
  `Float_6` float NOT NULL DEFAULT '0',
  `Float_7` float NOT NULL DEFAULT '0',
  `Float_8` float NOT NULL DEFAULT '0',
  `Float_9` float NOT NULL DEFAULT '0',
  `Float_10` float NOT NULL DEFAULT '0',
  `Float_11` float NOT NULL DEFAULT '0',
  `Float_12` float NOT NULL DEFAULT '0',
  `Float_13` float NOT NULL DEFAULT '0',
  `Float_14` float NOT NULL DEFAULT '0',
  `Float_15` float NOT NULL DEFAULT '0',
  `Float_16` float NOT NULL DEFAULT '0',
  `Float_17` float NOT NULL DEFAULT '0',
  `Float_18` float NOT NULL DEFAULT '0',
  `Int_1` int NOT NULL DEFAULT '0',
  `Int_2` int NOT NULL DEFAULT '0',
  `Int_3` int NOT NULL DEFAULT '0',
  `Int_4` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## lock_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Type_1` | `int` | NO |  | 0 |  |
| `Type_2` | `int` | NO |  | 0 |  |
| `Type_3` | `int` | NO |  | 0 |  |
| `Type_4` | `int` | NO |  | 0 |  |
| `Type_5` | `int` | NO |  | 0 |  |
| `Type_6` | `int` | NO |  | 0 |  |
| `Type_7` | `int` | NO |  | 0 |  |
| `Type_8` | `int` | NO |  | 0 |  |
| `Index_1` | `int` | NO |  | 0 |  |
| `Index_2` | `int` | NO |  | 0 |  |
| `Index_3` | `int` | NO |  | 0 |  |
| `Index_4` | `int` | NO |  | 0 |  |
| `Index_5` | `int` | NO |  | 0 |  |
| `Index_6` | `int` | NO |  | 0 |  |
| `Index_7` | `int` | NO |  | 0 |  |
| `Index_8` | `int` | NO |  | 0 |  |
| `Skill_1` | `int` | NO |  | 0 |  |
| `Skill_2` | `int` | NO |  | 0 |  |
| `Skill_3` | `int` | NO |  | 0 |  |
| `Skill_4` | `int` | NO |  | 0 |  |
| `Skill_5` | `int` | NO |  | 0 |  |
| `Skill_6` | `int` | NO |  | 0 |  |
| `Skill_7` | `int` | NO |  | 0 |  |
| `Skill_8` | `int` | NO |  | 0 |  |
| `Action_1` | `int` | NO |  | 0 |  |
| `Action_2` | `int` | NO |  | 0 |  |
| `Action_3` | `int` | NO |  | 0 |  |
| `Action_4` | `int` | NO |  | 0 |  |
| `Action_5` | `int` | NO |  | 0 |  |
| `Action_6` | `int` | NO |  | 0 |  |
| `Action_7` | `int` | NO |  | 0 |  |
| `Action_8` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `lock_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Type_1` int NOT NULL DEFAULT '0',
  `Type_2` int NOT NULL DEFAULT '0',
  `Type_3` int NOT NULL DEFAULT '0',
  `Type_4` int NOT NULL DEFAULT '0',
  `Type_5` int NOT NULL DEFAULT '0',
  `Type_6` int NOT NULL DEFAULT '0',
  `Type_7` int NOT NULL DEFAULT '0',
  `Type_8` int NOT NULL DEFAULT '0',
  `Index_1` int NOT NULL DEFAULT '0',
  `Index_2` int NOT NULL DEFAULT '0',
  `Index_3` int NOT NULL DEFAULT '0',
  `Index_4` int NOT NULL DEFAULT '0',
  `Index_5` int NOT NULL DEFAULT '0',
  `Index_6` int NOT NULL DEFAULT '0',
  `Index_7` int NOT NULL DEFAULT '0',
  `Index_8` int NOT NULL DEFAULT '0',
  `Skill_1` int NOT NULL DEFAULT '0',
  `Skill_2` int NOT NULL DEFAULT '0',
  `Skill_3` int NOT NULL DEFAULT '0',
  `Skill_4` int NOT NULL DEFAULT '0',
  `Skill_5` int NOT NULL DEFAULT '0',
  `Skill_6` int NOT NULL DEFAULT '0',
  `Skill_7` int NOT NULL DEFAULT '0',
  `Skill_8` int NOT NULL DEFAULT '0',
  `Action_1` int NOT NULL DEFAULT '0',
  `Action_2` int NOT NULL DEFAULT '0',
  `Action_3` int NOT NULL DEFAULT '0',
  `Action_4` int NOT NULL DEFAULT '0',
  `Action_5` int NOT NULL DEFAULT '0',
  `Action_6` int NOT NULL DEFAULT '0',
  `Action_7` int NOT NULL DEFAULT '0',
  `Action_8` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## mail_level_reward

- 存储引擎: InnoDB
- 行数: 24
- 注释: Mail System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `level` | `tinyint unsigned` | NO | PRI | 0 |  |
| `raceMask` | `int unsigned` | NO | PRI | 0 |  |
| `mailTemplateId` | `int unsigned` | NO |  | 0 |  |
| `senderEntry` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `level` | 是 | BTREE |
| PRIMARY | `raceMask` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `mail_level_reward` (
  `level` tinyint unsigned NOT NULL DEFAULT '0',
  `raceMask` int unsigned NOT NULL DEFAULT '0',
  `mailTemplateId` int unsigned NOT NULL DEFAULT '0',
  `senderEntry` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`,`raceMask`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Mail System'
```

---

## mail_loot_template

- 存储引擎: InnoDB
- 行数: 112
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `mail_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## mailtemplate_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Subject_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Subject_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Body_Lang_enUS` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_enGB` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_koKR` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_frFR` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_deDE` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_enCN` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_zhCN` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_enTW` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_zhTW` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_esES` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_esMX` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_ruRU` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_ptPT` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_ptBR` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_itIT` | `varchar(500)` | YES |  |  |  |
| `Body_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Body_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `mailtemplate_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Subject_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Subject_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Body_Lang_enUS` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_enGB` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_koKR` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_frFR` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_deDE` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_enCN` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_zhCN` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_enTW` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_zhTW` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_esES` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_esMX` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_ruRU` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_ptPT` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_ptBR` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_itIT` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Body_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## map_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Directory` | `varchar(100)` | YES |  |  |  |
| `InstanceType` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `PVP` | `int` | NO |  | 0 |  |
| `MapName_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `MapName_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `AreaTableID` | `int` | NO |  | 0 |  |
| `MapDescription0_Lang_enUS` | `text` | YES |  |  |  |
| `MapDescription0_Lang_enGB` | `text` | YES |  |  |  |
| `MapDescription0_Lang_koKR` | `text` | YES |  |  |  |
| `MapDescription0_Lang_frFR` | `text` | YES |  |  |  |
| `MapDescription0_Lang_deDE` | `text` | YES |  |  |  |
| `MapDescription0_Lang_enCN` | `text` | YES |  |  |  |
| `MapDescription0_Lang_zhCN` | `text` | YES |  |  |  |
| `MapDescription0_Lang_enTW` | `text` | YES |  |  |  |
| `MapDescription0_Lang_zhTW` | `text` | YES |  |  |  |
| `MapDescription0_Lang_esES` | `text` | YES |  |  |  |
| `MapDescription0_Lang_esMX` | `text` | YES |  |  |  |
| `MapDescription0_Lang_ruRU` | `text` | YES |  |  |  |
| `MapDescription0_Lang_ptPT` | `text` | YES |  |  |  |
| `MapDescription0_Lang_ptBR` | `text` | YES |  |  |  |
| `MapDescription0_Lang_itIT` | `text` | YES |  |  |  |
| `MapDescription0_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `MapDescription0_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `MapDescription1_Lang_enUS` | `text` | YES |  |  |  |
| `MapDescription1_Lang_enGB` | `text` | YES |  |  |  |
| `MapDescription1_Lang_koKR` | `text` | YES |  |  |  |
| `MapDescription1_Lang_frFR` | `text` | YES |  |  |  |
| `MapDescription1_Lang_deDE` | `text` | YES |  |  |  |
| `MapDescription1_Lang_enCN` | `text` | YES |  |  |  |
| `MapDescription1_Lang_zhCN` | `text` | YES |  |  |  |
| `MapDescription1_Lang_enTW` | `text` | YES |  |  |  |
| `MapDescription1_Lang_zhTW` | `text` | YES |  |  |  |
| `MapDescription1_Lang_esES` | `text` | YES |  |  |  |
| `MapDescription1_Lang_esMX` | `text` | YES |  |  |  |
| `MapDescription1_Lang_ruRU` | `text` | YES |  |  |  |
| `MapDescription1_Lang_ptPT` | `text` | YES |  |  |  |
| `MapDescription1_Lang_ptBR` | `text` | YES |  |  |  |
| `MapDescription1_Lang_itIT` | `text` | YES |  |  |  |
| `MapDescription1_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `MapDescription1_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `LoadingScreenID` | `int` | NO |  | 0 |  |
| `MinimapIconScale` | `float` | NO |  | 0 |  |
| `CorpseMapID` | `int` | NO |  | 0 |  |
| `CorpseX` | `float` | NO |  | 0 |  |
| `CorpseY` | `float` | NO |  | 0 |  |
| `TimeOfDayOverride` | `int` | NO |  | 0 |  |
| `ExpansionID` | `int` | NO |  | 0 |  |
| `RaidOffset` | `int` | NO |  | 0 |  |
| `MaxPlayers` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `map_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Directory` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `InstanceType` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `PVP` int NOT NULL DEFAULT '0',
  `MapName_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `AreaTableID` int NOT NULL DEFAULT '0',
  `MapDescription0_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription0_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapDescription0_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `MapDescription1_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `MapDescription1_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MapDescription1_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `LoadingScreenID` int NOT NULL DEFAULT '0',
  `MinimapIconScale` float NOT NULL DEFAULT '0',
  `CorpseMapID` int NOT NULL DEFAULT '0',
  `CorpseX` float NOT NULL DEFAULT '0',
  `CorpseY` float NOT NULL DEFAULT '0',
  `TimeOfDayOverride` int NOT NULL DEFAULT '0',
  `ExpansionID` int NOT NULL DEFAULT '0',
  `RaidOffset` int NOT NULL DEFAULT '0',
  `MaxPlayers` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## mapdifficulty_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `MapID` | `int` | NO |  | 0 |  |
| `Difficulty` | `int` | NO |  | 0 |  |
| `Message_Lang_enUS` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_enGB` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_koKR` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_frFR` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_deDE` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_enCN` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_zhCN` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_enTW` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_zhTW` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_esES` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_esMX` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_ruRU` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_ptPT` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_ptBR` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_itIT` | `varchar(200)` | YES |  |  |  |
| `Message_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Message_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `RaidDuration` | `int` | NO |  | 0 |  |
| `MaxPlayers` | `int` | NO |  | 0 |  |
| `Difficultystring` | `varchar(100)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `mapdifficulty_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `MapID` int NOT NULL DEFAULT '0',
  `Difficulty` int NOT NULL DEFAULT '0',
  `Message_Lang_enUS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_enGB` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_koKR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_frFR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_deDE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_enCN` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_zhCN` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_enTW` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_zhTW` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_esES` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_esMX` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_ruRU` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_ptPT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_ptBR` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_itIT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Message_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `RaidDuration` int NOT NULL DEFAULT '0',
  `MaxPlayers` int NOT NULL DEFAULT '0',
  `Difficultystring` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## milling_loot_template

- 存储引擎: InnoDB
- 行数: 45
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `milling_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## module_string

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `module` | `varchar(255)` | NO | PRI |  |  |
| `id` | `int unsigned` | NO | PRI |  |  |
| `string` | `text` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `module` | 是 | BTREE |
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `module_string` (
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'module dir name, eg mod-cfbg',
  `id` int unsigned NOT NULL,
  `string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`module`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## module_string_locale

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `module` | `varchar(255)` | NO | PRI |  |  |
| `id` | `int unsigned` | NO | PRI |  |  |
| `locale` | `enum('koKR','frFR','deDE','zhCN','zhTW','esES','esMX','ruRU')` | NO | PRI |  |  |
| `string` | `text` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `module` | 是 | BTREE |
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `module_string_locale` (
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Corresponds to an existing entry in module_string',
  `id` int unsigned NOT NULL COMMENT 'Corresponds to an existing entry in module_string',
  `locale` enum('koKR','frFR','deDE','zhCN','zhTW','esES','esMX','ruRU') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`module`,`id`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## movie_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Filename` | `varchar(100)` | YES |  |  |  |
| `Volume` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `movie_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Volume` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## namesprofanity_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI |  |  |
| `Pattern` | `tinytext` | NO |  |  |  |
| `LanguagueID` | `tinyint` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `namesprofanity_dbc` (
  `ID` int unsigned NOT NULL,
  `Pattern` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `LanguagueID` tinyint NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## namesreserved_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI |  |  |
| `Pattern` | `tinytext` | NO |  |  |  |
| `LanguagueID` | `tinyint` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `namesreserved_dbc` (
  `ID` int unsigned NOT NULL,
  `Pattern` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `LanguagueID` tinyint NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## npc_spellclick_spells

- 存储引擎: InnoDB
- 行数: 334

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `npc_entry` | `int unsigned` | NO | PRI |  |  |
| `spell_id` | `int unsigned` | NO | PRI |  |  |
| `cast_flags` | `tinyint unsigned` | NO |  |  |  |
| `user_type` | `smallint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `npc_entry` | 是 | BTREE |
| PRIMARY | `spell_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `npc_spellclick_spells` (
  `npc_entry` int unsigned NOT NULL COMMENT 'reference to creature_template',
  `spell_id` int unsigned NOT NULL COMMENT 'spell which should be casted ',
  `cast_flags` tinyint unsigned NOT NULL COMMENT 'first bit defines caster: 1=player, 0=creature; second bit defines target, same mapping as caster bit',
  `user_type` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'relation with summoner: 0-no 1-friendly 2-raid 3-party player can click',
  PRIMARY KEY (`npc_entry`,`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## npc_text

- 存储引擎: InnoDB
- 行数: 8201

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `text0_0` | `longtext` | YES |  |  |  |
| `text0_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID0` | `int` | NO |  | 0 |  |
| `lang0` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability0` | `float` | NO |  | 0 |  |
| `em0_0` | `smallint unsigned` | NO |  | 0 |  |
| `em0_1` | `smallint unsigned` | NO |  | 0 |  |
| `em0_2` | `smallint unsigned` | NO |  | 0 |  |
| `em0_3` | `smallint unsigned` | NO |  | 0 |  |
| `em0_4` | `smallint unsigned` | NO |  | 0 |  |
| `em0_5` | `smallint unsigned` | NO |  | 0 |  |
| `text1_0` | `longtext` | YES |  |  |  |
| `text1_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID1` | `int` | NO |  | 0 |  |
| `lang1` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability1` | `float` | NO |  | 0 |  |
| `em1_0` | `smallint unsigned` | NO |  | 0 |  |
| `em1_1` | `smallint unsigned` | NO |  | 0 |  |
| `em1_2` | `smallint unsigned` | NO |  | 0 |  |
| `em1_3` | `smallint unsigned` | NO |  | 0 |  |
| `em1_4` | `smallint unsigned` | NO |  | 0 |  |
| `em1_5` | `smallint unsigned` | NO |  | 0 |  |
| `text2_0` | `longtext` | YES |  |  |  |
| `text2_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID2` | `int` | NO |  | 0 |  |
| `lang2` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability2` | `float` | NO |  | 0 |  |
| `em2_0` | `smallint unsigned` | NO |  | 0 |  |
| `em2_1` | `smallint unsigned` | NO |  | 0 |  |
| `em2_2` | `smallint unsigned` | NO |  | 0 |  |
| `em2_3` | `smallint unsigned` | NO |  | 0 |  |
| `em2_4` | `smallint unsigned` | NO |  | 0 |  |
| `em2_5` | `smallint unsigned` | NO |  | 0 |  |
| `text3_0` | `longtext` | YES |  |  |  |
| `text3_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID3` | `int` | NO |  | 0 |  |
| `lang3` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability3` | `float` | NO |  | 0 |  |
| `em3_0` | `smallint unsigned` | NO |  | 0 |  |
| `em3_1` | `smallint unsigned` | NO |  | 0 |  |
| `em3_2` | `smallint unsigned` | NO |  | 0 |  |
| `em3_3` | `smallint unsigned` | NO |  | 0 |  |
| `em3_4` | `smallint unsigned` | NO |  | 0 |  |
| `em3_5` | `smallint unsigned` | NO |  | 0 |  |
| `text4_0` | `longtext` | YES |  |  |  |
| `text4_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID4` | `int` | NO |  | 0 |  |
| `lang4` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability4` | `float` | NO |  | 0 |  |
| `em4_0` | `smallint unsigned` | NO |  | 0 |  |
| `em4_1` | `smallint unsigned` | NO |  | 0 |  |
| `em4_2` | `smallint unsigned` | NO |  | 0 |  |
| `em4_3` | `smallint unsigned` | NO |  | 0 |  |
| `em4_4` | `smallint unsigned` | NO |  | 0 |  |
| `em4_5` | `smallint unsigned` | NO |  | 0 |  |
| `text5_0` | `longtext` | YES |  |  |  |
| `text5_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID5` | `int` | NO |  | 0 |  |
| `lang5` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability5` | `float` | NO |  | 0 |  |
| `em5_0` | `smallint unsigned` | NO |  | 0 |  |
| `em5_1` | `smallint unsigned` | NO |  | 0 |  |
| `em5_2` | `smallint unsigned` | NO |  | 0 |  |
| `em5_3` | `smallint unsigned` | NO |  | 0 |  |
| `em5_4` | `smallint unsigned` | NO |  | 0 |  |
| `em5_5` | `smallint unsigned` | NO |  | 0 |  |
| `text6_0` | `longtext` | YES |  |  |  |
| `text6_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID6` | `int` | NO |  | 0 |  |
| `lang6` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability6` | `float` | NO |  | 0 |  |
| `em6_0` | `smallint unsigned` | NO |  | 0 |  |
| `em6_1` | `smallint unsigned` | NO |  | 0 |  |
| `em6_2` | `smallint unsigned` | NO |  | 0 |  |
| `em6_3` | `smallint unsigned` | NO |  | 0 |  |
| `em6_4` | `smallint unsigned` | NO |  | 0 |  |
| `em6_5` | `smallint unsigned` | NO |  | 0 |  |
| `text7_0` | `longtext` | YES |  |  |  |
| `text7_1` | `longtext` | YES |  |  |  |
| `BroadcastTextID7` | `int` | NO |  | 0 |  |
| `lang7` | `tinyint unsigned` | NO |  | 0 |  |
| `Probability7` | `float` | NO |  | 0 |  |
| `em7_0` | `smallint unsigned` | NO |  | 0 |  |
| `em7_1` | `smallint unsigned` | NO |  | 0 |  |
| `em7_2` | `smallint unsigned` | NO |  | 0 |  |
| `em7_3` | `smallint unsigned` | NO |  | 0 |  |
| `em7_4` | `smallint unsigned` | NO |  | 0 |  |
| `em7_5` | `smallint unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `npc_text` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `text0_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text0_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID0` int NOT NULL DEFAULT '0',
  `lang0` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability0` float NOT NULL DEFAULT '0',
  `em0_0` smallint unsigned NOT NULL DEFAULT '0',
  `em0_1` smallint unsigned NOT NULL DEFAULT '0',
  `em0_2` smallint unsigned NOT NULL DEFAULT '0',
  `em0_3` smallint unsigned NOT NULL DEFAULT '0',
  `em0_4` smallint unsigned NOT NULL DEFAULT '0',
  `em0_5` smallint unsigned NOT NULL DEFAULT '0',
  `text1_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text1_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID1` int NOT NULL DEFAULT '0',
  `lang1` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability1` float NOT NULL DEFAULT '0',
  `em1_0` smallint unsigned NOT NULL DEFAULT '0',
  `em1_1` smallint unsigned NOT NULL DEFAULT '0',
  `em1_2` smallint unsigned NOT NULL DEFAULT '0',
  `em1_3` smallint unsigned NOT NULL DEFAULT '0',
  `em1_4` smallint unsigned NOT NULL DEFAULT '0',
  `em1_5` smallint unsigned NOT NULL DEFAULT '0',
  `text2_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text2_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID2` int NOT NULL DEFAULT '0',
  `lang2` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability2` float NOT NULL DEFAULT '0',
  `em2_0` smallint unsigned NOT NULL DEFAULT '0',
  `em2_1` smallint unsigned NOT NULL DEFAULT '0',
  `em2_2` smallint unsigned NOT NULL DEFAULT '0',
  `em2_3` smallint unsigned NOT NULL DEFAULT '0',
  `em2_4` smallint unsigned NOT NULL DEFAULT '0',
  `em2_5` smallint unsigned NOT NULL DEFAULT '0',
  `text3_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text3_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID3` int NOT NULL DEFAULT '0',
  `lang3` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability3` float NOT NULL DEFAULT '0',
  `em3_0` smallint unsigned NOT NULL DEFAULT '0',
  `em3_1` smallint unsigned NOT NULL DEFAULT '0',
  `em3_2` smallint unsigned NOT NULL DEFAULT '0',
  `em3_3` smallint unsigned NOT NULL DEFAULT '0',
  `em3_4` smallint unsigned NOT NULL DEFAULT '0',
  `em3_5` smallint unsigned NOT NULL DEFAULT '0',
  `text4_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text4_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID4` int NOT NULL DEFAULT '0',
  `lang4` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability4` float NOT NULL DEFAULT '0',
  `em4_0` smallint unsigned NOT NULL DEFAULT '0',
  `em4_1` smallint unsigned NOT NULL DEFAULT '0',
  `em4_2` smallint unsigned NOT NULL DEFAULT '0',
  `em4_3` smallint unsigned NOT NULL DEFAULT '0',
  `em4_4` smallint unsigned NOT NULL DEFAULT '0',
  `em4_5` smallint unsigned NOT NULL DEFAULT '0',
  `text5_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text5_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID5` int NOT NULL DEFAULT '0',
  `lang5` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability5` float NOT NULL DEFAULT '0',
  `em5_0` smallint unsigned NOT NULL DEFAULT '0',
  `em5_1` smallint unsigned NOT NULL DEFAULT '0',
  `em5_2` smallint unsigned NOT NULL DEFAULT '0',
  `em5_3` smallint unsigned NOT NULL DEFAULT '0',
  `em5_4` smallint unsigned NOT NULL DEFAULT '0',
  `em5_5` smallint unsigned NOT NULL DEFAULT '0',
  `text6_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text6_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID6` int NOT NULL DEFAULT '0',
  `lang6` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability6` float NOT NULL DEFAULT '0',
  `em6_0` smallint unsigned NOT NULL DEFAULT '0',
  `em6_1` smallint unsigned NOT NULL DEFAULT '0',
  `em6_2` smallint unsigned NOT NULL DEFAULT '0',
  `em6_3` smallint unsigned NOT NULL DEFAULT '0',
  `em6_4` smallint unsigned NOT NULL DEFAULT '0',
  `em6_5` smallint unsigned NOT NULL DEFAULT '0',
  `text7_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text7_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `BroadcastTextID7` int NOT NULL DEFAULT '0',
  `lang7` tinyint unsigned NOT NULL DEFAULT '0',
  `Probability7` float NOT NULL DEFAULT '0',
  `em7_0` smallint unsigned NOT NULL DEFAULT '0',
  `em7_1` smallint unsigned NOT NULL DEFAULT '0',
  `em7_2` smallint unsigned NOT NULL DEFAULT '0',
  `em7_3` smallint unsigned NOT NULL DEFAULT '0',
  `em7_4` smallint unsigned NOT NULL DEFAULT '0',
  `em7_5` smallint unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## npc_text_locale

- 存储引擎: InnoDB
- 行数: 20129

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `Locale` | `varchar(4)` | NO | PRI |  |  |
| `Text0_0` | `longtext` | YES |  |  |  |
| `Text0_1` | `longtext` | YES |  |  |  |
| `Text1_0` | `longtext` | YES |  |  |  |
| `Text1_1` | `longtext` | YES |  |  |  |
| `Text2_0` | `longtext` | YES |  |  |  |
| `Text2_1` | `longtext` | YES |  |  |  |
| `Text3_0` | `longtext` | YES |  |  |  |
| `Text3_1` | `longtext` | YES |  |  |  |
| `Text4_0` | `longtext` | YES |  |  |  |
| `Text4_1` | `longtext` | YES |  |  |  |
| `Text5_0` | `longtext` | YES |  |  |  |
| `Text5_1` | `longtext` | YES |  |  |  |
| `Text6_0` | `longtext` | YES |  |  |  |
| `Text6_1` | `longtext` | YES |  |  |  |
| `Text7_0` | `longtext` | YES |  |  |  |
| `Text7_1` | `longtext` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `Locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `npc_text_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `Locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Text0_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text0_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text1_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text1_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text2_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text2_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text3_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text3_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text4_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text4_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text5_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text5_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text6_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text6_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text7_0` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Text7_1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID`,`Locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## npc_trainer

- 存储引擎: InnoDB
- 行数: 4934

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `SpellID` | `int` | NO | PRI | 0 |  |
| `MoneyCost` | `int unsigned` | NO |  | 0 |  |
| `ReqSkillLine` | `smallint unsigned` | NO |  | 0 |  |
| `ReqSkillRank` | `smallint unsigned` | NO |  | 0 |  |
| `ReqLevel` | `tinyint unsigned` | NO |  | 0 |  |
| `ReqSpell` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `SpellID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `npc_trainer` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `SpellID` int NOT NULL DEFAULT '0',
  `MoneyCost` int unsigned NOT NULL DEFAULT '0',
  `ReqSkillLine` smallint unsigned NOT NULL DEFAULT '0',
  `ReqSkillRank` smallint unsigned NOT NULL DEFAULT '0',
  `ReqLevel` tinyint unsigned NOT NULL DEFAULT '0',
  `ReqSpell` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`SpellID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## npc_vendor

- 存储引擎: InnoDB
- 行数: 37962
- 注释: Npc System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `slot` | `smallint` | NO | MUL | 0 |  |
| `item` | `int` | NO | PRI | 0 |  |
| `maxcount` | `int unsigned` | NO |  | 0 |  |
| `incrtime` | `int unsigned` | NO |  | 0 |  |
| `ExtendedCost` | `int unsigned` | NO | PRI | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| PRIMARY | `item` | 是 | BTREE |
| PRIMARY | `ExtendedCost` | 是 | BTREE |
| slot | `slot` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `npc_vendor` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `slot` smallint NOT NULL DEFAULT '0',
  `item` int NOT NULL DEFAULT '0',
  `maxcount` int unsigned NOT NULL DEFAULT '0',
  `incrtime` int unsigned NOT NULL DEFAULT '0',
  `ExtendedCost` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`entry`,`item`,`ExtendedCost`),
  KEY `slot` (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Npc System'
```

---

## outdoorpvp_template

- 存储引擎: InnoDB
- 行数: 7
- 注释: OutdoorPvP Templates

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `TypeId` | `tinyint unsigned` | NO | PRI |  |  |
| `ScriptName` | `char(64)` | NO |  |  |  |
| `comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `TypeId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `outdoorpvp_template` (
  `TypeId` tinyint unsigned NOT NULL,
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`TypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='OutdoorPvP Templates'
```

---

## overridespelldata_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Spells_1` | `int` | NO |  | 0 |  |
| `Spells_2` | `int` | NO |  | 0 |  |
| `Spells_3` | `int` | NO |  | 0 |  |
| `Spells_4` | `int` | NO |  | 0 |  |
| `Spells_5` | `int` | NO |  | 0 |  |
| `Spells_6` | `int` | NO |  | 0 |  |
| `Spells_7` | `int` | NO |  | 0 |  |
| `Spells_8` | `int` | NO |  | 0 |  |
| `Spells_9` | `int` | NO |  | 0 |  |
| `Spells_10` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `overridespelldata_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Spells_1` int NOT NULL DEFAULT '0',
  `Spells_2` int NOT NULL DEFAULT '0',
  `Spells_3` int NOT NULL DEFAULT '0',
  `Spells_4` int NOT NULL DEFAULT '0',
  `Spells_5` int NOT NULL DEFAULT '0',
  `Spells_6` int NOT NULL DEFAULT '0',
  `Spells_7` int NOT NULL DEFAULT '0',
  `Spells_8` int NOT NULL DEFAULT '0',
  `Spells_9` int NOT NULL DEFAULT '0',
  `Spells_10` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## page_text

- 存储引擎: InnoDB
- 行数: 1962
- 注释: Item System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `Text` | `longtext` | NO |  |  |  |
| `NextPageID` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `page_text` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `Text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `NextPageID` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Item System'
```

---

## page_text_locale

- 存储引擎: InnoDB
- 行数: 10207

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Text` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `page_text_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pet_levelstats

- 存储引擎: InnoDB
- 行数: 2800
- 注释: Stores pet levels stats.

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `creature_entry` | `int unsigned` | NO | PRI |  |  |
| `level` | `tinyint unsigned` | NO | PRI |  |  |
| `hp` | `int unsigned` | NO |  | 0 |  |
| `mana` | `int unsigned` | NO |  | 0 |  |
| `armor` | `int unsigned` | NO |  | 0 |  |
| `str` | `int unsigned` | NO |  | 0 |  |
| `agi` | `int unsigned` | NO |  | 0 |  |
| `sta` | `int unsigned` | NO |  | 0 |  |
| `inte` | `int unsigned` | NO |  | 0 |  |
| `spi` | `int unsigned` | NO |  | 0 |  |
| `min_dmg` | `int unsigned` | NO |  | 0 |  |
| `max_dmg` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `creature_entry` | 是 | BTREE |
| PRIMARY | `level` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pet_levelstats` (
  `creature_entry` int unsigned NOT NULL,
  `level` tinyint unsigned NOT NULL,
  `hp` int unsigned NOT NULL DEFAULT '0',
  `mana` int unsigned NOT NULL DEFAULT '0',
  `armor` int unsigned NOT NULL DEFAULT '0',
  `str` int unsigned NOT NULL DEFAULT '0',
  `agi` int unsigned NOT NULL DEFAULT '0',
  `sta` int unsigned NOT NULL DEFAULT '0',
  `inte` int unsigned NOT NULL DEFAULT '0',
  `spi` int unsigned NOT NULL DEFAULT '0',
  `min_dmg` int unsigned NOT NULL DEFAULT '0',
  `max_dmg` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`creature_entry`,`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci PACK_KEYS=0 COMMENT='Stores pet levels stats.'
```

---

## pet_name_generation

- 存储引擎: InnoDB
- 行数: 312

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI |  |  |
| `word` | `tinytext` | NO |  |  |  |
| `entry` | `int unsigned` | NO |  | 0 |  |
| `half` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pet_name_generation` (
  `id` int unsigned NOT NULL,
  `word` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entry` int unsigned NOT NULL DEFAULT '0',
  `half` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pet_name_generation_locale

- 存储引擎: InnoDB
- 行数: 106

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI |  |  |
| `Locale` | `varchar(4)` | NO | PRI |  |  |
| `Word` | `tinytext` | NO |  |  |  |
| `Entry` | `int unsigned` | NO |  | 0 |  |
| `Half` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `Locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pet_name_generation_locale` (
  `ID` int unsigned NOT NULL,
  `Locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Word` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Half` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`,`Locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pickpocketing_loot_template

- 存储引擎: InnoDB
- 行数: 13649
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pickpocketing_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## player_class_stats

- 存储引擎: InnoDB
- 行数: 746
- 注释: Stores levels stats.

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Class` | `tinyint unsigned` | NO | PRI |  |  |
| `Level` | `tinyint unsigned` | NO | PRI |  |  |
| `BaseHP` | `int unsigned` | NO |  | 1 |  |
| `BaseMana` | `int unsigned` | NO |  | 1 |  |
| `Strength` | `int unsigned` | NO |  | 0 |  |
| `Agility` | `int unsigned` | NO |  | 0 |  |
| `Stamina` | `int unsigned` | NO |  | 0 |  |
| `Intellect` | `int unsigned` | NO |  | 0 |  |
| `Spirit` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Class` | 是 | BTREE |
| PRIMARY | `Level` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_class_stats` (
  `Class` tinyint unsigned NOT NULL,
  `Level` tinyint unsigned NOT NULL,
  `BaseHP` int unsigned NOT NULL DEFAULT '1',
  `BaseMana` int unsigned NOT NULL DEFAULT '1',
  `Strength` int unsigned NOT NULL DEFAULT '0',
  `Agility` int unsigned NOT NULL DEFAULT '0',
  `Stamina` int unsigned NOT NULL DEFAULT '0',
  `Intellect` int unsigned NOT NULL DEFAULT '0',
  `Spirit` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`Class`,`Level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci PACK_KEYS=0 COMMENT='Stores levels stats.'
```

---

## player_factionchange_achievement

- 存储引擎: InnoDB
- 行数: 124

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `alliance_id` | `int unsigned` | NO | PRI |  |  |
| `alliance_comment` | `text` | YES |  |  |  |
| `horde_id` | `int unsigned` | NO | PRI |  |  |
| `horde_comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `alliance_id` | 是 | BTREE |
| PRIMARY | `horde_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_factionchange_achievement` (
  `alliance_id` int unsigned NOT NULL,
  `alliance_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `horde_id` int unsigned NOT NULL,
  `horde_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## player_factionchange_items

- 存储引擎: InnoDB
- 行数: 1395

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `alliance_id` | `int unsigned` | NO | PRI |  |  |
| `alliance_comment` | `text` | NO |  |  |  |
| `horde_id` | `int unsigned` | NO | PRI |  |  |
| `horde_comment` | `text` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `alliance_id` | 是 | BTREE |
| PRIMARY | `horde_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_factionchange_items` (
  `alliance_id` int unsigned NOT NULL,
  `alliance_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horde_id` int unsigned NOT NULL,
  `horde_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## player_factionchange_quests

- 存储引擎: InnoDB
- 行数: 293

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `alliance_id` | `int unsigned` | NO | PRI |  |  |
| `horde_id` | `int unsigned` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `alliance_id` | 是 | BTREE |
| PRIMARY | `horde_id` | 是 | BTREE |
| alliance_uniq | `alliance_id` | 是 | BTREE |
| horde_uniq | `horde_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_factionchange_quests` (
  `alliance_id` int unsigned NOT NULL,
  `horde_id` int unsigned NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`),
  UNIQUE KEY `alliance_uniq` (`alliance_id`),
  UNIQUE KEY `horde_uniq` (`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## player_factionchange_reputations

- 存储引擎: InnoDB
- 行数: 15

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `alliance_id` | `int unsigned` | NO | PRI |  |  |
| `alliance_comment` | `text` | YES |  |  |  |
| `horde_id` | `int unsigned` | NO | PRI |  |  |
| `horde_comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `alliance_id` | 是 | BTREE |
| PRIMARY | `horde_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_factionchange_reputations` (
  `alliance_id` int unsigned NOT NULL,
  `alliance_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `horde_id` int unsigned NOT NULL,
  `horde_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## player_factionchange_spells

- 存储引擎: InnoDB
- 行数: 113

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `alliance_id` | `int unsigned` | NO | PRI |  |  |
| `alliance_comment` | `text` | NO |  |  |  |
| `horde_id` | `int unsigned` | NO | PRI |  |  |
| `horde_comment` | `text` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `alliance_id` | 是 | BTREE |
| PRIMARY | `horde_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_factionchange_spells` (
  `alliance_id` int unsigned NOT NULL,
  `alliance_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horde_id` int unsigned NOT NULL,
  `horde_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## player_factionchange_titles

- 存储引擎: InnoDB
- 行数: 22

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `alliance_id` | `int` | NO | PRI |  |  |
| `alliance_comment` | `text` | YES |  |  |  |
| `horde_id` | `int` | NO | PRI |  |  |
| `horde_comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `alliance_id` | 是 | BTREE |
| PRIMARY | `horde_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_factionchange_titles` (
  `alliance_id` int NOT NULL,
  `alliance_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `horde_id` int NOT NULL,
  `horde_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## player_loot_template

- 存储引擎: InnoDB
- 行数: 20
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## player_race_stats

- 存储引擎: InnoDB
- 行数: 10
- 注释: Stores race stats.

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Race` | `tinyint unsigned` | NO | PRI |  |  |
| `Strength` | `int` | NO |  | 0 |  |
| `Agility` | `int` | NO |  | 0 |  |
| `Stamina` | `int` | NO |  | 0 |  |
| `Intellect` | `int` | NO |  | 0 |  |
| `Spirit` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Race` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_race_stats` (
  `Race` tinyint unsigned NOT NULL,
  `Strength` int NOT NULL DEFAULT '0',
  `Agility` int NOT NULL DEFAULT '0',
  `Stamina` int NOT NULL DEFAULT '0',
  `Intellect` int NOT NULL DEFAULT '0',
  `Spirit` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Race`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci PACK_KEYS=0 COMMENT='Stores race stats.'
```

---

## player_shapeshift_model

- 存储引擎: InnoDB
- 行数: 107

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ShapeshiftID` | `tinyint unsigned` | NO | PRI |  |  |
| `RaceID` | `tinyint unsigned` | NO | PRI |  |  |
| `CustomizationID` | `tinyint unsigned` | NO | PRI |  |  |
| `GenderID` | `tinyint unsigned` | NO | PRI |  |  |
| `ModelID` | `int unsigned` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ShapeshiftID` | 是 | BTREE |
| PRIMARY | `RaceID` | 是 | BTREE |
| PRIMARY | `CustomizationID` | 是 | BTREE |
| PRIMARY | `GenderID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_shapeshift_model` (
  `ShapeshiftID` tinyint unsigned NOT NULL,
  `RaceID` tinyint unsigned NOT NULL,
  `CustomizationID` tinyint unsigned NOT NULL,
  `GenderID` tinyint unsigned NOT NULL,
  `ModelID` int unsigned NOT NULL,
  PRIMARY KEY (`ShapeshiftID`,`RaceID`,`CustomizationID`,`GenderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci PACK_KEYS=0
```

---

## player_totem_model

- 存储引擎: InnoDB
- 行数: 20

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `TotemID` | `tinyint unsigned` | NO | PRI |  |  |
| `RaceID` | `tinyint unsigned` | NO | PRI |  |  |
| `ModelID` | `int unsigned` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `TotemID` | 是 | BTREE |
| PRIMARY | `RaceID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_totem_model` (
  `TotemID` tinyint unsigned NOT NULL,
  `RaceID` tinyint unsigned NOT NULL,
  `ModelID` int unsigned NOT NULL,
  PRIMARY KEY (`TotemID`,`RaceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci PACK_KEYS=0
```

---

## player_xp_for_level

- 存储引擎: InnoDB
- 行数: 79

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Level` | `tinyint unsigned` | NO | PRI |  |  |
| `Experience` | `int unsigned` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Level` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `player_xp_for_level` (
  `Level` tinyint unsigned NOT NULL,
  `Experience` int unsigned NOT NULL,
  PRIMARY KEY (`Level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## playercreateinfo

- 存储引擎: InnoDB
- 行数: 62

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `race` | `tinyint unsigned` | NO | PRI | 0 |  |
| `class` | `tinyint unsigned` | NO | PRI | 0 |  |
| `map` | `smallint unsigned` | NO |  | 0 |  |
| `zone` | `int unsigned` | NO |  | 0 |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `race` | 是 | BTREE |
| PRIMARY | `class` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `playercreateinfo` (
  `race` tinyint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `map` smallint unsigned NOT NULL DEFAULT '0',
  `zone` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## playercreateinfo_action

- 存储引擎: InnoDB
- 行数: 283

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `race` | `tinyint unsigned` | NO | PRI | 0 |  |
| `class` | `tinyint unsigned` | NO | PRI | 0 |  |
| `button` | `smallint unsigned` | NO | PRI | 0 |  |
| `action` | `int unsigned` | NO |  | 0 |  |
| `type` | `smallint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `race` | 是 | BTREE |
| PRIMARY | `class` | 是 | BTREE |
| PRIMARY | `button` | 是 | BTREE |
| playercreateinfo_race_class_index | `race` | 否 | BTREE |
| playercreateinfo_race_class_index | `class` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `playercreateinfo_action` (
  `race` tinyint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `button` smallint unsigned NOT NULL DEFAULT '0',
  `action` int unsigned NOT NULL DEFAULT '0',
  `type` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`,`button`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## playercreateinfo_cast_spell

- 存储引擎: InnoDB
- 行数: 2

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `raceMask` | `int unsigned` | NO |  | 0 |  |
| `classMask` | `int unsigned` | NO |  | 0 |  |
| `spell` | `int unsigned` | NO |  | 0 |  |
| `note` | `varchar(255)` | YES |  |  |  |

### CREATE TABLE

```sql
CREATE TABLE `playercreateinfo_cast_spell` (
  `raceMask` int unsigned NOT NULL DEFAULT '0',
  `classMask` int unsigned NOT NULL DEFAULT '0',
  `spell` int unsigned NOT NULL DEFAULT '0',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## playercreateinfo_item

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `race` | `tinyint unsigned` | NO | PRI | 0 |  |
| `class` | `tinyint unsigned` | NO | PRI | 0 |  |
| `itemid` | `int unsigned` | NO | PRI | 0 |  |
| `amount` | `int` | NO |  | 1 |  |
| `Note` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `race` | 是 | BTREE |
| PRIMARY | `class` | 是 | BTREE |
| PRIMARY | `itemid` | 是 | BTREE |
| playercreateinfo_race_class_index | `race` | 否 | BTREE |
| playercreateinfo_race_class_index | `class` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `playercreateinfo_item` (
  `race` tinyint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `itemid` int unsigned NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '1',
  `Note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`race`,`class`,`itemid`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## playercreateinfo_skills

- 存储引擎: InnoDB
- 行数: 77

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `raceMask` | `int unsigned` | NO | PRI |  |  |
| `classMask` | `int unsigned` | NO | PRI |  |  |
| `skill` | `smallint unsigned` | NO | PRI |  |  |
| `rank` | `smallint unsigned` | NO |  | 0 |  |
| `comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `raceMask` | 是 | BTREE |
| PRIMARY | `classMask` | 是 | BTREE |
| PRIMARY | `skill` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `playercreateinfo_skills` (
  `raceMask` int unsigned NOT NULL,
  `classMask` int unsigned NOT NULL,
  `skill` smallint unsigned NOT NULL,
  `rank` smallint unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`raceMask`,`classMask`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## playercreateinfo_spell_custom

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `racemask` | `int unsigned` | NO | PRI | 0 |  |
| `classmask` | `int unsigned` | NO | PRI | 0 |  |
| `Spell` | `int unsigned` | NO | PRI | 0 |  |
| `Note` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `racemask` | 是 | BTREE |
| PRIMARY | `classmask` | 是 | BTREE |
| PRIMARY | `Spell` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `playercreateinfo_spell_custom` (
  `racemask` int unsigned NOT NULL DEFAULT '0',
  `classmask` int unsigned NOT NULL DEFAULT '0',
  `Spell` int unsigned NOT NULL DEFAULT '0',
  `Note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`racemask`,`classmask`,`Spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## points_of_interest

- 存储引擎: InnoDB
- 行数: 463

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `PositionX` | `float` | NO |  | 0 |  |
| `PositionY` | `float` | NO |  | 0 |  |
| `Icon` | `int unsigned` | NO |  | 0 |  |
| `Flags` | `int unsigned` | NO |  | 0 |  |
| `Importance` | `int unsigned` | NO |  | 0 |  |
| `Name` | `text` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `points_of_interest` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `PositionX` float NOT NULL DEFAULT '0',
  `PositionY` float NOT NULL DEFAULT '0',
  `Icon` int unsigned NOT NULL DEFAULT '0',
  `Flags` int unsigned NOT NULL DEFAULT '0',
  `Importance` int unsigned NOT NULL DEFAULT '0',
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## points_of_interest_locale

- 存储引擎: InnoDB
- 行数: 2524

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Name` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `points_of_interest_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pool_creature

- 存储引擎: InnoDB
- 行数: 1668

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `pool_entry` | `int unsigned` | NO |  | 0 |  |
| `chance` | `float` | NO |  | 0 |  |
| `description` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| idx_guid | `guid` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pool_creature` (
  `guid` int unsigned NOT NULL DEFAULT '0',
  `pool_entry` int unsigned NOT NULL DEFAULT '0',
  `chance` float NOT NULL DEFAULT '0',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_guid` (`guid`),
  CONSTRAINT `pool_creature_chk_1` CHECK ((`chance` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pool_gameobject

- 存储引擎: InnoDB
- 行数: 33789

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `pool_entry` | `int unsigned` | NO |  | 0 |  |
| `chance` | `float` | NO |  | 0 |  |
| `description` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| idx_guid | `guid` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pool_gameobject` (
  `guid` int unsigned NOT NULL DEFAULT '0',
  `pool_entry` int unsigned NOT NULL DEFAULT '0',
  `chance` float NOT NULL DEFAULT '0',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `idx_guid` (`guid`),
  CONSTRAINT `pool_gameobject_chk_1` CHECK ((`chance` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pool_pool

- 存储引擎: InnoDB
- 行数: 6367

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `pool_id` | `int unsigned` | NO | PRI | 0 |  |
| `mother_pool` | `int unsigned` | NO |  | 0 |  |
| `chance` | `float` | NO |  | 0 |  |
| `description` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `pool_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pool_pool` (
  `pool_id` int unsigned NOT NULL DEFAULT '0',
  `mother_pool` int unsigned NOT NULL DEFAULT '0',
  `chance` float NOT NULL DEFAULT '0',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pool_quest

- 存储引擎: InnoDB
- 行数: 161

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `pool_entry` | `int unsigned` | NO |  | 0 |  |
| `description` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| idx_guid | `entry` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pool_quest` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `pool_entry` int unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`entry`),
  KEY `idx_guid` (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## pool_template

- 存储引擎: InnoDB
- 行数: 9294

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `max_limit` | `int unsigned` | NO |  | 0 |  |
| `description` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pool_template` (
  `entry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Pool entry',
  `max_limit` int unsigned NOT NULL DEFAULT '0' COMMENT 'Max number of objects (0) is no limit',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## powerdisplay_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ActualType` | `int` | NO |  | 0 |  |
| `GlobalstringBaseTag` | `varchar(100)` | YES |  |  |  |
| `Red` | `tinyint unsigned` | NO |  | 0 |  |
| `Green` | `tinyint unsigned` | NO |  | 0 |  |
| `Blue` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `powerdisplay_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ActualType` int NOT NULL DEFAULT '0',
  `GlobalstringBaseTag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Red` tinyint unsigned NOT NULL DEFAULT '0',
  `Green` tinyint unsigned NOT NULL DEFAULT '0',
  `Blue` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## prospecting_loot_template

- 存储引擎: InnoDB
- 行数: 48
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `prospecting_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## pvpdifficulty_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `MapID` | `int` | NO |  | 0 |  |
| `RangeIndex` | `int` | NO |  | 0 |  |
| `MinLevel` | `int` | NO |  | 0 |  |
| `MaxLevel` | `int` | NO |  | 0 |  |
| `Difficulty` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `pvpdifficulty_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `MapID` int NOT NULL DEFAULT '0',
  `RangeIndex` int NOT NULL DEFAULT '0',
  `MinLevel` int NOT NULL DEFAULT '0',
  `MaxLevel` int NOT NULL DEFAULT '0',
  `Difficulty` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_details

- 存储引擎: InnoDB
- 行数: 2951

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `Emote1` | `smallint unsigned` | NO |  | 0 |  |
| `Emote2` | `smallint unsigned` | NO |  | 0 |  |
| `Emote3` | `smallint unsigned` | NO |  | 0 |  |
| `Emote4` | `smallint unsigned` | NO |  | 0 |  |
| `EmoteDelay1` | `int unsigned` | NO |  | 0 |  |
| `EmoteDelay2` | `int unsigned` | NO |  | 0 |  |
| `EmoteDelay3` | `int unsigned` | NO |  | 0 |  |
| `EmoteDelay4` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_details` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `Emote1` smallint unsigned NOT NULL DEFAULT '0',
  `Emote2` smallint unsigned NOT NULL DEFAULT '0',
  `Emote3` smallint unsigned NOT NULL DEFAULT '0',
  `Emote4` smallint unsigned NOT NULL DEFAULT '0',
  `EmoteDelay1` int unsigned NOT NULL DEFAULT '0',
  `EmoteDelay2` int unsigned NOT NULL DEFAULT '0',
  `EmoteDelay3` int unsigned NOT NULL DEFAULT '0',
  `EmoteDelay4` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_greeting

- 存储引擎: InnoDB
- 行数: 206

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `type` | `tinyint unsigned` | NO | PRI | 0 |  |
| `GreetEmoteType` | `smallint unsigned` | NO |  | 0 |  |
| `GreetEmoteDelay` | `int unsigned` | NO |  | 0 |  |
| `Greeting` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `type` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_greeting` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `GreetEmoteType` smallint unsigned NOT NULL DEFAULT '0',
  `GreetEmoteDelay` int unsigned NOT NULL DEFAULT '0',
  `Greeting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_greeting_locale

- 存储引擎: InnoDB
- 行数: 75

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `type` | `tinyint unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Greeting` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `type` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_greeting_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Greeting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`type`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_mail_sender

- 存储引擎: InnoDB
- 行数: 10

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `QuestId` | `int unsigned` | NO | PRI | 0 |  |
| `RewardMailSenderEntry` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `QuestId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_mail_sender` (
  `QuestId` int unsigned NOT NULL DEFAULT '0',
  `RewardMailSenderEntry` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`QuestId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_money_reward

- 存储引擎: InnoDB
- 行数: 80

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Level` | `int` | NO | PRI | 0 |  |
| `Money0` | `int` | NO |  | 0 |  |
| `Money1` | `int` | NO |  | 0 |  |
| `Money2` | `int` | NO |  | 0 |  |
| `Money3` | `int` | NO |  | 0 |  |
| `Money4` | `int` | NO |  | 0 |  |
| `Money5` | `int` | NO |  | 0 |  |
| `Money6` | `int` | NO |  | 0 |  |
| `Money7` | `int` | NO |  | 0 |  |
| `Money8` | `int` | NO |  | 0 |  |
| `Money9` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Level` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_money_reward` (
  `Level` int NOT NULL DEFAULT '0',
  `Money0` int NOT NULL DEFAULT '0',
  `Money1` int NOT NULL DEFAULT '0',
  `Money2` int NOT NULL DEFAULT '0',
  `Money3` int NOT NULL DEFAULT '0',
  `Money4` int NOT NULL DEFAULT '0',
  `Money5` int NOT NULL DEFAULT '0',
  `Money6` int NOT NULL DEFAULT '0',
  `Money7` int NOT NULL DEFAULT '0',
  `Money8` int NOT NULL DEFAULT '0',
  `Money9` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_offer_reward

- 存储引擎: InnoDB
- 行数: 7909

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `Emote1` | `smallint unsigned` | NO |  | 0 |  |
| `Emote2` | `smallint unsigned` | NO |  | 0 |  |
| `Emote3` | `smallint unsigned` | NO |  | 0 |  |
| `Emote4` | `smallint unsigned` | NO |  | 0 |  |
| `EmoteDelay1` | `int unsigned` | NO |  | 0 |  |
| `EmoteDelay2` | `int unsigned` | NO |  | 0 |  |
| `EmoteDelay3` | `int unsigned` | NO |  | 0 |  |
| `EmoteDelay4` | `int unsigned` | NO |  | 0 |  |
| `RewardText` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_offer_reward` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `Emote1` smallint unsigned NOT NULL DEFAULT '0',
  `Emote2` smallint unsigned NOT NULL DEFAULT '0',
  `Emote3` smallint unsigned NOT NULL DEFAULT '0',
  `Emote4` smallint unsigned NOT NULL DEFAULT '0',
  `EmoteDelay1` int unsigned NOT NULL DEFAULT '0',
  `EmoteDelay2` int unsigned NOT NULL DEFAULT '0',
  `EmoteDelay3` int unsigned NOT NULL DEFAULT '0',
  `EmoteDelay4` int unsigned NOT NULL DEFAULT '0',
  `RewardText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_offer_reward_locale

- 存储引擎: InnoDB
- 行数: 48757

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `RewardText` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_offer_reward_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `RewardText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_poi

- 存储引擎: InnoDB
- 行数: 19110

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `QuestID` | `int unsigned` | NO | PRI | 0 |  |
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `ObjectiveIndex` | `int` | NO |  | 0 |  |
| `MapID` | `int unsigned` | NO |  | 0 |  |
| `WorldMapAreaId` | `int unsigned` | NO |  | 0 |  |
| `Floor` | `int unsigned` | NO |  | 0 |  |
| `Priority` | `int unsigned` | NO |  | 0 |  |
| `Flags` | `int unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `QuestID` | 是 | BTREE |
| PRIMARY | `id` | 是 | BTREE |
| idx | `QuestID` | 否 | BTREE |
| idx | `id` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_poi` (
  `QuestID` int unsigned NOT NULL DEFAULT '0',
  `id` int unsigned NOT NULL DEFAULT '0',
  `ObjectiveIndex` int NOT NULL DEFAULT '0',
  `MapID` int unsigned NOT NULL DEFAULT '0',
  `WorldMapAreaId` int unsigned NOT NULL DEFAULT '0',
  `Floor` int unsigned NOT NULL DEFAULT '0',
  `Priority` int unsigned NOT NULL DEFAULT '0',
  `Flags` int unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`QuestID`,`id`),
  KEY `idx` (`QuestID`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_poi_points

- 存储引擎: InnoDB
- 行数: 57232

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `QuestID` | `int unsigned` | NO | PRI | 0 |  |
| `Idx1` | `int unsigned` | NO | PRI | 0 |  |
| `Idx2` | `int unsigned` | NO | PRI | 0 |  |
| `X` | `int` | NO |  | 0 |  |
| `Y` | `int` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `QuestID` | 是 | BTREE |
| PRIMARY | `Idx1` | 是 | BTREE |
| PRIMARY | `Idx2` | 是 | BTREE |
| questId_id | `QuestID` | 否 | BTREE |
| questId_id | `Idx1` | 否 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_poi_points` (
  `QuestID` int unsigned NOT NULL DEFAULT '0',
  `Idx1` int unsigned NOT NULL DEFAULT '0',
  `Idx2` int unsigned NOT NULL DEFAULT '0',
  `X` int NOT NULL DEFAULT '0',
  `Y` int NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`QuestID`,`Idx1`,`Idx2`),
  KEY `questId_id` (`QuestID`,`Idx1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_request_items

- 存储引擎: InnoDB
- 行数: 7644

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `EmoteOnComplete` | `smallint unsigned` | NO |  | 0 |  |
| `EmoteOnIncomplete` | `smallint unsigned` | NO |  | 0 |  |
| `CompletionText` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_request_items` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `EmoteOnComplete` smallint unsigned NOT NULL DEFAULT '0',
  `EmoteOnIncomplete` smallint unsigned NOT NULL DEFAULT '0',
  `CompletionText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_request_items_locale

- 存储引擎: InnoDB
- 行数: 27675

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `CompletionText` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_request_items_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `CompletionText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_template

- 存储引擎: InnoDB
- 行数: 9065
- 注释: Quest System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `QuestType` | `tinyint unsigned` | NO |  | 2 |  |
| `QuestLevel` | `smallint` | NO |  | 1 |  |
| `MinLevel` | `tinyint unsigned` | NO |  | 0 |  |
| `QuestSortID` | `smallint` | NO |  | 0 |  |
| `QuestInfoID` | `smallint unsigned` | NO |  | 0 |  |
| `SuggestedGroupNum` | `tinyint unsigned` | NO |  | 0 |  |
| `RequiredFactionId1` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredFactionId2` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredFactionValue1` | `int` | NO |  | 0 |  |
| `RequiredFactionValue2` | `int` | NO |  | 0 |  |
| `RewardNextQuest` | `int unsigned` | NO |  | 0 |  |
| `RewardXPDifficulty` | `tinyint unsigned` | NO |  | 0 |  |
| `RewardMoney` | `int` | NO |  | 0 |  |
| `RewardMoneyDifficulty` | `int unsigned` | NO |  | 0 |  |
| `RewardDisplaySpell` | `int unsigned` | NO |  | 0 |  |
| `RewardSpell` | `int` | NO |  | 0 |  |
| `RewardHonor` | `int` | NO |  | 0 |  |
| `RewardKillHonor` | `float` | NO |  | 0 |  |
| `StartItem` | `int unsigned` | NO |  | 0 |  |
| `Flags` | `int unsigned` | NO |  | 0 |  |
| `RequiredPlayerKills` | `tinyint unsigned` | NO |  | 0 |  |
| `RewardItem1` | `int unsigned` | NO |  | 0 |  |
| `RewardAmount1` | `smallint unsigned` | NO |  | 0 |  |
| `RewardItem2` | `int unsigned` | NO |  | 0 |  |
| `RewardAmount2` | `smallint unsigned` | NO |  | 0 |  |
| `RewardItem3` | `int unsigned` | NO |  | 0 |  |
| `RewardAmount3` | `smallint unsigned` | NO |  | 0 |  |
| `RewardItem4` | `int unsigned` | NO |  | 0 |  |
| `RewardAmount4` | `smallint unsigned` | NO |  | 0 |  |
| `ItemDrop1` | `int unsigned` | NO |  | 0 |  |
| `ItemDropQuantity1` | `smallint unsigned` | NO |  | 0 |  |
| `ItemDrop2` | `int unsigned` | NO |  | 0 |  |
| `ItemDropQuantity2` | `smallint unsigned` | NO |  | 0 |  |
| `ItemDrop3` | `int unsigned` | NO |  | 0 |  |
| `ItemDropQuantity3` | `smallint unsigned` | NO |  | 0 |  |
| `ItemDrop4` | `int unsigned` | NO |  | 0 |  |
| `ItemDropQuantity4` | `smallint unsigned` | NO |  | 0 |  |
| `RewardChoiceItemID1` | `int unsigned` | NO |  | 0 |  |
| `RewardChoiceItemQuantity1` | `smallint unsigned` | NO |  | 0 |  |
| `RewardChoiceItemID2` | `int unsigned` | NO |  | 0 |  |
| `RewardChoiceItemQuantity2` | `smallint unsigned` | NO |  | 0 |  |
| `RewardChoiceItemID3` | `int unsigned` | NO |  | 0 |  |
| `RewardChoiceItemQuantity3` | `smallint unsigned` | NO |  | 0 |  |
| `RewardChoiceItemID4` | `int unsigned` | NO |  | 0 |  |
| `RewardChoiceItemQuantity4` | `smallint unsigned` | NO |  | 0 |  |
| `RewardChoiceItemID5` | `int unsigned` | NO |  | 0 |  |
| `RewardChoiceItemQuantity5` | `smallint unsigned` | NO |  | 0 |  |
| `RewardChoiceItemID6` | `int unsigned` | NO |  | 0 |  |
| `RewardChoiceItemQuantity6` | `smallint unsigned` | NO |  | 0 |  |
| `POIContinent` | `smallint unsigned` | NO |  | 0 |  |
| `POIx` | `float` | NO |  | 0 |  |
| `POIy` | `float` | NO |  | 0 |  |
| `POIPriority` | `int unsigned` | NO |  | 0 |  |
| `RewardTitle` | `tinyint unsigned` | NO |  | 0 |  |
| `RewardTalents` | `tinyint unsigned` | NO |  | 0 |  |
| `RewardArenaPoints` | `smallint unsigned` | NO |  | 0 |  |
| `RewardFactionID1` | `smallint unsigned` | NO |  | 0 |  |
| `RewardFactionValue1` | `int` | NO |  | 0 |  |
| `RewardFactionOverride1` | `int` | NO |  | 0 |  |
| `RewardFactionID2` | `smallint unsigned` | NO |  | 0 |  |
| `RewardFactionValue2` | `int` | NO |  | 0 |  |
| `RewardFactionOverride2` | `int` | NO |  | 0 |  |
| `RewardFactionID3` | `smallint unsigned` | NO |  | 0 |  |
| `RewardFactionValue3` | `int` | NO |  | 0 |  |
| `RewardFactionOverride3` | `int` | NO |  | 0 |  |
| `RewardFactionID4` | `smallint unsigned` | NO |  | 0 |  |
| `RewardFactionValue4` | `int` | NO |  | 0 |  |
| `RewardFactionOverride4` | `int` | NO |  | 0 |  |
| `RewardFactionID5` | `smallint unsigned` | NO |  | 0 |  |
| `RewardFactionValue5` | `int` | NO |  | 0 |  |
| `RewardFactionOverride5` | `int` | NO |  | 0 |  |
| `TimeAllowed` | `int unsigned` | NO |  | 0 |  |
| `AllowableRaces` | `int unsigned` | NO |  | 0 |  |
| `LogTitle` | `text` | YES |  |  |  |
| `LogDescription` | `text` | YES |  |  |  |
| `QuestDescription` | `text` | YES |  |  |  |
| `AreaDescription` | `text` | YES |  |  |  |
| `QuestCompletionLog` | `text` | YES |  |  |  |
| `RequiredNpcOrGo1` | `int` | NO |  | 0 |  |
| `RequiredNpcOrGo2` | `int` | NO |  | 0 |  |
| `RequiredNpcOrGo3` | `int` | NO |  | 0 |  |
| `RequiredNpcOrGo4` | `int` | NO |  | 0 |  |
| `RequiredNpcOrGoCount1` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredNpcOrGoCount2` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredNpcOrGoCount3` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredNpcOrGoCount4` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredItemId1` | `int unsigned` | NO |  | 0 |  |
| `RequiredItemId2` | `int unsigned` | NO |  | 0 |  |
| `RequiredItemId3` | `int unsigned` | NO |  | 0 |  |
| `RequiredItemId4` | `int unsigned` | NO |  | 0 |  |
| `RequiredItemId5` | `int unsigned` | NO |  | 0 |  |
| `RequiredItemId6` | `int unsigned` | NO |  | 0 |  |
| `RequiredItemCount1` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredItemCount2` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredItemCount3` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredItemCount4` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredItemCount5` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredItemCount6` | `smallint unsigned` | NO |  | 0 |  |
| `Unknown0` | `tinyint unsigned` | NO |  | 0 |  |
| `ObjectiveText1` | `text` | YES |  |  |  |
| `ObjectiveText2` | `text` | YES |  |  |  |
| `ObjectiveText3` | `text` | YES |  |  |  |
| `ObjectiveText4` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_template` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `QuestType` tinyint unsigned NOT NULL DEFAULT '2',
  `QuestLevel` smallint NOT NULL DEFAULT '1',
  `MinLevel` tinyint unsigned NOT NULL DEFAULT '0',
  `QuestSortID` smallint NOT NULL DEFAULT '0',
  `QuestInfoID` smallint unsigned NOT NULL DEFAULT '0',
  `SuggestedGroupNum` tinyint unsigned NOT NULL DEFAULT '0',
  `RequiredFactionId1` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredFactionId2` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredFactionValue1` int NOT NULL DEFAULT '0',
  `RequiredFactionValue2` int NOT NULL DEFAULT '0',
  `RewardNextQuest` int unsigned NOT NULL DEFAULT '0',
  `RewardXPDifficulty` tinyint unsigned NOT NULL DEFAULT '0',
  `RewardMoney` int NOT NULL DEFAULT '0',
  `RewardMoneyDifficulty` int unsigned NOT NULL DEFAULT '0',
  `RewardDisplaySpell` int unsigned NOT NULL DEFAULT '0',
  `RewardSpell` int NOT NULL DEFAULT '0',
  `RewardHonor` int NOT NULL DEFAULT '0',
  `RewardKillHonor` float NOT NULL DEFAULT '0',
  `StartItem` int unsigned NOT NULL DEFAULT '0',
  `Flags` int unsigned NOT NULL DEFAULT '0',
  `RequiredPlayerKills` tinyint unsigned NOT NULL DEFAULT '0',
  `RewardItem1` int unsigned NOT NULL DEFAULT '0',
  `RewardAmount1` smallint unsigned NOT NULL DEFAULT '0',
  `RewardItem2` int unsigned NOT NULL DEFAULT '0',
  `RewardAmount2` smallint unsigned NOT NULL DEFAULT '0',
  `RewardItem3` int unsigned NOT NULL DEFAULT '0',
  `RewardAmount3` smallint unsigned NOT NULL DEFAULT '0',
  `RewardItem4` int unsigned NOT NULL DEFAULT '0',
  `RewardAmount4` smallint unsigned NOT NULL DEFAULT '0',
  `ItemDrop1` int unsigned NOT NULL DEFAULT '0',
  `ItemDropQuantity1` smallint unsigned NOT NULL DEFAULT '0',
  `ItemDrop2` int unsigned NOT NULL DEFAULT '0',
  `ItemDropQuantity2` smallint unsigned NOT NULL DEFAULT '0',
  `ItemDrop3` int unsigned NOT NULL DEFAULT '0',
  `ItemDropQuantity3` smallint unsigned NOT NULL DEFAULT '0',
  `ItemDrop4` int unsigned NOT NULL DEFAULT '0',
  `ItemDropQuantity4` smallint unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemID1` int unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemQuantity1` smallint unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemID2` int unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemQuantity2` smallint unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemID3` int unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemQuantity3` smallint unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemID4` int unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemQuantity4` smallint unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemID5` int unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemQuantity5` smallint unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemID6` int unsigned NOT NULL DEFAULT '0',
  `RewardChoiceItemQuantity6` smallint unsigned NOT NULL DEFAULT '0',
  `POIContinent` smallint unsigned NOT NULL DEFAULT '0',
  `POIx` float NOT NULL DEFAULT '0',
  `POIy` float NOT NULL DEFAULT '0',
  `POIPriority` int unsigned NOT NULL DEFAULT '0',
  `RewardTitle` tinyint unsigned NOT NULL DEFAULT '0',
  `RewardTalents` tinyint unsigned NOT NULL DEFAULT '0',
  `RewardArenaPoints` smallint unsigned NOT NULL DEFAULT '0',
  `RewardFactionID1` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewardFactionValue1` int NOT NULL DEFAULT '0',
  `RewardFactionOverride1` int NOT NULL DEFAULT '0',
  `RewardFactionID2` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewardFactionValue2` int NOT NULL DEFAULT '0',
  `RewardFactionOverride2` int NOT NULL DEFAULT '0',
  `RewardFactionID3` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewardFactionValue3` int NOT NULL DEFAULT '0',
  `RewardFactionOverride3` int NOT NULL DEFAULT '0',
  `RewardFactionID4` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewardFactionValue4` int NOT NULL DEFAULT '0',
  `RewardFactionOverride4` int NOT NULL DEFAULT '0',
  `RewardFactionID5` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'faction id from Faction.dbc in this case',
  `RewardFactionValue5` int NOT NULL DEFAULT '0',
  `RewardFactionOverride5` int NOT NULL DEFAULT '0',
  `TimeAllowed` int unsigned NOT NULL DEFAULT '0',
  `AllowableRaces` int unsigned NOT NULL DEFAULT '0',
  `LogTitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `LogDescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `QuestDescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `AreaDescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `QuestCompletionLog` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `RequiredNpcOrGo1` int NOT NULL DEFAULT '0',
  `RequiredNpcOrGo2` int NOT NULL DEFAULT '0',
  `RequiredNpcOrGo3` int NOT NULL DEFAULT '0',
  `RequiredNpcOrGo4` int NOT NULL DEFAULT '0',
  `RequiredNpcOrGoCount1` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredNpcOrGoCount2` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredNpcOrGoCount3` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredNpcOrGoCount4` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredItemId1` int unsigned NOT NULL DEFAULT '0',
  `RequiredItemId2` int unsigned NOT NULL DEFAULT '0',
  `RequiredItemId3` int unsigned NOT NULL DEFAULT '0',
  `RequiredItemId4` int unsigned NOT NULL DEFAULT '0',
  `RequiredItemId5` int unsigned NOT NULL DEFAULT '0',
  `RequiredItemId6` int unsigned NOT NULL DEFAULT '0',
  `RequiredItemCount1` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredItemCount2` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredItemCount3` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredItemCount4` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredItemCount5` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredItemCount6` smallint unsigned NOT NULL DEFAULT '0',
  `Unknown0` tinyint unsigned NOT NULL DEFAULT '0',
  `ObjectiveText1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ObjectiveText2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ObjectiveText3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ObjectiveText4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Quest System'
```

---

## quest_template_addon

- 存储引擎: InnoDB
- 行数: 9600

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `MaxLevel` | `tinyint unsigned` | NO |  | 0 |  |
| `AllowableClasses` | `int unsigned` | NO |  | 0 |  |
| `SourceSpellID` | `int unsigned` | NO |  | 0 |  |
| `PrevQuestID` | `int` | NO |  | 0 |  |
| `NextQuestID` | `int unsigned` | NO |  | 0 |  |
| `ExclusiveGroup` | `int` | NO |  | 0 |  |
| `BreadcrumbForQuestId` | `mediumint unsigned` | NO |  | 0 |  |
| `RewardMailTemplateID` | `int unsigned` | NO |  | 0 |  |
| `RewardMailDelay` | `int unsigned` | NO |  | 0 |  |
| `RequiredSkillID` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredSkillPoints` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredMinRepFaction` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredMaxRepFaction` | `smallint unsigned` | NO |  | 0 |  |
| `RequiredMinRepValue` | `int` | NO |  | 0 |  |
| `RequiredMaxRepValue` | `int` | NO |  | 0 |  |
| `ProvidedItemCount` | `tinyint unsigned` | NO |  | 0 |  |
| `SpecialFlags` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_template_addon` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `MaxLevel` tinyint unsigned NOT NULL DEFAULT '0',
  `AllowableClasses` int unsigned NOT NULL DEFAULT '0',
  `SourceSpellID` int unsigned NOT NULL DEFAULT '0',
  `PrevQuestID` int NOT NULL DEFAULT '0',
  `NextQuestID` int unsigned NOT NULL DEFAULT '0',
  `ExclusiveGroup` int NOT NULL DEFAULT '0',
  `BreadcrumbForQuestId` mediumint unsigned NOT NULL DEFAULT '0',
  `RewardMailTemplateID` int unsigned NOT NULL DEFAULT '0',
  `RewardMailDelay` int unsigned NOT NULL DEFAULT '0',
  `RequiredSkillID` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredSkillPoints` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredMinRepFaction` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredMaxRepFaction` smallint unsigned NOT NULL DEFAULT '0',
  `RequiredMinRepValue` int NOT NULL DEFAULT '0',
  `RequiredMaxRepValue` int NOT NULL DEFAULT '0',
  `ProvidedItemCount` tinyint unsigned NOT NULL DEFAULT '0',
  `SpecialFlags` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## quest_template_locale

- 存储引擎: InnoDB
- 行数: 49780

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Title` | `text` | YES |  |  |  |
| `Details` | `text` | YES |  |  |  |
| `Objectives` | `text` | YES |  |  |  |
| `EndText` | `text` | YES |  |  |  |
| `CompletedText` | `text` | YES |  |  |  |
| `ObjectiveText1` | `text` | YES |  |  |  |
| `ObjectiveText2` | `text` | YES |  |  |  |
| `ObjectiveText3` | `text` | YES |  |  |  |
| `ObjectiveText4` | `text` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `quest_template_locale` (
  `ID` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Objectives` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `EndText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `CompletedText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ObjectiveText1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ObjectiveText2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ObjectiveText3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ObjectiveText4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## questfactionreward_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Difficulty_1` | `int` | NO |  | 0 |  |
| `Difficulty_2` | `int` | NO |  | 0 |  |
| `Difficulty_3` | `int` | NO |  | 0 |  |
| `Difficulty_4` | `int` | NO |  | 0 |  |
| `Difficulty_5` | `int` | NO |  | 0 |  |
| `Difficulty_6` | `int` | NO |  | 0 |  |
| `Difficulty_7` | `int` | NO |  | 0 |  |
| `Difficulty_8` | `int` | NO |  | 0 |  |
| `Difficulty_9` | `int` | NO |  | 0 |  |
| `Difficulty_10` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `questfactionreward_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Difficulty_1` int NOT NULL DEFAULT '0',
  `Difficulty_2` int NOT NULL DEFAULT '0',
  `Difficulty_3` int NOT NULL DEFAULT '0',
  `Difficulty_4` int NOT NULL DEFAULT '0',
  `Difficulty_5` int NOT NULL DEFAULT '0',
  `Difficulty_6` int NOT NULL DEFAULT '0',
  `Difficulty_7` int NOT NULL DEFAULT '0',
  `Difficulty_8` int NOT NULL DEFAULT '0',
  `Difficulty_9` int NOT NULL DEFAULT '0',
  `Difficulty_10` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## questsort_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `SortName_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `SortName_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `questsort_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `SortName_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SortName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## questxp_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Difficulty_1` | `int` | NO |  | 0 |  |
| `Difficulty_2` | `int` | NO |  | 0 |  |
| `Difficulty_3` | `int` | NO |  | 0 |  |
| `Difficulty_4` | `int` | NO |  | 0 |  |
| `Difficulty_5` | `int` | NO |  | 0 |  |
| `Difficulty_6` | `int` | NO |  | 0 |  |
| `Difficulty_7` | `int` | NO |  | 0 |  |
| `Difficulty_8` | `int` | NO |  | 0 |  |
| `Difficulty_9` | `int` | NO |  | 0 |  |
| `Difficulty_10` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `questxp_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Difficulty_1` int NOT NULL DEFAULT '0',
  `Difficulty_2` int NOT NULL DEFAULT '0',
  `Difficulty_3` int NOT NULL DEFAULT '0',
  `Difficulty_4` int NOT NULL DEFAULT '0',
  `Difficulty_5` int NOT NULL DEFAULT '0',
  `Difficulty_6` int NOT NULL DEFAULT '0',
  `Difficulty_7` int NOT NULL DEFAULT '0',
  `Difficulty_8` int NOT NULL DEFAULT '0',
  `Difficulty_9` int NOT NULL DEFAULT '0',
  `Difficulty_10` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## randproppoints_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Epic_1` | `int` | NO |  | 0 |  |
| `Epic_2` | `int` | NO |  | 0 |  |
| `Epic_3` | `int` | NO |  | 0 |  |
| `Epic_4` | `int` | NO |  | 0 |  |
| `Epic_5` | `int` | NO |  | 0 |  |
| `Superior_1` | `int` | NO |  | 0 |  |
| `Superior_2` | `int` | NO |  | 0 |  |
| `Superior_3` | `int` | NO |  | 0 |  |
| `Superior_4` | `int` | NO |  | 0 |  |
| `Superior_5` | `int` | NO |  | 0 |  |
| `Good_1` | `int` | NO |  | 0 |  |
| `Good_2` | `int` | NO |  | 0 |  |
| `Good_3` | `int` | NO |  | 0 |  |
| `Good_4` | `int` | NO |  | 0 |  |
| `Good_5` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `randproppoints_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Epic_1` int NOT NULL DEFAULT '0',
  `Epic_2` int NOT NULL DEFAULT '0',
  `Epic_3` int NOT NULL DEFAULT '0',
  `Epic_4` int NOT NULL DEFAULT '0',
  `Epic_5` int NOT NULL DEFAULT '0',
  `Superior_1` int NOT NULL DEFAULT '0',
  `Superior_2` int NOT NULL DEFAULT '0',
  `Superior_3` int NOT NULL DEFAULT '0',
  `Superior_4` int NOT NULL DEFAULT '0',
  `Superior_5` int NOT NULL DEFAULT '0',
  `Good_1` int NOT NULL DEFAULT '0',
  `Good_2` int NOT NULL DEFAULT '0',
  `Good_3` int NOT NULL DEFAULT '0',
  `Good_4` int NOT NULL DEFAULT '0',
  `Good_5` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## reference_loot_template

- 存储引擎: InnoDB
- 行数: 24477
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `reference_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## reputation_reward_rate

- 存储引擎: InnoDB
- 行数: 16

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `faction` | `int unsigned` | NO | PRI | 0 |  |
| `quest_rate` | `float` | NO |  | 1 |  |
| `quest_daily_rate` | `float` | NO |  | 1 |  |
| `quest_weekly_rate` | `float` | NO |  | 1 |  |
| `quest_monthly_rate` | `float` | NO |  | 1 |  |
| `quest_repeatable_rate` | `float` | NO |  | 1 |  |
| `creature_rate` | `float` | NO |  | 1 |  |
| `spell_rate` | `float` | NO |  | 1 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `faction` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `reputation_reward_rate` (
  `faction` int unsigned NOT NULL DEFAULT '0',
  `quest_rate` float NOT NULL DEFAULT '1',
  `quest_daily_rate` float NOT NULL DEFAULT '1',
  `quest_weekly_rate` float NOT NULL DEFAULT '1',
  `quest_monthly_rate` float NOT NULL DEFAULT '1',
  `quest_repeatable_rate` float NOT NULL DEFAULT '1',
  `creature_rate` float NOT NULL DEFAULT '1',
  `spell_rate` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## reputation_spillover_template

- 存储引擎: InnoDB
- 行数: 26
- 注释: Reputation spillover reputation gain

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `faction` | `smallint unsigned` | NO | PRI | 0 |  |
| `faction1` | `smallint unsigned` | NO |  | 0 |  |
| `rate_1` | `float` | NO |  | 0 |  |
| `rank_1` | `tinyint unsigned` | NO |  | 0 |  |
| `faction2` | `smallint unsigned` | NO |  | 0 |  |
| `rate_2` | `float` | NO |  | 0 |  |
| `rank_2` | `tinyint unsigned` | NO |  | 0 |  |
| `faction3` | `smallint unsigned` | NO |  | 0 |  |
| `rate_3` | `float` | NO |  | 0 |  |
| `rank_3` | `tinyint unsigned` | NO |  | 0 |  |
| `faction4` | `smallint unsigned` | NO |  | 0 |  |
| `rate_4` | `float` | NO |  | 0 |  |
| `rank_4` | `tinyint unsigned` | NO |  | 0 |  |
| `faction5` | `smallint unsigned` | NO |  | 0 |  |
| `rate_5` | `float` | NO |  | 0 |  |
| `rank_5` | `tinyint unsigned` | NO |  | 0 |  |
| `faction6` | `smallint unsigned` | NO |  | 0 |  |
| `rate_6` | `float` | NO |  | 0 |  |
| `rank_6` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `faction` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `reputation_spillover_template` (
  `faction` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'faction entry',
  `faction1` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'faction to give spillover for',
  `rate_1` float NOT NULL DEFAULT '0' COMMENT 'the given rep points * rate',
  `rank_1` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'max rank,above this will not give any spillover',
  `faction2` smallint unsigned NOT NULL DEFAULT '0',
  `rate_2` float NOT NULL DEFAULT '0',
  `rank_2` tinyint unsigned NOT NULL DEFAULT '0',
  `faction3` smallint unsigned NOT NULL DEFAULT '0',
  `rate_3` float NOT NULL DEFAULT '0',
  `rank_3` tinyint unsigned NOT NULL DEFAULT '0',
  `faction4` smallint unsigned NOT NULL DEFAULT '0',
  `rate_4` float NOT NULL DEFAULT '0',
  `rank_4` tinyint unsigned NOT NULL DEFAULT '0',
  `faction5` smallint unsigned NOT NULL DEFAULT '0',
  `rate_5` float NOT NULL DEFAULT '0',
  `rank_5` tinyint unsigned NOT NULL DEFAULT '0',
  `faction6` smallint unsigned NOT NULL DEFAULT '0',
  `rate_6` float NOT NULL DEFAULT '0',
  `rank_6` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Reputation spillover reputation gain'
```

---

## scalingstatdistribution_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `StatID_1` | `int` | NO |  | 0 |  |
| `StatID_2` | `int` | NO |  | 0 |  |
| `StatID_3` | `int` | NO |  | 0 |  |
| `StatID_4` | `int` | NO |  | 0 |  |
| `StatID_5` | `int` | NO |  | 0 |  |
| `StatID_6` | `int` | NO |  | 0 |  |
| `StatID_7` | `int` | NO |  | 0 |  |
| `StatID_8` | `int` | NO |  | 0 |  |
| `StatID_9` | `int` | NO |  | 0 |  |
| `StatID_10` | `int` | NO |  | 0 |  |
| `Bonus_1` | `int` | NO |  | 0 |  |
| `Bonus_2` | `int` | NO |  | 0 |  |
| `Bonus_3` | `int` | NO |  | 0 |  |
| `Bonus_4` | `int` | NO |  | 0 |  |
| `Bonus_5` | `int` | NO |  | 0 |  |
| `Bonus_6` | `int` | NO |  | 0 |  |
| `Bonus_7` | `int` | NO |  | 0 |  |
| `Bonus_8` | `int` | NO |  | 0 |  |
| `Bonus_9` | `int` | NO |  | 0 |  |
| `Bonus_10` | `int` | NO |  | 0 |  |
| `Maxlevel` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `scalingstatdistribution_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `StatID_1` int NOT NULL DEFAULT '0',
  `StatID_2` int NOT NULL DEFAULT '0',
  `StatID_3` int NOT NULL DEFAULT '0',
  `StatID_4` int NOT NULL DEFAULT '0',
  `StatID_5` int NOT NULL DEFAULT '0',
  `StatID_6` int NOT NULL DEFAULT '0',
  `StatID_7` int NOT NULL DEFAULT '0',
  `StatID_8` int NOT NULL DEFAULT '0',
  `StatID_9` int NOT NULL DEFAULT '0',
  `StatID_10` int NOT NULL DEFAULT '0',
  `Bonus_1` int NOT NULL DEFAULT '0',
  `Bonus_2` int NOT NULL DEFAULT '0',
  `Bonus_3` int NOT NULL DEFAULT '0',
  `Bonus_4` int NOT NULL DEFAULT '0',
  `Bonus_5` int NOT NULL DEFAULT '0',
  `Bonus_6` int NOT NULL DEFAULT '0',
  `Bonus_7` int NOT NULL DEFAULT '0',
  `Bonus_8` int NOT NULL DEFAULT '0',
  `Bonus_9` int NOT NULL DEFAULT '0',
  `Bonus_10` int NOT NULL DEFAULT '0',
  `Maxlevel` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## scalingstatvalues_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Charlevel` | `int` | NO |  | 0 |  |
| `ShoulderBudget` | `int` | NO |  | 0 |  |
| `TrinketBudget` | `int` | NO |  | 0 |  |
| `WeaponBudget1H` | `int` | NO |  | 0 |  |
| `RangedBudget` | `int` | NO |  | 0 |  |
| `ClothShoulderArmor` | `int` | NO |  | 0 |  |
| `LeatherShoulderArmor` | `int` | NO |  | 0 |  |
| `MailShoulderArmor` | `int` | NO |  | 0 |  |
| `PlateShoulderArmor` | `int` | NO |  | 0 |  |
| `WeaponDPS1H` | `int` | NO |  | 0 |  |
| `WeaponDPS2H` | `int` | NO |  | 0 |  |
| `SpellcasterDPS1H` | `int` | NO |  | 0 |  |
| `SpellcasterDPS2H` | `int` | NO |  | 0 |  |
| `RangedDPS` | `int` | NO |  | 0 |  |
| `WandDPS` | `int` | NO |  | 0 |  |
| `SpellPower` | `int` | NO |  | 0 |  |
| `PrimaryBudget` | `int` | NO |  | 0 |  |
| `TertiaryBudget` | `int` | NO |  | 0 |  |
| `ClothCloakArmor` | `int` | NO |  | 0 |  |
| `ClothChestArmor` | `int` | NO |  | 0 |  |
| `LeatherChestArmor` | `int` | NO |  | 0 |  |
| `MailChestArmor` | `int` | NO |  | 0 |  |
| `PlateChestArmor` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `scalingstatvalues_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Charlevel` int NOT NULL DEFAULT '0',
  `ShoulderBudget` int NOT NULL DEFAULT '0',
  `TrinketBudget` int NOT NULL DEFAULT '0',
  `WeaponBudget1H` int NOT NULL DEFAULT '0',
  `RangedBudget` int NOT NULL DEFAULT '0',
  `ClothShoulderArmor` int NOT NULL DEFAULT '0',
  `LeatherShoulderArmor` int NOT NULL DEFAULT '0',
  `MailShoulderArmor` int NOT NULL DEFAULT '0',
  `PlateShoulderArmor` int NOT NULL DEFAULT '0',
  `WeaponDPS1H` int NOT NULL DEFAULT '0',
  `WeaponDPS2H` int NOT NULL DEFAULT '0',
  `SpellcasterDPS1H` int NOT NULL DEFAULT '0',
  `SpellcasterDPS2H` int NOT NULL DEFAULT '0',
  `RangedDPS` int NOT NULL DEFAULT '0',
  `WandDPS` int NOT NULL DEFAULT '0',
  `SpellPower` int NOT NULL DEFAULT '0',
  `PrimaryBudget` int NOT NULL DEFAULT '0',
  `TertiaryBudget` int NOT NULL DEFAULT '0',
  `ClothCloakArmor` int NOT NULL DEFAULT '0',
  `ClothChestArmor` int NOT NULL DEFAULT '0',
  `LeatherChestArmor` int NOT NULL DEFAULT '0',
  `MailChestArmor` int NOT NULL DEFAULT '0',
  `PlateChestArmor` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## script_waypoint

- 存储引擎: InnoDB
- 行数: 2058
- 注释: Script Creature waypoints

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `pointid` | `int unsigned` | NO | PRI | 0 |  |
| `location_x` | `float` | NO |  | 0 |  |
| `location_y` | `float` | NO |  | 0 |  |
| `location_z` | `float` | NO |  | 0 |  |
| `waittime` | `int unsigned` | NO |  | 0 |  |
| `point_comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| PRIMARY | `pointid` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `script_waypoint` (
  `entry` int unsigned NOT NULL DEFAULT '0' COMMENT 'creature_template entry',
  `pointid` int unsigned NOT NULL DEFAULT '0',
  `location_x` float NOT NULL DEFAULT '0',
  `location_y` float NOT NULL DEFAULT '0',
  `location_z` float NOT NULL DEFAULT '0',
  `waittime` int unsigned NOT NULL DEFAULT '0' COMMENT 'waittime in millisecs',
  `point_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`entry`,`pointid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Script Creature waypoints'
```

---

## skill_discovery_template

- 存储引擎: InnoDB
- 行数: 347
- 注释: Skill Discovery System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spellId` | `int unsigned` | NO | PRI | 0 |  |
| `reqSpell` | `int unsigned` | NO | PRI | 0 |  |
| `reqSkillValue` | `smallint unsigned` | NO |  | 0 |  |
| `chance` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `spellId` | 是 | BTREE |
| PRIMARY | `reqSpell` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skill_discovery_template` (
  `spellId` int unsigned NOT NULL DEFAULT '0' COMMENT 'SpellId of the discoverable spell',
  `reqSpell` int unsigned NOT NULL DEFAULT '0' COMMENT 'spell requirement',
  `reqSkillValue` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'skill points requirement',
  `chance` float NOT NULL DEFAULT '0' COMMENT 'chance to discover',
  PRIMARY KEY (`spellId`,`reqSpell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Skill Discovery System'
```

---

## skill_extra_item_template

- 存储引擎: InnoDB
- 行数: 227
- 注释: Skill Specialization System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spellId` | `int unsigned` | NO | PRI | 0 |  |
| `requiredSpecialization` | `int unsigned` | NO |  | 0 |  |
| `additionalCreateChance` | `float` | NO |  | 0 |  |
| `additionalMaxNum` | `tinyint` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `spellId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skill_extra_item_template` (
  `spellId` int unsigned NOT NULL DEFAULT '0' COMMENT 'SpellId of the item creation spell',
  `requiredSpecialization` int unsigned NOT NULL DEFAULT '0' COMMENT 'Specialization spell id',
  `additionalCreateChance` float NOT NULL DEFAULT '0' COMMENT 'chance to create add',
  `additionalMaxNum` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`spellId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Skill Specialization System'
```

---

## skill_fishing_base_level

- 存储引擎: InnoDB
- 行数: 94
- 注释: Fishing system

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `skill` | `smallint` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skill_fishing_base_level` (
  `entry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Area identifier',
  `skill` smallint NOT NULL DEFAULT '0' COMMENT 'Base skill level requirement',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Fishing system'
```

---

## skill_perfect_item_template

- 存储引擎: InnoDB
- 行数: 72
- 注释: Crafting Perfection System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spellId` | `int unsigned` | NO | PRI | 0 |  |
| `requiredSpecialization` | `int unsigned` | NO |  | 0 |  |
| `perfectCreateChance` | `float` | NO |  | 0 |  |
| `perfectItemType` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `spellId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skill_perfect_item_template` (
  `spellId` int unsigned NOT NULL DEFAULT '0' COMMENT 'SpellId of the item creation spell',
  `requiredSpecialization` int unsigned NOT NULL DEFAULT '0' COMMENT 'Specialization spell id',
  `perfectCreateChance` float NOT NULL DEFAULT '0' COMMENT 'chance to create the perfect item instead',
  `perfectItemType` int unsigned NOT NULL DEFAULT '0' COMMENT 'perfect item type to create instead',
  PRIMARY KEY (`spellId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Crafting Perfection System'
```

---

## skillline_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `CategoryID` | `int` | NO |  | 0 |  |
| `SkillCostsID` | `int` | NO |  | 0 |  |
| `DisplayName_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `DisplayName_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Description_Lang_enUS` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_enGB` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_koKR` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_frFR` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_deDE` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_enCN` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_zhCN` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_enTW` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_zhTW` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_esES` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_esMX` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_ruRU` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_ptPT` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_ptBR` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_itIT` | `varchar(300)` | YES |  |  |  |
| `Description_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `SpellIconID` | `int` | NO |  | 0 |  |
| `AlternateVerb_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `AlternateVerb_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `CanLink` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skillline_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `CategoryID` int NOT NULL DEFAULT '0',
  `SkillCostsID` int NOT NULL DEFAULT '0',
  `DisplayName_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DisplayName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Description_Lang_enUS` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enGB` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_koKR` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_frFR` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_deDE` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enCN` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhCN` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_enTW` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_zhTW` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esES` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_esMX` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ruRU` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptPT` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_ptBR` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_itIT` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `SpellIconID` int NOT NULL DEFAULT '0',
  `AlternateVerb_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AlternateVerb_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `CanLink` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## skilllineability_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `SkillLine` | `int` | NO |  | 0 |  |
| `Spell` | `int` | NO |  | 0 |  |
| `RaceMask` | `int` | NO |  | 0 |  |
| `ClassMask` | `int` | NO |  | 0 |  |
| `ExcludeRace` | `int` | NO |  | 0 |  |
| `ExcludeClass` | `int` | NO |  | 0 |  |
| `MinSkillLineRank` | `int` | NO |  | 0 |  |
| `SupercededBySpell` | `int` | NO |  | 0 |  |
| `AcquireMethod` | `int` | NO |  | 0 |  |
| `TrivialSkillLineRankHigh` | `int` | NO |  | 0 |  |
| `TrivialSkillLineRankLow` | `int` | NO |  | 0 |  |
| `CharacterPoints_1` | `int` | NO |  | 0 |  |
| `CharacterPoints_2` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skilllineability_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `SkillLine` int NOT NULL DEFAULT '0',
  `Spell` int NOT NULL DEFAULT '0',
  `RaceMask` int NOT NULL DEFAULT '0',
  `ClassMask` int NOT NULL DEFAULT '0',
  `ExcludeRace` int NOT NULL DEFAULT '0',
  `ExcludeClass` int NOT NULL DEFAULT '0',
  `MinSkillLineRank` int NOT NULL DEFAULT '0',
  `SupercededBySpell` int NOT NULL DEFAULT '0',
  `AcquireMethod` int NOT NULL DEFAULT '0',
  `TrivialSkillLineRankHigh` int NOT NULL DEFAULT '0',
  `TrivialSkillLineRankLow` int NOT NULL DEFAULT '0',
  `CharacterPoints_1` int NOT NULL DEFAULT '0',
  `CharacterPoints_2` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## skillraceclassinfo_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `SkillID` | `int` | NO |  | 0 |  |
| `RaceMask` | `int` | NO |  | 0 |  |
| `ClassMask` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `MinLevel` | `int` | NO |  | 0 |  |
| `SkillTierID` | `int` | NO |  | 0 |  |
| `SkillCostIndex` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skillraceclassinfo_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `SkillID` int NOT NULL DEFAULT '0',
  `RaceMask` int NOT NULL DEFAULT '0',
  `ClassMask` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `MinLevel` int NOT NULL DEFAULT '0',
  `SkillTierID` int NOT NULL DEFAULT '0',
  `SkillCostIndex` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## skilltiers_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Cost_1` | `int` | NO |  | 0 |  |
| `Cost_2` | `int` | NO |  | 0 |  |
| `Cost_3` | `int` | NO |  | 0 |  |
| `Cost_4` | `int` | NO |  | 0 |  |
| `Cost_5` | `int` | NO |  | 0 |  |
| `Cost_6` | `int` | NO |  | 0 |  |
| `Cost_7` | `int` | NO |  | 0 |  |
| `Cost_8` | `int` | NO |  | 0 |  |
| `Cost_9` | `int` | NO |  | 0 |  |
| `Cost_10` | `int` | NO |  | 0 |  |
| `Cost_11` | `int` | NO |  | 0 |  |
| `Cost_12` | `int` | NO |  | 0 |  |
| `Cost_13` | `int` | NO |  | 0 |  |
| `Cost_14` | `int` | NO |  | 0 |  |
| `Cost_15` | `int` | NO |  | 0 |  |
| `Cost_16` | `int` | NO |  | 0 |  |
| `Value_1` | `int` | NO |  | 0 |  |
| `Value_2` | `int` | NO |  | 0 |  |
| `Value_3` | `int` | NO |  | 0 |  |
| `Value_4` | `int` | NO |  | 0 |  |
| `Value_5` | `int` | NO |  | 0 |  |
| `Value_6` | `int` | NO |  | 0 |  |
| `Value_7` | `int` | NO |  | 0 |  |
| `Value_8` | `int` | NO |  | 0 |  |
| `Value_9` | `int` | NO |  | 0 |  |
| `Value_10` | `int` | NO |  | 0 |  |
| `Value_11` | `int` | NO |  | 0 |  |
| `Value_12` | `int` | NO |  | 0 |  |
| `Value_13` | `int` | NO |  | 0 |  |
| `Value_14` | `int` | NO |  | 0 |  |
| `Value_15` | `int` | NO |  | 0 |  |
| `Value_16` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skilltiers_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Cost_1` int NOT NULL DEFAULT '0',
  `Cost_2` int NOT NULL DEFAULT '0',
  `Cost_3` int NOT NULL DEFAULT '0',
  `Cost_4` int NOT NULL DEFAULT '0',
  `Cost_5` int NOT NULL DEFAULT '0',
  `Cost_6` int NOT NULL DEFAULT '0',
  `Cost_7` int NOT NULL DEFAULT '0',
  `Cost_8` int NOT NULL DEFAULT '0',
  `Cost_9` int NOT NULL DEFAULT '0',
  `Cost_10` int NOT NULL DEFAULT '0',
  `Cost_11` int NOT NULL DEFAULT '0',
  `Cost_12` int NOT NULL DEFAULT '0',
  `Cost_13` int NOT NULL DEFAULT '0',
  `Cost_14` int NOT NULL DEFAULT '0',
  `Cost_15` int NOT NULL DEFAULT '0',
  `Cost_16` int NOT NULL DEFAULT '0',
  `Value_1` int NOT NULL DEFAULT '0',
  `Value_2` int NOT NULL DEFAULT '0',
  `Value_3` int NOT NULL DEFAULT '0',
  `Value_4` int NOT NULL DEFAULT '0',
  `Value_5` int NOT NULL DEFAULT '0',
  `Value_6` int NOT NULL DEFAULT '0',
  `Value_7` int NOT NULL DEFAULT '0',
  `Value_8` int NOT NULL DEFAULT '0',
  `Value_9` int NOT NULL DEFAULT '0',
  `Value_10` int NOT NULL DEFAULT '0',
  `Value_11` int NOT NULL DEFAULT '0',
  `Value_12` int NOT NULL DEFAULT '0',
  `Value_13` int NOT NULL DEFAULT '0',
  `Value_14` int NOT NULL DEFAULT '0',
  `Value_15` int NOT NULL DEFAULT '0',
  `Value_16` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## skinning_loot_template

- 存储引擎: InnoDB
- 行数: 1940
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `skinning_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## smart_scripts

- 存储引擎: InnoDB
- 行数: 51670

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entryorguid` | `int` | NO | PRI |  |  |
| `source_type` | `tinyint unsigned` | NO | PRI | 0 |  |
| `id` | `smallint unsigned` | NO | PRI | 0 |  |
| `link` | `smallint unsigned` | NO | PRI | 0 |  |
| `event_type` | `tinyint unsigned` | NO |  | 0 |  |
| `event_phase_mask` | `smallint unsigned` | NO |  | 0 |  |
| `event_chance` | `tinyint unsigned` | NO |  | 100 |  |
| `event_flags` | `smallint unsigned` | NO |  | 0 |  |
| `event_param1` | `int unsigned` | NO |  | 0 |  |
| `event_param2` | `int unsigned` | NO |  | 0 |  |
| `event_param3` | `int unsigned` | NO |  | 0 |  |
| `event_param4` | `int unsigned` | NO |  | 0 |  |
| `event_param5` | `int unsigned` | NO |  | 0 |  |
| `event_param6` | `int unsigned` | NO |  | 0 |  |
| `action_type` | `tinyint unsigned` | NO |  | 0 |  |
| `action_param1` | `int unsigned` | NO |  | 0 |  |
| `action_param2` | `int unsigned` | NO |  | 0 |  |
| `action_param3` | `int unsigned` | NO |  | 0 |  |
| `action_param4` | `int unsigned` | NO |  | 0 |  |
| `action_param5` | `int unsigned` | NO |  | 0 |  |
| `action_param6` | `int unsigned` | NO |  | 0 |  |
| `target_type` | `tinyint unsigned` | NO |  | 0 |  |
| `target_param1` | `int unsigned` | NO |  | 0 |  |
| `target_param2` | `int unsigned` | NO |  | 0 |  |
| `target_param3` | `int unsigned` | NO |  | 0 |  |
| `target_param4` | `int unsigned` | NO |  | 0 |  |
| `target_x` | `float` | NO |  | 0 |  |
| `target_y` | `float` | NO |  | 0 |  |
| `target_z` | `float` | NO |  | 0 |  |
| `target_o` | `float` | NO |  | 0 |  |
| `comment` | `text` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entryorguid` | 是 | BTREE |
| PRIMARY | `source_type` | 是 | BTREE |
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `link` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `smart_scripts` (
  `entryorguid` int NOT NULL,
  `source_type` tinyint unsigned NOT NULL DEFAULT '0',
  `id` smallint unsigned NOT NULL DEFAULT '0',
  `link` smallint unsigned NOT NULL DEFAULT '0',
  `event_type` tinyint unsigned NOT NULL DEFAULT '0',
  `event_phase_mask` smallint unsigned NOT NULL DEFAULT '0',
  `event_chance` tinyint unsigned NOT NULL DEFAULT '100',
  `event_flags` smallint unsigned NOT NULL DEFAULT '0',
  `event_param1` int unsigned NOT NULL DEFAULT '0',
  `event_param2` int unsigned NOT NULL DEFAULT '0',
  `event_param3` int unsigned NOT NULL DEFAULT '0',
  `event_param4` int unsigned NOT NULL DEFAULT '0',
  `event_param5` int unsigned NOT NULL DEFAULT '0',
  `event_param6` int unsigned NOT NULL DEFAULT '0',
  `action_type` tinyint unsigned NOT NULL DEFAULT '0',
  `action_param1` int unsigned NOT NULL DEFAULT '0',
  `action_param2` int unsigned NOT NULL DEFAULT '0',
  `action_param3` int unsigned NOT NULL DEFAULT '0',
  `action_param4` int unsigned NOT NULL DEFAULT '0',
  `action_param5` int unsigned NOT NULL DEFAULT '0',
  `action_param6` int unsigned NOT NULL DEFAULT '0',
  `target_type` tinyint unsigned NOT NULL DEFAULT '0',
  `target_param1` int unsigned NOT NULL DEFAULT '0',
  `target_param2` int unsigned NOT NULL DEFAULT '0',
  `target_param3` int unsigned NOT NULL DEFAULT '0',
  `target_param4` int unsigned NOT NULL DEFAULT '0',
  `target_x` float NOT NULL DEFAULT '0',
  `target_y` float NOT NULL DEFAULT '0',
  `target_z` float NOT NULL DEFAULT '0',
  `target_o` float NOT NULL DEFAULT '0',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Event Comment',
  PRIMARY KEY (`entryorguid`,`source_type`,`id`,`link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## soundentries_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `SoundType` | `int` | NO |  | 0 |  |
| `Name` | `varchar(100)` | YES |  |  |  |
| `File_1` | `varchar(100)` | YES |  |  |  |
| `File_2` | `varchar(100)` | YES |  |  |  |
| `File_3` | `varchar(100)` | YES |  |  |  |
| `File_4` | `varchar(100)` | YES |  |  |  |
| `File_5` | `varchar(100)` | YES |  |  |  |
| `File_6` | `varchar(100)` | YES |  |  |  |
| `File_7` | `varchar(100)` | YES |  |  |  |
| `File_8` | `varchar(100)` | YES |  |  |  |
| `File_9` | `varchar(100)` | YES |  |  |  |
| `File_10` | `varchar(100)` | YES |  |  |  |
| `Freq_1` | `int` | NO |  | 0 |  |
| `Freq_2` | `int` | NO |  | 0 |  |
| `Freq_3` | `int` | NO |  | 0 |  |
| `Freq_4` | `int` | NO |  | 0 |  |
| `Freq_5` | `int` | NO |  | 0 |  |
| `Freq_6` | `int` | NO |  | 0 |  |
| `Freq_7` | `int` | NO |  | 0 |  |
| `Freq_8` | `int` | NO |  | 0 |  |
| `Freq_9` | `int` | NO |  | 0 |  |
| `Freq_10` | `int` | NO |  | 0 |  |
| `DirectoryBase` | `varchar(100)` | YES |  |  |  |
| `Volumefloat` | `float` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `MinDistance` | `float` | NO |  | 0 |  |
| `DistanceCutoff` | `float` | NO |  | 0 |  |
| `EAXDef` | `int` | NO |  | 0 |  |
| `SoundEntriesAdvancedID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `soundentries_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `SoundType` int NOT NULL DEFAULT '0',
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_4` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_5` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_6` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_7` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_8` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_9` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `File_10` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Freq_1` int NOT NULL DEFAULT '0',
  `Freq_2` int NOT NULL DEFAULT '0',
  `Freq_3` int NOT NULL DEFAULT '0',
  `Freq_4` int NOT NULL DEFAULT '0',
  `Freq_5` int NOT NULL DEFAULT '0',
  `Freq_6` int NOT NULL DEFAULT '0',
  `Freq_7` int NOT NULL DEFAULT '0',
  `Freq_8` int NOT NULL DEFAULT '0',
  `Freq_9` int NOT NULL DEFAULT '0',
  `Freq_10` int NOT NULL DEFAULT '0',
  `DirectoryBase` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Volumefloat` float NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `MinDistance` float NOT NULL DEFAULT '0',
  `DistanceCutoff` float NOT NULL DEFAULT '0',
  `EAXDef` int NOT NULL DEFAULT '0',
  `SoundEntriesAdvancedID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spawn_group

- 存储引擎: InnoDB
- 行数: 38

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `groupId` | `int unsigned` | NO | PRI |  |  |
| `spawnType` | `tinyint unsigned` | NO | PRI |  |  |
| `spawnId` | `int unsigned` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `groupId` | 是 | BTREE |
| PRIMARY | `spawnType` | 是 | BTREE |
| PRIMARY | `spawnId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spawn_group` (
  `groupId` int unsigned NOT NULL,
  `spawnType` tinyint unsigned NOT NULL,
  `spawnId` int unsigned NOT NULL,
  PRIMARY KEY (`groupId`,`spawnType`,`spawnId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## spawn_group_template

- 存储引擎: InnoDB
- 行数: 6

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `groupId` | `int unsigned` | NO | PRI |  |  |
| `groupName` | `varchar(100)` | NO |  |  |  |
| `groupFlags` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `groupId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spawn_group_template` (
  `groupId` int unsigned NOT NULL,
  `groupName` varchar(100) NOT NULL,
  `groupFlags` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## spell_area

- 存储引擎: InnoDB
- 行数: 720

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spell` | `int unsigned` | NO | PRI | 0 |  |
| `area` | `int unsigned` | NO | PRI | 0 |  |
| `quest_start` | `int unsigned` | NO | PRI | 0 |  |
| `quest_end` | `int unsigned` | NO |  | 0 |  |
| `aura_spell` | `int` | NO | PRI | 0 |  |
| `racemask` | `int unsigned` | NO | PRI | 0 |  |
| `gender` | `tinyint unsigned` | NO | PRI | 2 |  |
| `autocast` | `tinyint unsigned` | NO |  | 0 |  |
| `quest_start_status` | `int` | NO |  | 64 |  |
| `quest_end_status` | `int` | NO |  | 11 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `spell` | 是 | BTREE |
| PRIMARY | `area` | 是 | BTREE |
| PRIMARY | `quest_start` | 是 | BTREE |
| PRIMARY | `aura_spell` | 是 | BTREE |
| PRIMARY | `racemask` | 是 | BTREE |
| PRIMARY | `gender` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_area` (
  `spell` int unsigned NOT NULL DEFAULT '0',
  `area` int unsigned NOT NULL DEFAULT '0',
  `quest_start` int unsigned NOT NULL DEFAULT '0',
  `quest_end` int unsigned NOT NULL DEFAULT '0',
  `aura_spell` int NOT NULL DEFAULT '0',
  `racemask` int unsigned NOT NULL DEFAULT '0',
  `gender` tinyint unsigned NOT NULL DEFAULT '2',
  `autocast` tinyint unsigned NOT NULL DEFAULT '0',
  `quest_start_status` int NOT NULL DEFAULT '64',
  `quest_end_status` int NOT NULL DEFAULT '11',
  PRIMARY KEY (`spell`,`area`,`quest_start`,`aura_spell`,`racemask`,`gender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_bonus_data

- 存储引擎: InnoDB
- 行数: 1270

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `direct_bonus` | `float` | NO |  | 0 |  |
| `dot_bonus` | `float` | NO |  | 0 |  |
| `ap_bonus` | `float` | NO |  | 0 |  |
| `ap_dot_bonus` | `float` | NO |  | 0 |  |
| `comments` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_bonus_data` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `direct_bonus` float NOT NULL DEFAULT '0',
  `dot_bonus` float NOT NULL DEFAULT '0',
  `ap_bonus` float NOT NULL DEFAULT '0',
  `ap_dot_bonus` float NOT NULL DEFAULT '0',
  `comments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_cooldown_overrides

- 存储引擎: InnoDB
- 行数: 1065

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Id` | `int unsigned` | NO | PRI |  |  |
| `RecoveryTime` | `int unsigned` | NO |  | 0 |  |
| `CategoryRecoveryTime` | `int unsigned` | NO |  | 0 |  |
| `StartRecoveryTime` | `int unsigned` | NO |  | 0 |  |
| `StartRecoveryCategory` | `int unsigned` | NO |  | 0 |  |
| `Comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_cooldown_overrides` (
  `Id` int unsigned NOT NULL,
  `RecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `CategoryRecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `StartRecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `StartRecoveryCategory` int unsigned NOT NULL DEFAULT '0',
  `Comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_custom_attr

- 存储引擎: InnoDB
- 行数: 413
- 注释: SpellInfo custom attributes

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spell_id` | `int unsigned` | NO | PRI | 0 |  |
| `attributes` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `spell_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_custom_attr` (
  `spell_id` int unsigned NOT NULL DEFAULT '0' COMMENT 'spell id',
  `attributes` int unsigned NOT NULL DEFAULT '0' COMMENT 'SpellCustomAttributes',
  PRIMARY KEY (`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SpellInfo custom attributes'
```

---

## spell_dbc

- 存储引擎: InnoDB
- 行数: 4294

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Category` | `int unsigned` | NO |  | 0 |  |
| `DispelType` | `int unsigned` | NO |  | 0 |  |
| `Mechanic` | `int unsigned` | NO |  | 0 |  |
| `Attributes` | `int unsigned` | NO |  | 0 |  |
| `AttributesEx` | `int unsigned` | NO |  | 0 |  |
| `AttributesEx2` | `int unsigned` | NO |  | 0 |  |
| `AttributesEx3` | `int unsigned` | NO |  | 0 |  |
| `AttributesEx4` | `int unsigned` | NO |  | 0 |  |
| `AttributesEx5` | `int unsigned` | NO |  | 0 |  |
| `AttributesEx6` | `int unsigned` | NO |  | 0 |  |
| `AttributesEx7` | `int unsigned` | NO |  | 0 |  |
| `ShapeshiftMask` | `bigint unsigned` | NO |  | 0 |  |
| `unk_320_2` | `int` | NO |  | 0 |  |
| `ShapeshiftExclude` | `bigint unsigned` | NO |  | 0 |  |
| `unk_320_3` | `int` | NO |  | 0 |  |
| `Targets` | `int unsigned` | NO |  | 0 |  |
| `TargetCreatureType` | `int unsigned` | NO |  | 0 |  |
| `RequiresSpellFocus` | `int unsigned` | NO |  | 0 |  |
| `FacingCasterFlags` | `int unsigned` | NO |  | 0 |  |
| `CasterAuraState` | `int unsigned` | NO |  | 0 |  |
| `TargetAuraState` | `int unsigned` | NO |  | 0 |  |
| `ExcludeCasterAuraState` | `int unsigned` | NO |  | 0 |  |
| `ExcludeTargetAuraState` | `int unsigned` | NO |  | 0 |  |
| `CasterAuraSpell` | `int unsigned` | NO |  | 0 |  |
| `TargetAuraSpell` | `int unsigned` | NO |  | 0 |  |
| `ExcludeCasterAuraSpell` | `int unsigned` | NO |  | 0 |  |
| `ExcludeTargetAuraSpell` | `int unsigned` | NO |  | 0 |  |
| `CastingTimeIndex` | `int unsigned` | NO |  | 0 |  |
| `RecoveryTime` | `int unsigned` | NO |  | 0 |  |
| `CategoryRecoveryTime` | `int unsigned` | NO |  | 0 |  |
| `InterruptFlags` | `int unsigned` | NO |  | 0 |  |
| `AuraInterruptFlags` | `int unsigned` | NO |  | 0 |  |
| `ChannelInterruptFlags` | `int unsigned` | NO |  | 0 |  |
| `ProcTypeMask` | `int unsigned` | NO |  | 0 |  |
| `ProcChance` | `int unsigned` | NO |  | 0 |  |
| `ProcCharges` | `int unsigned` | NO |  | 0 |  |
| `MaxLevel` | `int unsigned` | NO |  | 0 |  |
| `BaseLevel` | `int unsigned` | NO |  | 0 |  |
| `SpellLevel` | `int unsigned` | NO |  | 0 |  |
| `DurationIndex` | `int unsigned` | NO |  | 0 |  |
| `PowerType` | `int` | NO |  | 0 |  |
| `ManaCost` | `int unsigned` | NO |  | 0 |  |
| `ManaCostPerLevel` | `int unsigned` | NO |  | 0 |  |
| `ManaPerSecond` | `int unsigned` | NO |  | 0 |  |
| `ManaPerSecondPerLevel` | `int unsigned` | NO |  | 0 |  |
| `RangeIndex` | `int unsigned` | NO |  | 0 |  |
| `Speed` | `float` | NO |  | 0 |  |
| `ModalNextSpell` | `int unsigned` | NO |  | 0 |  |
| `CumulativeAura` | `int unsigned` | NO |  | 0 |  |
| `Totem_1` | `int unsigned` | NO |  | 0 |  |
| `Totem_2` | `int unsigned` | NO |  | 0 |  |
| `Reagent_1` | `int` | NO |  | 0 |  |
| `Reagent_2` | `int` | NO |  | 0 |  |
| `Reagent_3` | `int` | NO |  | 0 |  |
| `Reagent_4` | `int` | NO |  | 0 |  |
| `Reagent_5` | `int` | NO |  | 0 |  |
| `Reagent_6` | `int` | NO |  | 0 |  |
| `Reagent_7` | `int` | NO |  | 0 |  |
| `Reagent_8` | `int` | NO |  | 0 |  |
| `ReagentCount_1` | `int` | NO |  | 0 |  |
| `ReagentCount_2` | `int` | NO |  | 0 |  |
| `ReagentCount_3` | `int` | NO |  | 0 |  |
| `ReagentCount_4` | `int` | NO |  | 0 |  |
| `ReagentCount_5` | `int` | NO |  | 0 |  |
| `ReagentCount_6` | `int` | NO |  | 0 |  |
| `ReagentCount_7` | `int` | NO |  | 0 |  |
| `ReagentCount_8` | `int` | NO |  | 0 |  |
| `EquippedItemClass` | `int` | NO |  | 0 |  |
| `EquippedItemSubclass` | `int` | NO |  | 0 |  |
| `EquippedItemInvTypes` | `int` | NO |  | 0 |  |
| `Effect_1` | `int unsigned` | NO |  | 0 |  |
| `Effect_2` | `int unsigned` | NO |  | 0 |  |
| `Effect_3` | `int unsigned` | NO |  | 0 |  |
| `EffectDieSides_1` | `int` | NO |  | 0 |  |
| `EffectDieSides_2` | `int` | NO |  | 0 |  |
| `EffectDieSides_3` | `int` | NO |  | 0 |  |
| `EffectRealPointsPerLevel_1` | `float` | NO |  | 0 |  |
| `EffectRealPointsPerLevel_2` | `float` | NO |  | 0 |  |
| `EffectRealPointsPerLevel_3` | `float` | NO |  | 0 |  |
| `EffectBasePoints_1` | `int` | NO |  | 0 |  |
| `EffectBasePoints_2` | `int` | NO |  | 0 |  |
| `EffectBasePoints_3` | `int` | NO |  | 0 |  |
| `EffectMechanic_1` | `int unsigned` | NO |  | 0 |  |
| `EffectMechanic_2` | `int unsigned` | NO |  | 0 |  |
| `EffectMechanic_3` | `int unsigned` | NO |  | 0 |  |
| `ImplicitTargetA_1` | `int unsigned` | NO |  | 0 |  |
| `ImplicitTargetA_2` | `int unsigned` | NO |  | 0 |  |
| `ImplicitTargetA_3` | `int unsigned` | NO |  | 0 |  |
| `ImplicitTargetB_1` | `int unsigned` | NO |  | 0 |  |
| `ImplicitTargetB_2` | `int unsigned` | NO |  | 0 |  |
| `ImplicitTargetB_3` | `int unsigned` | NO |  | 0 |  |
| `EffectRadiusIndex_1` | `int unsigned` | NO |  | 0 |  |
| `EffectRadiusIndex_2` | `int unsigned` | NO |  | 0 |  |
| `EffectRadiusIndex_3` | `int unsigned` | NO |  | 0 |  |
| `EffectAura_1` | `int unsigned` | NO |  | 0 |  |
| `EffectAura_2` | `int unsigned` | NO |  | 0 |  |
| `EffectAura_3` | `int unsigned` | NO |  | 0 |  |
| `EffectAuraPeriod_1` | `int unsigned` | NO |  | 0 |  |
| `EffectAuraPeriod_2` | `int unsigned` | NO |  | 0 |  |
| `EffectAuraPeriod_3` | `int unsigned` | NO |  | 0 |  |
| `EffectMultipleValue_1` | `float` | NO |  | 0 |  |
| `EffectMultipleValue_2` | `float` | NO |  | 0 |  |
| `EffectMultipleValue_3` | `float` | NO |  | 0 |  |
| `EffectChainTargets_1` | `int unsigned` | NO |  | 0 |  |
| `EffectChainTargets_2` | `int unsigned` | NO |  | 0 |  |
| `EffectChainTargets_3` | `int unsigned` | NO |  | 0 |  |
| `EffectItemType_1` | `int unsigned` | NO |  | 0 |  |
| `EffectItemType_2` | `int unsigned` | NO |  | 0 |  |
| `EffectItemType_3` | `int unsigned` | NO |  | 0 |  |
| `EffectMiscValue_1` | `int` | NO |  | 0 |  |
| `EffectMiscValue_2` | `int` | NO |  | 0 |  |
| `EffectMiscValue_3` | `int` | NO |  | 0 |  |
| `EffectMiscValueB_1` | `int` | NO |  | 0 |  |
| `EffectMiscValueB_2` | `int` | NO |  | 0 |  |
| `EffectMiscValueB_3` | `int` | NO |  | 0 |  |
| `EffectTriggerSpell_1` | `int unsigned` | NO |  | 0 |  |
| `EffectTriggerSpell_2` | `int unsigned` | NO |  | 0 |  |
| `EffectTriggerSpell_3` | `int unsigned` | NO |  | 0 |  |
| `EffectPointsPerCombo_1` | `float` | NO |  | 0 |  |
| `EffectPointsPerCombo_2` | `float` | NO |  | 0 |  |
| `EffectPointsPerCombo_3` | `float` | NO |  | 0 |  |
| `EffectSpellClassMaskA_1` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskA_2` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskA_3` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskB_1` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskB_2` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskB_3` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskC_1` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskC_2` | `int unsigned` | NO |  | 0 |  |
| `EffectSpellClassMaskC_3` | `int unsigned` | NO |  | 0 |  |
| `SpellVisualID_1` | `int unsigned` | NO |  | 0 |  |
| `SpellVisualID_2` | `int unsigned` | NO |  | 0 |  |
| `SpellIconID` | `int unsigned` | NO |  | 0 |  |
| `ActiveIconID` | `int unsigned` | NO |  | 0 |  |
| `SpellPriority` | `int unsigned` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `NameSubtext_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `NameSubtext_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Description_Lang_enUS` | `text` | YES |  |  |  |
| `Description_Lang_enGB` | `text` | YES |  |  |  |
| `Description_Lang_koKR` | `text` | YES |  |  |  |
| `Description_Lang_frFR` | `text` | YES |  |  |  |
| `Description_Lang_deDE` | `text` | YES |  |  |  |
| `Description_Lang_enCN` | `text` | YES |  |  |  |
| `Description_Lang_zhCN` | `text` | YES |  |  |  |
| `Description_Lang_enTW` | `text` | YES |  |  |  |
| `Description_Lang_zhTW` | `text` | YES |  |  |  |
| `Description_Lang_esES` | `text` | YES |  |  |  |
| `Description_Lang_esMX` | `text` | YES |  |  |  |
| `Description_Lang_ruRU` | `text` | YES |  |  |  |
| `Description_Lang_ptPT` | `text` | YES |  |  |  |
| `Description_Lang_ptBR` | `text` | YES |  |  |  |
| `Description_Lang_itIT` | `text` | YES |  |  |  |
| `Description_Lang_Unk` | `text` | YES |  |  |  |
| `Description_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `AuraDescription_Lang_enUS` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_enGB` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_koKR` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_frFR` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_deDE` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_enCN` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_zhCN` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_enTW` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_zhTW` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_esES` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_esMX` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_ruRU` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_ptPT` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_ptBR` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_itIT` | `varchar(550)` | YES |  |  |  |
| `AuraDescription_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `AuraDescription_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `ManaCostPct` | `int unsigned` | NO |  | 0 |  |
| `StartRecoveryCategory` | `int unsigned` | NO |  | 0 |  |
| `StartRecoveryTime` | `int unsigned` | NO |  | 0 |  |
| `MaxTargetLevel` | `int unsigned` | NO |  | 0 |  |
| `SpellClassSet` | `int unsigned` | NO |  | 0 |  |
| `SpellClassMask_1` | `int unsigned` | NO |  | 0 |  |
| `SpellClassMask_2` | `int unsigned` | NO |  | 0 |  |
| `SpellClassMask_3` | `int unsigned` | NO |  | 0 |  |
| `MaxTargets` | `int unsigned` | NO |  | 0 |  |
| `DefenseType` | `int unsigned` | NO |  | 0 |  |
| `PreventionType` | `int unsigned` | NO |  | 0 |  |
| `StanceBarOrder` | `int unsigned` | NO |  | 0 |  |
| `EffectChainAmplitude_1` | `float` | NO |  | 0 |  |
| `EffectChainAmplitude_2` | `float` | NO |  | 0 |  |
| `EffectChainAmplitude_3` | `float` | NO |  | 0 |  |
| `MinFactionID` | `int unsigned` | NO |  | 0 |  |
| `MinReputation` | `int unsigned` | NO |  | 0 |  |
| `RequiredAuraVision` | `int unsigned` | NO |  | 0 |  |
| `RequiredTotemCategoryID_1` | `int unsigned` | NO |  | 0 |  |
| `RequiredTotemCategoryID_2` | `int unsigned` | NO |  | 0 |  |
| `RequiredAreasID` | `int` | NO |  | 0 |  |
| `SchoolMask` | `int unsigned` | NO |  | 0 |  |
| `RuneCostID` | `int unsigned` | NO |  | 0 |  |
| `SpellMissileID` | `int unsigned` | NO |  | 0 |  |
| `PowerDisplayID` | `int` | NO |  | 0 |  |
| `EffectBonusMultiplier_1` | `float` | NO |  | 0 |  |
| `EffectBonusMultiplier_2` | `float` | NO |  | 0 |  |
| `EffectBonusMultiplier_3` | `float` | NO |  | 0 |  |
| `SpellDescriptionVariableID` | `int unsigned` | NO |  | 0 |  |
| `SpellDifficultyID` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Category` int unsigned NOT NULL DEFAULT '0',
  `DispelType` int unsigned NOT NULL DEFAULT '0',
  `Mechanic` int unsigned NOT NULL DEFAULT '0',
  `Attributes` int unsigned NOT NULL DEFAULT '0',
  `AttributesEx` int unsigned NOT NULL DEFAULT '0',
  `AttributesEx2` int unsigned NOT NULL DEFAULT '0',
  `AttributesEx3` int unsigned NOT NULL DEFAULT '0',
  `AttributesEx4` int unsigned NOT NULL DEFAULT '0',
  `AttributesEx5` int unsigned NOT NULL DEFAULT '0',
  `AttributesEx6` int unsigned NOT NULL DEFAULT '0',
  `AttributesEx7` int unsigned NOT NULL DEFAULT '0',
  `ShapeshiftMask` bigint unsigned NOT NULL DEFAULT '0',
  `unk_320_2` int NOT NULL DEFAULT '0',
  `ShapeshiftExclude` bigint unsigned NOT NULL DEFAULT '0',
  `unk_320_3` int NOT NULL DEFAULT '0',
  `Targets` int unsigned NOT NULL DEFAULT '0',
  `TargetCreatureType` int unsigned NOT NULL DEFAULT '0',
  `RequiresSpellFocus` int unsigned NOT NULL DEFAULT '0',
  `FacingCasterFlags` int unsigned NOT NULL DEFAULT '0',
  `CasterAuraState` int unsigned NOT NULL DEFAULT '0',
  `TargetAuraState` int unsigned NOT NULL DEFAULT '0',
  `ExcludeCasterAuraState` int unsigned NOT NULL DEFAULT '0',
  `ExcludeTargetAuraState` int unsigned NOT NULL DEFAULT '0',
  `CasterAuraSpell` int unsigned NOT NULL DEFAULT '0',
  `TargetAuraSpell` int unsigned NOT NULL DEFAULT '0',
  `ExcludeCasterAuraSpell` int unsigned NOT NULL DEFAULT '0',
  `ExcludeTargetAuraSpell` int unsigned NOT NULL DEFAULT '0',
  `CastingTimeIndex` int unsigned NOT NULL DEFAULT '0',
  `RecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `CategoryRecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `InterruptFlags` int unsigned NOT NULL DEFAULT '0',
  `AuraInterruptFlags` int unsigned NOT NULL DEFAULT '0',
  `ChannelInterruptFlags` int unsigned NOT NULL DEFAULT '0',
  `ProcTypeMask` int unsigned NOT NULL DEFAULT '0',
  `ProcChance` int unsigned NOT NULL DEFAULT '0',
  `ProcCharges` int unsigned NOT NULL DEFAULT '0',
  `MaxLevel` int unsigned NOT NULL DEFAULT '0',
  `BaseLevel` int unsigned NOT NULL DEFAULT '0',
  `SpellLevel` int unsigned NOT NULL DEFAULT '0',
  `DurationIndex` int unsigned NOT NULL DEFAULT '0',
  `PowerType` int NOT NULL DEFAULT '0',
  `ManaCost` int unsigned NOT NULL DEFAULT '0',
  `ManaCostPerLevel` int unsigned NOT NULL DEFAULT '0',
  `ManaPerSecond` int unsigned NOT NULL DEFAULT '0',
  `ManaPerSecondPerLevel` int unsigned NOT NULL DEFAULT '0',
  `RangeIndex` int unsigned NOT NULL DEFAULT '0',
  `Speed` float NOT NULL DEFAULT '0',
  `ModalNextSpell` int unsigned NOT NULL DEFAULT '0',
  `CumulativeAura` int unsigned NOT NULL DEFAULT '0',
  `Totem_1` int unsigned NOT NULL DEFAULT '0',
  `Totem_2` int unsigned NOT NULL DEFAULT '0',
  `Reagent_1` int NOT NULL DEFAULT '0',
  `Reagent_2` int NOT NULL DEFAULT '0',
  `Reagent_3` int NOT NULL DEFAULT '0',
  `Reagent_4` int NOT NULL DEFAULT '0',
  `Reagent_5` int NOT NULL DEFAULT '0',
  `Reagent_6` int NOT NULL DEFAULT '0',
  `Reagent_7` int NOT NULL DEFAULT '0',
  `Reagent_8` int NOT NULL DEFAULT '0',
  `ReagentCount_1` int NOT NULL DEFAULT '0',
  `ReagentCount_2` int NOT NULL DEFAULT '0',
  `ReagentCount_3` int NOT NULL DEFAULT '0',
  `ReagentCount_4` int NOT NULL DEFAULT '0',
  `ReagentCount_5` int NOT NULL DEFAULT '0',
  `ReagentCount_6` int NOT NULL DEFAULT '0',
  `ReagentCount_7` int NOT NULL DEFAULT '0',
  `ReagentCount_8` int NOT NULL DEFAULT '0',
  `EquippedItemClass` int NOT NULL DEFAULT '0',
  `EquippedItemSubclass` int NOT NULL DEFAULT '0',
  `EquippedItemInvTypes` int NOT NULL DEFAULT '0',
  `Effect_1` int unsigned NOT NULL DEFAULT '0',
  `Effect_2` int unsigned NOT NULL DEFAULT '0',
  `Effect_3` int unsigned NOT NULL DEFAULT '0',
  `EffectDieSides_1` int NOT NULL DEFAULT '0',
  `EffectDieSides_2` int NOT NULL DEFAULT '0',
  `EffectDieSides_3` int NOT NULL DEFAULT '0',
  `EffectRealPointsPerLevel_1` float NOT NULL DEFAULT '0',
  `EffectRealPointsPerLevel_2` float NOT NULL DEFAULT '0',
  `EffectRealPointsPerLevel_3` float NOT NULL DEFAULT '0',
  `EffectBasePoints_1` int NOT NULL DEFAULT '0',
  `EffectBasePoints_2` int NOT NULL DEFAULT '0',
  `EffectBasePoints_3` int NOT NULL DEFAULT '0',
  `EffectMechanic_1` int unsigned NOT NULL DEFAULT '0',
  `EffectMechanic_2` int unsigned NOT NULL DEFAULT '0',
  `EffectMechanic_3` int unsigned NOT NULL DEFAULT '0',
  `ImplicitTargetA_1` int unsigned NOT NULL DEFAULT '0',
  `ImplicitTargetA_2` int unsigned NOT NULL DEFAULT '0',
  `ImplicitTargetA_3` int unsigned NOT NULL DEFAULT '0',
  `ImplicitTargetB_1` int unsigned NOT NULL DEFAULT '0',
  `ImplicitTargetB_2` int unsigned NOT NULL DEFAULT '0',
  `ImplicitTargetB_3` int unsigned NOT NULL DEFAULT '0',
  `EffectRadiusIndex_1` int unsigned NOT NULL DEFAULT '0',
  `EffectRadiusIndex_2` int unsigned NOT NULL DEFAULT '0',
  `EffectRadiusIndex_3` int unsigned NOT NULL DEFAULT '0',
  `EffectAura_1` int unsigned NOT NULL DEFAULT '0',
  `EffectAura_2` int unsigned NOT NULL DEFAULT '0',
  `EffectAura_3` int unsigned NOT NULL DEFAULT '0',
  `EffectAuraPeriod_1` int unsigned NOT NULL DEFAULT '0',
  `EffectAuraPeriod_2` int unsigned NOT NULL DEFAULT '0',
  `EffectAuraPeriod_3` int unsigned NOT NULL DEFAULT '0',
  `EffectMultipleValue_1` float NOT NULL DEFAULT '0',
  `EffectMultipleValue_2` float NOT NULL DEFAULT '0',
  `EffectMultipleValue_3` float NOT NULL DEFAULT '0',
  `EffectChainTargets_1` int unsigned NOT NULL DEFAULT '0',
  `EffectChainTargets_2` int unsigned NOT NULL DEFAULT '0',
  `EffectChainTargets_3` int unsigned NOT NULL DEFAULT '0',
  `EffectItemType_1` int unsigned NOT NULL DEFAULT '0',
  `EffectItemType_2` int unsigned NOT NULL DEFAULT '0',
  `EffectItemType_3` int unsigned NOT NULL DEFAULT '0',
  `EffectMiscValue_1` int NOT NULL DEFAULT '0',
  `EffectMiscValue_2` int NOT NULL DEFAULT '0',
  `EffectMiscValue_3` int NOT NULL DEFAULT '0',
  `EffectMiscValueB_1` int NOT NULL DEFAULT '0',
  `EffectMiscValueB_2` int NOT NULL DEFAULT '0',
  `EffectMiscValueB_3` int NOT NULL DEFAULT '0',
  `EffectTriggerSpell_1` int unsigned NOT NULL DEFAULT '0',
  `EffectTriggerSpell_2` int unsigned NOT NULL DEFAULT '0',
  `EffectTriggerSpell_3` int unsigned NOT NULL DEFAULT '0',
  `EffectPointsPerCombo_1` float NOT NULL DEFAULT '0',
  `EffectPointsPerCombo_2` float NOT NULL DEFAULT '0',
  `EffectPointsPerCombo_3` float NOT NULL DEFAULT '0',
  `EffectSpellClassMaskA_1` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskA_2` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskA_3` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskB_1` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskB_2` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskB_3` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskC_1` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskC_2` int unsigned NOT NULL DEFAULT '0',
  `EffectSpellClassMaskC_3` int unsigned NOT NULL DEFAULT '0',
  `SpellVisualID_1` int unsigned NOT NULL DEFAULT '0',
  `SpellVisualID_2` int unsigned NOT NULL DEFAULT '0',
  `SpellIconID` int unsigned NOT NULL DEFAULT '0',
  `ActiveIconID` int unsigned NOT NULL DEFAULT '0',
  `SpellPriority` int unsigned NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `NameSubtext_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameSubtext_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Description_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_Unk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Description_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `AuraDescription_Lang_enUS` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_enGB` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_koKR` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_frFR` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_deDE` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_enCN` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_zhCN` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_enTW` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_zhTW` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_esES` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_esMX` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_ruRU` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_ptPT` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_ptBR` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_itIT` varchar(550) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AuraDescription_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `ManaCostPct` int unsigned NOT NULL DEFAULT '0',
  `StartRecoveryCategory` int unsigned NOT NULL DEFAULT '0',
  `StartRecoveryTime` int unsigned NOT NULL DEFAULT '0',
  `MaxTargetLevel` int unsigned NOT NULL DEFAULT '0',
  `SpellClassSet` int unsigned NOT NULL DEFAULT '0',
  `SpellClassMask_1` int unsigned NOT NULL DEFAULT '0',
  `SpellClassMask_2` int unsigned NOT NULL DEFAULT '0',
  `SpellClassMask_3` int unsigned NOT NULL DEFAULT '0',
  `MaxTargets` int unsigned NOT NULL DEFAULT '0',
  `DefenseType` int unsigned NOT NULL DEFAULT '0',
  `PreventionType` int unsigned NOT NULL DEFAULT '0',
  `StanceBarOrder` int unsigned NOT NULL DEFAULT '0',
  `EffectChainAmplitude_1` float NOT NULL DEFAULT '0',
  `EffectChainAmplitude_2` float NOT NULL DEFAULT '0',
  `EffectChainAmplitude_3` float NOT NULL DEFAULT '0',
  `MinFactionID` int unsigned NOT NULL DEFAULT '0',
  `MinReputation` int unsigned NOT NULL DEFAULT '0',
  `RequiredAuraVision` int unsigned NOT NULL DEFAULT '0',
  `RequiredTotemCategoryID_1` int unsigned NOT NULL DEFAULT '0',
  `RequiredTotemCategoryID_2` int unsigned NOT NULL DEFAULT '0',
  `RequiredAreasID` int NOT NULL DEFAULT '0',
  `SchoolMask` int unsigned NOT NULL DEFAULT '0',
  `RuneCostID` int unsigned NOT NULL DEFAULT '0',
  `SpellMissileID` int unsigned NOT NULL DEFAULT '0',
  `PowerDisplayID` int NOT NULL DEFAULT '0',
  `EffectBonusMultiplier_1` float NOT NULL DEFAULT '0',
  `EffectBonusMultiplier_2` float NOT NULL DEFAULT '0',
  `EffectBonusMultiplier_3` float NOT NULL DEFAULT '0',
  `SpellDescriptionVariableID` int unsigned NOT NULL DEFAULT '0',
  `SpellDifficultyID` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_enchant_proc_data

- 存储引擎: InnoDB
- 行数: 42
- 注释: Spell enchant proc data

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI |  |  |
| `customChance` | `int unsigned` | NO |  | 0 |  |
| `PPMChance` | `float` | NO |  | 0 |  |
| `procEx` | `int unsigned` | NO |  | 0 |  |
| `attributeMask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_enchant_proc_data` (
  `entry` int unsigned NOT NULL,
  `customChance` int unsigned NOT NULL DEFAULT '0',
  `PPMChance` float NOT NULL DEFAULT '0',
  `procEx` int unsigned NOT NULL DEFAULT '0',
  `attributeMask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`),
  CONSTRAINT `spell_enchant_proc_data_chk_1` CHECK ((`PPMChance` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Spell enchant proc data'
```

---

## spell_group

- 存储引擎: InnoDB
- 行数: 534
- 注释: Spell System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `spell_id` | `int` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `spell_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_group` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `spell_id` int NOT NULL,
  PRIMARY KEY (`id`,`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Spell System'
```

---

## spell_group_stack_rules

- 存储引擎: InnoDB
- 行数: 69

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `group_id` | `int unsigned` | NO | PRI | 0 |  |
| `stack_rule` | `tinyint` | NO |  | 0 |  |
| `description` | `varchar(150)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `group_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_group_stack_rules` (
  `group_id` int unsigned NOT NULL DEFAULT '0',
  `stack_rule` tinyint NOT NULL DEFAULT '0',
  `description` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_jump_distance

- 存储引擎: InnoDB
- 行数: 2
- 注释: Per-spell chain jump distance override

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI |  |  |
| `JumpDistance` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_jump_distance` (
  `ID` int unsigned NOT NULL COMMENT 'spell id',
  `JumpDistance` float NOT NULL DEFAULT '0' COMMENT 'max hop distance in yards',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Per-spell chain jump distance override'
```

---

## spell_linked_spell

- 存储引擎: InnoDB
- 行数: 608
- 注释: Spell System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spell_trigger` | `int` | NO | PRI |  |  |
| `spell_effect` | `int` | NO | PRI | 0 |  |
| `type` | `tinyint unsigned` | NO | PRI | 0 |  |
| `comment` | `text` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| trigger_effect_type | `spell_trigger` | 是 | BTREE |
| trigger_effect_type | `spell_effect` | 是 | BTREE |
| trigger_effect_type | `type` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_linked_spell` (
  `spell_trigger` int NOT NULL,
  `spell_effect` int NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL DEFAULT '0',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `trigger_effect_type` (`spell_trigger`,`spell_effect`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Spell System'
```

---

## spell_loot_template

- 存储引擎: InnoDB
- 行数: 163
- 注释: Loot System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Entry` | `int unsigned` | NO | PRI | 0 |  |
| `Item` | `int unsigned` | NO | PRI | 0 |  |
| `Reference` | `int` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 100 |  |
| `QuestRequired` | `tinyint` | NO |  | 0 |  |
| `LootMode` | `smallint unsigned` | NO |  | 1 |  |
| `GroupId` | `tinyint unsigned` | NO |  | 0 |  |
| `MinCount` | `tinyint unsigned` | NO |  | 1 |  |
| `MaxCount` | `tinyint unsigned` | NO |  | 1 |  |
| `Comment` | `varchar(255)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Entry` | 是 | BTREE |
| PRIMARY | `Item` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_loot_template` (
  `Entry` int unsigned NOT NULL DEFAULT '0',
  `Item` int unsigned NOT NULL DEFAULT '0',
  `Reference` int NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '100',
  `QuestRequired` tinyint NOT NULL DEFAULT '0',
  `LootMode` smallint unsigned NOT NULL DEFAULT '1',
  `GroupId` tinyint unsigned NOT NULL DEFAULT '0',
  `MinCount` tinyint unsigned NOT NULL DEFAULT '1',
  `MaxCount` tinyint unsigned NOT NULL DEFAULT '1',
  `Comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Loot System'
```

---

## spell_mixology

- 存储引擎: InnoDB
- 行数: 21

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI |  |  |
| `pctMod` | `float` | NO |  | 30 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_mixology` (
  `entry` int unsigned NOT NULL,
  `pctMod` float NOT NULL DEFAULT '30' COMMENT 'bonus multiplier',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_pet_auras

- 存储引擎: InnoDB
- 行数: 49

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spell` | `int unsigned` | NO | PRI |  |  |
| `effectId` | `tinyint unsigned` | NO | PRI | 0 |  |
| `pet` | `int unsigned` | NO | PRI | 0 |  |
| `aura` | `int unsigned` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `spell` | 是 | BTREE |
| PRIMARY | `effectId` | 是 | BTREE |
| PRIMARY | `pet` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_pet_auras` (
  `spell` int unsigned NOT NULL COMMENT 'dummy spell id',
  `effectId` tinyint unsigned NOT NULL DEFAULT '0',
  `pet` int unsigned NOT NULL DEFAULT '0' COMMENT 'pet id; 0 = all',
  `aura` int unsigned NOT NULL COMMENT 'pet aura id',
  PRIMARY KEY (`spell`,`effectId`,`pet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_proc

- 存储引擎: InnoDB
- 行数: 890

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `SpellId` | `int` | NO | PRI | 0 |  |
| `SchoolMask` | `tinyint unsigned` | NO |  | 0 |  |
| `SpellFamilyName` | `smallint unsigned` | NO |  | 0 |  |
| `SpellFamilyMask0` | `int unsigned` | NO |  | 0 |  |
| `SpellFamilyMask1` | `int unsigned` | NO |  | 0 |  |
| `SpellFamilyMask2` | `int unsigned` | NO |  | 0 |  |
| `ProcFlags` | `int unsigned` | NO |  | 0 |  |
| `SpellTypeMask` | `int unsigned` | NO |  | 0 |  |
| `SpellPhaseMask` | `int unsigned` | NO |  | 0 |  |
| `HitMask` | `int unsigned` | NO |  | 0 |  |
| `AttributesMask` | `int unsigned` | NO |  | 0 |  |
| `DisableEffectsMask` | `int unsigned` | NO |  | 0 |  |
| `ProcsPerMinute` | `float` | NO |  | 0 |  |
| `Chance` | `float` | NO |  | 0 |  |
| `Cooldown` | `int unsigned` | NO |  | 0 |  |
| `Charges` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `SpellId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_proc` (
  `SpellId` int NOT NULL DEFAULT '0',
  `SchoolMask` tinyint unsigned NOT NULL DEFAULT '0',
  `SpellFamilyName` smallint unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask0` int unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask1` int unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask2` int unsigned NOT NULL DEFAULT '0',
  `ProcFlags` int unsigned NOT NULL DEFAULT '0',
  `SpellTypeMask` int unsigned NOT NULL DEFAULT '0',
  `SpellPhaseMask` int unsigned NOT NULL DEFAULT '0',
  `HitMask` int unsigned NOT NULL DEFAULT '0',
  `AttributesMask` int unsigned NOT NULL DEFAULT '0',
  `DisableEffectsMask` int unsigned NOT NULL DEFAULT '0',
  `ProcsPerMinute` float NOT NULL DEFAULT '0',
  `Chance` float NOT NULL DEFAULT '0',
  `Cooldown` int unsigned NOT NULL DEFAULT '0',
  `Charges` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`SpellId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_proc_event

- 存储引擎: InnoDB
- 行数: 840

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int` | NO | PRI | 0 |  |
| `SchoolMask` | `tinyint` | NO |  | 0 |  |
| `SpellFamilyName` | `smallint unsigned` | NO |  | 0 |  |
| `SpellFamilyMask0` | `int unsigned` | NO |  | 0 |  |
| `SpellFamilyMask1` | `int unsigned` | NO |  | 0 |  |
| `SpellFamilyMask2` | `int unsigned` | NO |  | 0 |  |
| `procFlags` | `int unsigned` | NO |  | 0 |  |
| `procEx` | `int unsigned` | NO |  | 0 |  |
| `procPhase` | `int unsigned` | NO |  | 0 |  |
| `ppmRate` | `float` | NO |  | 0 |  |
| `CustomChance` | `float` | NO |  | 0 |  |
| `Cooldown` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_proc_event` (
  `entry` int NOT NULL DEFAULT '0',
  `SchoolMask` tinyint NOT NULL DEFAULT '0',
  `SpellFamilyName` smallint unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask0` int unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask1` int unsigned NOT NULL DEFAULT '0',
  `SpellFamilyMask2` int unsigned NOT NULL DEFAULT '0',
  `procFlags` int unsigned NOT NULL DEFAULT '0',
  `procEx` int unsigned NOT NULL DEFAULT '0',
  `procPhase` int unsigned NOT NULL DEFAULT '0',
  `ppmRate` float NOT NULL DEFAULT '0',
  `CustomChance` float NOT NULL DEFAULT '0',
  `Cooldown` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_ranks

- 存储引擎: InnoDB
- 行数: 3502
- 注释: Spell Rank Data

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `first_spell_id` | `int unsigned` | NO | PRI | 0 |  |
| `spell_id` | `int unsigned` | NO | UNI | 0 |  |
| `rank` | `tinyint unsigned` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `first_spell_id` | 是 | BTREE |
| PRIMARY | `rank` | 是 | BTREE |
| spell_id | `spell_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_ranks` (
  `first_spell_id` int unsigned NOT NULL DEFAULT '0',
  `spell_id` int unsigned NOT NULL DEFAULT '0',
  `rank` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`first_spell_id`,`rank`),
  UNIQUE KEY `spell_id` (`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Spell Rank Data'
```

---

## spell_required

- 存储引擎: InnoDB
- 行数: 50
- 注释: Spell Additinal Data

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spell_id` | `int` | NO | PRI | 0 |  |
| `req_spell` | `int` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `spell_id` | 是 | BTREE |
| PRIMARY | `req_spell` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_required` (
  `spell_id` int NOT NULL DEFAULT '0',
  `req_spell` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`spell_id`,`req_spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Spell Additinal Data'
```

---

## spell_script_names

- 存储引擎: InnoDB
- 行数: 2698

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `spell_id` | `int` | NO | PRI |  |  |
| `ScriptName` | `char(64)` | NO | PRI |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| spell_id | `spell_id` | 是 | BTREE |
| spell_id | `ScriptName` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_script_names` (
  `spell_id` int NOT NULL,
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `spell_id` (`spell_id`,`ScriptName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_scripts

- 存储引擎: InnoDB
- 行数: 130

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO |  | 0 |  |
| `effIndex` | `tinyint unsigned` | NO |  | 0 |  |
| `delay` | `int unsigned` | NO |  | 0 |  |
| `command` | `int unsigned` | NO |  | 0 |  |
| `datalong` | `int unsigned` | NO |  | 0 |  |
| `datalong2` | `int unsigned` | NO |  | 0 |  |
| `dataint` | `int` | NO |  | 0 |  |
| `x` | `float` | NO |  | 0 |  |
| `y` | `float` | NO |  | 0 |  |
| `z` | `float` | NO |  | 0 |  |
| `o` | `float` | NO |  | 0 |  |

### CREATE TABLE

```sql
CREATE TABLE `spell_scripts` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `effIndex` tinyint unsigned NOT NULL DEFAULT '0',
  `delay` int unsigned NOT NULL DEFAULT '0',
  `command` int unsigned NOT NULL DEFAULT '0',
  `datalong` int unsigned NOT NULL DEFAULT '0',
  `datalong2` int unsigned NOT NULL DEFAULT '0',
  `dataint` int NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spell_target_position

- 存储引擎: InnoDB
- 行数: 684
- 注释: Spell System

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int unsigned` | NO | PRI | 0 |  |
| `EffectIndex` | `tinyint unsigned` | NO | PRI | 0 |  |
| `MapID` | `smallint unsigned` | NO |  | 0 |  |
| `PositionX` | `float` | NO |  | 0 |  |
| `PositionY` | `float` | NO |  | 0 |  |
| `PositionZ` | `float` | NO |  | 0 |  |
| `Orientation` | `float` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |
| PRIMARY | `EffectIndex` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_target_position` (
  `ID` int unsigned NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `EffectIndex` tinyint unsigned NOT NULL DEFAULT '0',
  `MapID` smallint unsigned NOT NULL DEFAULT '0',
  `PositionX` float NOT NULL DEFAULT '0',
  `PositionY` float NOT NULL DEFAULT '0',
  `PositionZ` float NOT NULL DEFAULT '0',
  `Orientation` float NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`ID`,`EffectIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Spell System'
```

---

## spell_threat

- 存储引擎: InnoDB
- 行数: 106

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI |  |  |
| `flatMod` | `int` | YES |  |  |  |
| `pctMod` | `float` | NO |  | 1 |  |
| `apPctMod` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spell_threat` (
  `entry` int unsigned NOT NULL,
  `flatMod` int DEFAULT NULL,
  `pctMod` float NOT NULL DEFAULT '1' COMMENT 'threat multiplier for damage/healing',
  `apPctMod` float NOT NULL DEFAULT '0' COMMENT 'additional threat bonus from attack power',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellcasttimes_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Base` | `int` | NO |  | 0 |  |
| `PerLevel` | `int` | NO |  | 0 |  |
| `Minimum` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellcasttimes_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Base` int NOT NULL DEFAULT '0',
  `PerLevel` int NOT NULL DEFAULT '0',
  `Minimum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellcategory_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellcategory_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spelldifficulty_dbc

- 存储引擎: InnoDB
- 行数: 599

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `DifficultySpellID_1` | `int` | NO |  | 0 |  |
| `DifficultySpellID_2` | `int` | NO |  | 0 |  |
| `DifficultySpellID_3` | `int` | NO |  | 0 |  |
| `DifficultySpellID_4` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spelldifficulty_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `DifficultySpellID_1` int NOT NULL DEFAULT '0',
  `DifficultySpellID_2` int NOT NULL DEFAULT '0',
  `DifficultySpellID_3` int NOT NULL DEFAULT '0',
  `DifficultySpellID_4` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellduration_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Duration` | `int` | NO |  | 0 |  |
| `DurationPerLevel` | `int` | NO |  | 0 |  |
| `MaxDuration` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellduration_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Duration` int NOT NULL DEFAULT '0',
  `DurationPerLevel` int NOT NULL DEFAULT '0',
  `MaxDuration` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellfocusobject_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellfocusobject_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellitemenchantment_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Charges` | `int` | NO |  | 0 |  |
| `Effect_1` | `int` | NO |  | 0 |  |
| `Effect_2` | `int` | NO |  | 0 |  |
| `Effect_3` | `int` | NO |  | 0 |  |
| `EffectPointsMin_1` | `int` | NO |  | 0 |  |
| `EffectPointsMin_2` | `int` | NO |  | 0 |  |
| `EffectPointsMin_3` | `int` | NO |  | 0 |  |
| `EffectPointsMax_1` | `int` | NO |  | 0 |  |
| `EffectPointsMax_2` | `int` | NO |  | 0 |  |
| `EffectPointsMax_3` | `int` | NO |  | 0 |  |
| `EffectArg_1` | `int` | NO |  | 0 |  |
| `EffectArg_2` | `int` | NO |  | 0 |  |
| `EffectArg_3` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `ItemVisual` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `Src_ItemID` | `int` | NO |  | 0 |  |
| `Condition_Id` | `int` | NO |  | 0 |  |
| `RequiredSkillID` | `int` | NO |  | 0 |  |
| `RequiredSkillRank` | `int` | NO |  | 0 |  |
| `MinLevel` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellitemenchantment_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Charges` int NOT NULL DEFAULT '0',
  `Effect_1` int NOT NULL DEFAULT '0',
  `Effect_2` int NOT NULL DEFAULT '0',
  `Effect_3` int NOT NULL DEFAULT '0',
  `EffectPointsMin_1` int NOT NULL DEFAULT '0',
  `EffectPointsMin_2` int NOT NULL DEFAULT '0',
  `EffectPointsMin_3` int NOT NULL DEFAULT '0',
  `EffectPointsMax_1` int NOT NULL DEFAULT '0',
  `EffectPointsMax_2` int NOT NULL DEFAULT '0',
  `EffectPointsMax_3` int NOT NULL DEFAULT '0',
  `EffectArg_1` int NOT NULL DEFAULT '0',
  `EffectArg_2` int NOT NULL DEFAULT '0',
  `EffectArg_3` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `ItemVisual` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `Src_ItemID` int NOT NULL DEFAULT '0',
  `Condition_Id` int NOT NULL DEFAULT '0',
  `RequiredSkillID` int NOT NULL DEFAULT '0',
  `RequiredSkillRank` int NOT NULL DEFAULT '0',
  `MinLevel` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellitemenchantmentcondition_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Lt_OperandType_1` | `tinyint unsigned` | NO |  | 0 |  |
| `Lt_OperandType_2` | `tinyint unsigned` | NO |  | 0 |  |
| `Lt_OperandType_3` | `tinyint unsigned` | NO |  | 0 |  |
| `Lt_OperandType_4` | `tinyint unsigned` | NO |  | 0 |  |
| `Lt_OperandType_5` | `tinyint unsigned` | NO |  | 0 |  |
| `Lt_Operand_1` | `int` | NO |  | 0 |  |
| `Lt_Operand_2` | `int` | NO |  | 0 |  |
| `Lt_Operand_3` | `int` | NO |  | 0 |  |
| `Lt_Operand_4` | `int` | NO |  | 0 |  |
| `Lt_Operand_5` | `int` | NO |  | 0 |  |
| `Operator_1` | `tinyint unsigned` | NO |  | 0 |  |
| `Operator_2` | `tinyint unsigned` | NO |  | 0 |  |
| `Operator_3` | `tinyint unsigned` | NO |  | 0 |  |
| `Operator_4` | `tinyint unsigned` | NO |  | 0 |  |
| `Operator_5` | `tinyint unsigned` | NO |  | 0 |  |
| `Rt_OperandType_1` | `tinyint unsigned` | NO |  | 0 |  |
| `Rt_OperandType_2` | `tinyint unsigned` | NO |  | 0 |  |
| `Rt_OperandType_3` | `tinyint unsigned` | NO |  | 0 |  |
| `Rt_OperandType_4` | `tinyint unsigned` | NO |  | 0 |  |
| `Rt_OperandType_5` | `tinyint unsigned` | NO |  | 0 |  |
| `Rt_Operand_1` | `int` | NO |  | 0 |  |
| `Rt_Operand_2` | `int` | NO |  | 0 |  |
| `Rt_Operand_3` | `int` | NO |  | 0 |  |
| `Rt_Operand_4` | `int` | NO |  | 0 |  |
| `Rt_Operand_5` | `int` | NO |  | 0 |  |
| `Logic_1` | `tinyint unsigned` | NO |  | 0 |  |
| `Logic_2` | `tinyint unsigned` | NO |  | 0 |  |
| `Logic_3` | `tinyint unsigned` | NO |  | 0 |  |
| `Logic_4` | `tinyint unsigned` | NO |  | 0 |  |
| `Logic_5` | `tinyint unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellitemenchantmentcondition_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Lt_OperandType_1` tinyint unsigned NOT NULL DEFAULT '0',
  `Lt_OperandType_2` tinyint unsigned NOT NULL DEFAULT '0',
  `Lt_OperandType_3` tinyint unsigned NOT NULL DEFAULT '0',
  `Lt_OperandType_4` tinyint unsigned NOT NULL DEFAULT '0',
  `Lt_OperandType_5` tinyint unsigned NOT NULL DEFAULT '0',
  `Lt_Operand_1` int NOT NULL DEFAULT '0',
  `Lt_Operand_2` int NOT NULL DEFAULT '0',
  `Lt_Operand_3` int NOT NULL DEFAULT '0',
  `Lt_Operand_4` int NOT NULL DEFAULT '0',
  `Lt_Operand_5` int NOT NULL DEFAULT '0',
  `Operator_1` tinyint unsigned NOT NULL DEFAULT '0',
  `Operator_2` tinyint unsigned NOT NULL DEFAULT '0',
  `Operator_3` tinyint unsigned NOT NULL DEFAULT '0',
  `Operator_4` tinyint unsigned NOT NULL DEFAULT '0',
  `Operator_5` tinyint unsigned NOT NULL DEFAULT '0',
  `Rt_OperandType_1` tinyint unsigned NOT NULL DEFAULT '0',
  `Rt_OperandType_2` tinyint unsigned NOT NULL DEFAULT '0',
  `Rt_OperandType_3` tinyint unsigned NOT NULL DEFAULT '0',
  `Rt_OperandType_4` tinyint unsigned NOT NULL DEFAULT '0',
  `Rt_OperandType_5` tinyint unsigned NOT NULL DEFAULT '0',
  `Rt_Operand_1` int NOT NULL DEFAULT '0',
  `Rt_Operand_2` int NOT NULL DEFAULT '0',
  `Rt_Operand_3` int NOT NULL DEFAULT '0',
  `Rt_Operand_4` int NOT NULL DEFAULT '0',
  `Rt_Operand_5` int NOT NULL DEFAULT '0',
  `Logic_1` tinyint unsigned NOT NULL DEFAULT '0',
  `Logic_2` tinyint unsigned NOT NULL DEFAULT '0',
  `Logic_3` tinyint unsigned NOT NULL DEFAULT '0',
  `Logic_4` tinyint unsigned NOT NULL DEFAULT '0',
  `Logic_5` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellradius_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Radius` | `float` | NO |  | 0 |  |
| `RadiusPerLevel` | `float` | NO |  | 0 |  |
| `RadiusMax` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellradius_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Radius` float NOT NULL DEFAULT '0',
  `RadiusPerLevel` float NOT NULL DEFAULT '0',
  `RadiusMax` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellrange_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `RangeMin_1` | `float` | NO |  | 0 |  |
| `RangeMin_2` | `float` | NO |  | 0 |  |
| `RangeMax_1` | `float` | NO |  | 0 |  |
| `RangeMax_2` | `float` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `DisplayName_Lang_enUS` | `text` | YES |  |  |  |
| `DisplayName_Lang_enGB` | `text` | YES |  |  |  |
| `DisplayName_Lang_koKR` | `text` | YES |  |  |  |
| `DisplayName_Lang_frFR` | `text` | YES |  |  |  |
| `DisplayName_Lang_deDE` | `text` | YES |  |  |  |
| `DisplayName_Lang_enCN` | `text` | YES |  |  |  |
| `DisplayName_Lang_zhCN` | `text` | YES |  |  |  |
| `DisplayName_Lang_enTW` | `text` | YES |  |  |  |
| `DisplayName_Lang_zhTW` | `text` | YES |  |  |  |
| `DisplayName_Lang_esES` | `text` | YES |  |  |  |
| `DisplayName_Lang_esMX` | `text` | YES |  |  |  |
| `DisplayName_Lang_ruRU` | `text` | YES |  |  |  |
| `DisplayName_Lang_ptPT` | `text` | YES |  |  |  |
| `DisplayName_Lang_ptBR` | `text` | YES |  |  |  |
| `DisplayName_Lang_itIT` | `text` | YES |  |  |  |
| `DisplayName_Lang_Unk` | `text` | YES |  |  |  |
| `DisplayName_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `DisplayNameShort_Lang_enUS` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_enGB` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_koKR` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_frFR` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_deDE` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_enCN` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_zhCN` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_enTW` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_zhTW` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_esES` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_esMX` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_ruRU` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_ptPT` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_ptBR` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_itIT` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_Unk` | `text` | YES |  |  |  |
| `DisplayNameShort_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellrange_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `RangeMin_1` float NOT NULL DEFAULT '0',
  `RangeMin_2` float NOT NULL DEFAULT '0',
  `RangeMax_1` float NOT NULL DEFAULT '0',
  `RangeMax_2` float NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `DisplayName_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_Unk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `DisplayNameShort_Lang_enUS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_enGB` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_koKR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_frFR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_deDE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_enCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_zhCN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_enTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_zhTW` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_esES` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_esMX` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_ruRU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_ptPT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_ptBR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_itIT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_Unk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `DisplayNameShort_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellrunecost_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Blood` | `int` | NO |  | 0 |  |
| `Unholy` | `int` | NO |  | 0 |  |
| `Frost` | `int` | NO |  | 0 |  |
| `RunicPower` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellrunecost_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Blood` int NOT NULL DEFAULT '0',
  `Unholy` int NOT NULL DEFAULT '0',
  `Frost` int NOT NULL DEFAULT '0',
  `RunicPower` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellshapeshiftform_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `BonusActionBar` | `int` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `CreatureType` | `int` | NO |  | 0 |  |
| `AttackIconID` | `int` | NO |  | 0 |  |
| `CombatRoundTime` | `int` | NO |  | 0 |  |
| `CreatureDisplayID_1` | `int` | NO |  | 0 |  |
| `CreatureDisplayID_2` | `int` | NO |  | 0 |  |
| `CreatureDisplayID_3` | `int` | NO |  | 0 |  |
| `CreatureDisplayID_4` | `int` | NO |  | 0 |  |
| `PresetSpellID_1` | `int` | NO |  | 0 |  |
| `PresetSpellID_2` | `int` | NO |  | 0 |  |
| `PresetSpellID_3` | `int` | NO |  | 0 |  |
| `PresetSpellID_4` | `int` | NO |  | 0 |  |
| `PresetSpellID_5` | `int` | NO |  | 0 |  |
| `PresetSpellID_6` | `int` | NO |  | 0 |  |
| `PresetSpellID_7` | `int` | NO |  | 0 |  |
| `PresetSpellID_8` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellshapeshiftform_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `BonusActionBar` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `CreatureType` int NOT NULL DEFAULT '0',
  `AttackIconID` int NOT NULL DEFAULT '0',
  `CombatRoundTime` int NOT NULL DEFAULT '0',
  `CreatureDisplayID_1` int NOT NULL DEFAULT '0',
  `CreatureDisplayID_2` int NOT NULL DEFAULT '0',
  `CreatureDisplayID_3` int NOT NULL DEFAULT '0',
  `CreatureDisplayID_4` int NOT NULL DEFAULT '0',
  `PresetSpellID_1` int NOT NULL DEFAULT '0',
  `PresetSpellID_2` int NOT NULL DEFAULT '0',
  `PresetSpellID_3` int NOT NULL DEFAULT '0',
  `PresetSpellID_4` int NOT NULL DEFAULT '0',
  `PresetSpellID_5` int NOT NULL DEFAULT '0',
  `PresetSpellID_6` int NOT NULL DEFAULT '0',
  `PresetSpellID_7` int NOT NULL DEFAULT '0',
  `PresetSpellID_8` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## spellvisual_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `PrecastKit` | `int` | NO |  | 0 |  |
| `CastKit` | `int` | NO |  | 0 |  |
| `ImpactKit` | `int` | NO |  | 0 |  |
| `StateKit` | `int` | NO |  | 0 |  |
| `StateDoneKit` | `int` | NO |  | 0 |  |
| `ChannelKit` | `int` | NO |  | 0 |  |
| `HasMissile` | `int` | NO |  | 0 |  |
| `MissileModel` | `int` | NO |  | 0 |  |
| `MissilePathType` | `int` | NO |  | 0 |  |
| `MissileDestinationAttachment` | `int` | NO |  | 0 |  |
| `MissileSound` | `int` | NO |  | 0 |  |
| `AnimEventSoundID` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `CasterImpactKit` | `int` | NO |  | 0 |  |
| `TargetImpactKit` | `int` | NO |  | 0 |  |
| `MissileAttachment` | `int` | NO |  | 0 |  |
| `MissileFollowGroundHeight` | `int` | NO |  | 0 |  |
| `MissileFollowGroundDropSpeed` | `int` | NO |  | 0 |  |
| `MissileFollowGroundApproach` | `int` | NO |  | 0 |  |
| `MissileFollowGroundFlags` | `int` | NO |  | 0 |  |
| `MissileMotion` | `int` | NO |  | 0 |  |
| `MissileTargetingKit` | `int` | NO |  | 0 |  |
| `InstantAreaKit` | `int` | NO |  | 0 |  |
| `ImpactAreaKit` | `int` | NO |  | 0 |  |
| `PersistentAreaKit` | `int` | NO |  | 0 |  |
| `MissileCastOffsetX` | `float` | NO |  | 0 |  |
| `MissileCastOffsetY` | `float` | NO |  | 0 |  |
| `MissileCastOffsetZ` | `float` | NO |  | 0 |  |
| `MissileImpactOffsetX` | `float` | NO |  | 0 |  |
| `MissileImpactOffsetY` | `float` | NO |  | 0 |  |
| `MissileImpactOffsetZ` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `spellvisual_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `PrecastKit` int NOT NULL DEFAULT '0',
  `CastKit` int NOT NULL DEFAULT '0',
  `ImpactKit` int NOT NULL DEFAULT '0',
  `StateKit` int NOT NULL DEFAULT '0',
  `StateDoneKit` int NOT NULL DEFAULT '0',
  `ChannelKit` int NOT NULL DEFAULT '0',
  `HasMissile` int NOT NULL DEFAULT '0',
  `MissileModel` int NOT NULL DEFAULT '0',
  `MissilePathType` int NOT NULL DEFAULT '0',
  `MissileDestinationAttachment` int NOT NULL DEFAULT '0',
  `MissileSound` int NOT NULL DEFAULT '0',
  `AnimEventSoundID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `CasterImpactKit` int NOT NULL DEFAULT '0',
  `TargetImpactKit` int NOT NULL DEFAULT '0',
  `MissileAttachment` int NOT NULL DEFAULT '0',
  `MissileFollowGroundHeight` int NOT NULL DEFAULT '0',
  `MissileFollowGroundDropSpeed` int NOT NULL DEFAULT '0',
  `MissileFollowGroundApproach` int NOT NULL DEFAULT '0',
  `MissileFollowGroundFlags` int NOT NULL DEFAULT '0',
  `MissileMotion` int NOT NULL DEFAULT '0',
  `MissileTargetingKit` int NOT NULL DEFAULT '0',
  `InstantAreaKit` int NOT NULL DEFAULT '0',
  `ImpactAreaKit` int NOT NULL DEFAULT '0',
  `PersistentAreaKit` int NOT NULL DEFAULT '0',
  `MissileCastOffsetX` float NOT NULL DEFAULT '0',
  `MissileCastOffsetY` float NOT NULL DEFAULT '0',
  `MissileCastOffsetZ` float NOT NULL DEFAULT '0',
  `MissileImpactOffsetX` float NOT NULL DEFAULT '0',
  `MissileImpactOffsetY` float NOT NULL DEFAULT '0',
  `MissileImpactOffsetZ` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## stableslotprices_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Cost` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `stableslotprices_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Cost` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## summonproperties_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Control` | `int` | NO |  | 0 |  |
| `Faction` | `int` | NO |  | 0 |  |
| `Title` | `int` | NO |  | 0 |  |
| `Slot` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `summonproperties_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Control` int NOT NULL DEFAULT '0',
  `Faction` int NOT NULL DEFAULT '0',
  `Title` int NOT NULL DEFAULT '0',
  `Slot` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## talent_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `TabID` | `int` | NO |  | 0 |  |
| `TierID` | `int` | NO |  | 0 |  |
| `ColumnIndex` | `int` | NO |  | 0 |  |
| `SpellRank_1` | `int` | NO |  | 0 |  |
| `SpellRank_2` | `int` | NO |  | 0 |  |
| `SpellRank_3` | `int` | NO |  | 0 |  |
| `SpellRank_4` | `int` | NO |  | 0 |  |
| `SpellRank_5` | `int` | NO |  | 0 |  |
| `SpellRank_6` | `int` | NO |  | 0 |  |
| `SpellRank_7` | `int` | NO |  | 0 |  |
| `SpellRank_8` | `int` | NO |  | 0 |  |
| `SpellRank_9` | `int` | NO |  | 0 |  |
| `PrereqTalent_1` | `int` | NO |  | 0 |  |
| `PrereqTalent_2` | `int` | NO |  | 0 |  |
| `PrereqTalent_3` | `int` | NO |  | 0 |  |
| `PrereqRank_1` | `int` | NO |  | 0 |  |
| `PrereqRank_2` | `int` | NO |  | 0 |  |
| `PrereqRank_3` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `RequiredSpellID` | `int` | NO |  | 0 |  |
| `CategoryMask_1` | `int` | NO |  | 0 |  |
| `CategoryMask_2` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `talent_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `TabID` int NOT NULL DEFAULT '0',
  `TierID` int NOT NULL DEFAULT '0',
  `ColumnIndex` int NOT NULL DEFAULT '0',
  `SpellRank_1` int NOT NULL DEFAULT '0',
  `SpellRank_2` int NOT NULL DEFAULT '0',
  `SpellRank_3` int NOT NULL DEFAULT '0',
  `SpellRank_4` int NOT NULL DEFAULT '0',
  `SpellRank_5` int NOT NULL DEFAULT '0',
  `SpellRank_6` int NOT NULL DEFAULT '0',
  `SpellRank_7` int NOT NULL DEFAULT '0',
  `SpellRank_8` int NOT NULL DEFAULT '0',
  `SpellRank_9` int NOT NULL DEFAULT '0',
  `PrereqTalent_1` int NOT NULL DEFAULT '0',
  `PrereqTalent_2` int NOT NULL DEFAULT '0',
  `PrereqTalent_3` int NOT NULL DEFAULT '0',
  `PrereqRank_1` int NOT NULL DEFAULT '0',
  `PrereqRank_2` int NOT NULL DEFAULT '0',
  `PrereqRank_3` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `RequiredSpellID` int NOT NULL DEFAULT '0',
  `CategoryMask_1` int NOT NULL DEFAULT '0',
  `CategoryMask_2` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## talenttab_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `SpellIconID` | `int` | NO |  | 0 |  |
| `RaceMask` | `int` | NO |  | 0 |  |
| `ClassMask` | `int` | NO |  | 0 |  |
| `PetTalentMask` | `int` | NO |  | 0 |  |
| `OrderIndex` | `int` | NO |  | 0 |  |
| `BackgroundFile` | `varchar(100)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `talenttab_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `SpellIconID` int NOT NULL DEFAULT '0',
  `RaceMask` int NOT NULL DEFAULT '0',
  `ClassMask` int NOT NULL DEFAULT '0',
  `PetTalentMask` int NOT NULL DEFAULT '0',
  `OrderIndex` int NOT NULL DEFAULT '0',
  `BackgroundFile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## taxinodes_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `ContinentID` | `int` | NO |  | 0 |  |
| `X` | `float` | NO |  | 0 |  |
| `Y` | `float` | NO |  | 0 |  |
| `Z` | `float` | NO |  | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `MountCreatureID_1` | `int` | NO |  | 0 |  |
| `MountCreatureID_2` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `taxinodes_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `ContinentID` int NOT NULL DEFAULT '0',
  `X` float NOT NULL DEFAULT '0',
  `Y` float NOT NULL DEFAULT '0',
  `Z` float NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `MountCreatureID_1` int NOT NULL DEFAULT '0',
  `MountCreatureID_2` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## taxipath_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `FromTaxiNode` | `int` | NO |  | 0 |  |
| `ToTaxiNode` | `int` | NO |  | 0 |  |
| `Cost` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `taxipath_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `FromTaxiNode` int NOT NULL DEFAULT '0',
  `ToTaxiNode` int NOT NULL DEFAULT '0',
  `Cost` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## taxipathnode_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `PathID` | `int` | NO |  | 0 |  |
| `NodeIndex` | `int` | NO |  | 0 |  |
| `ContinentID` | `int` | NO |  | 0 |  |
| `LocX` | `float` | NO |  | 0 |  |
| `LocY` | `float` | NO |  | 0 |  |
| `LocZ` | `float` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `Delay` | `int` | NO |  | 0 |  |
| `ArrivalEventID` | `int` | NO |  | 0 |  |
| `DepartureEventID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `taxipathnode_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `PathID` int NOT NULL DEFAULT '0',
  `NodeIndex` int NOT NULL DEFAULT '0',
  `ContinentID` int NOT NULL DEFAULT '0',
  `LocX` float NOT NULL DEFAULT '0',
  `LocY` float NOT NULL DEFAULT '0',
  `LocZ` float NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `Delay` int NOT NULL DEFAULT '0',
  `ArrivalEventID` int NOT NULL DEFAULT '0',
  `DepartureEventID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## teamcontributionpoints_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Data` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `teamcontributionpoints_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Data` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## totemcategory_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Name_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `Name_Lang_Mask` | `int unsigned` | NO |  | 0 |  |
| `TotemCategoryType` | `int` | NO |  | 0 |  |
| `TotemCategoryMask` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `totemcategory_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Name_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Name_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  `TotemCategoryType` int NOT NULL DEFAULT '0',
  `TotemCategoryMask` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## trainer

- 存储引擎: InnoDB
- 行数: 126

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Id` | `int unsigned` | NO | PRI | 0 |  |
| `Type` | `tinyint unsigned` | NO |  | 2 |  |
| `Requirement` | `mediumint unsigned` | NO |  | 0 |  |
| `Greeting` | `mediumtext` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `trainer` (
  `Id` int unsigned NOT NULL DEFAULT '0',
  `Type` tinyint unsigned NOT NULL DEFAULT '2',
  `Requirement` mediumint unsigned NOT NULL DEFAULT '0',
  `Greeting` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `VerifiedBuild` int DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
```

---

## trainer_locale

- 存储引擎: InnoDB
- 行数: 627

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `Id` | `int unsigned` | NO | PRI | 0 |  |
| `locale` | `varchar(4)` | NO | PRI |  |  |
| `Greeting_lang` | `mediumtext` | YES |  |  |  |
| `VerifiedBuild` | `int` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `Id` | 是 | BTREE |
| PRIMARY | `locale` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `trainer_locale` (
  `Id` int unsigned NOT NULL DEFAULT '0',
  `locale` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Greeting_lang` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `VerifiedBuild` int DEFAULT '0',
  PRIMARY KEY (`Id`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
```

---

## trainer_spell

- 存储引擎: InnoDB
- 行数: 6417

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `TrainerId` | `int unsigned` | NO | PRI | 0 |  |
| `SpellId` | `int unsigned` | NO | PRI | 0 |  |
| `MoneyCost` | `int unsigned` | NO |  | 0 |  |
| `ReqSkillLine` | `int unsigned` | NO |  | 0 |  |
| `ReqSkillRank` | `int unsigned` | NO |  | 0 |  |
| `ReqAbility1` | `int unsigned` | NO |  | 0 |  |
| `ReqAbility2` | `int unsigned` | NO |  | 0 |  |
| `ReqAbility3` | `int unsigned` | NO |  | 0 |  |
| `ReqLevel` | `tinyint unsigned` | NO |  | 0 |  |
| `VerifiedBuild` | `int` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `TrainerId` | 是 | BTREE |
| PRIMARY | `SpellId` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `trainer_spell` (
  `TrainerId` int unsigned NOT NULL DEFAULT '0',
  `SpellId` int unsigned NOT NULL DEFAULT '0',
  `MoneyCost` int unsigned NOT NULL DEFAULT '0',
  `ReqSkillLine` int unsigned NOT NULL DEFAULT '0',
  `ReqSkillRank` int unsigned NOT NULL DEFAULT '0',
  `ReqAbility1` int unsigned NOT NULL DEFAULT '0',
  `ReqAbility2` int unsigned NOT NULL DEFAULT '0',
  `ReqAbility3` int unsigned NOT NULL DEFAULT '0',
  `ReqLevel` tinyint unsigned NOT NULL DEFAULT '0',
  `VerifiedBuild` int DEFAULT '0',
  PRIMARY KEY (`TrainerId`,`SpellId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
```

---

## transportanimation_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `TransportID` | `int` | NO |  | 0 |  |
| `TimeIndex` | `int` | NO |  | 0 |  |
| `PosX` | `float` | NO |  | 0 |  |
| `PosY` | `float` | NO |  | 0 |  |
| `PosZ` | `float` | NO |  | 0 |  |
| `SequenceID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `transportanimation_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `TransportID` int NOT NULL DEFAULT '0',
  `TimeIndex` int NOT NULL DEFAULT '0',
  `PosX` float NOT NULL DEFAULT '0',
  `PosY` float NOT NULL DEFAULT '0',
  `PosZ` float NOT NULL DEFAULT '0',
  `SequenceID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## transportrotation_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `GameObjectsID` | `int` | NO |  | 0 |  |
| `TimeIndex` | `int` | NO |  | 0 |  |
| `RotX` | `float` | NO |  | 0 |  |
| `RotY` | `float` | NO |  | 0 |  |
| `RotZ` | `float` | NO |  | 0 |  |
| `RotW` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `transportrotation_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `GameObjectsID` int NOT NULL DEFAULT '0',
  `TimeIndex` int NOT NULL DEFAULT '0',
  `RotX` float NOT NULL DEFAULT '0',
  `RotY` float NOT NULL DEFAULT '0',
  `RotZ` float NOT NULL DEFAULT '0',
  `RotW` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## transports

- 存储引擎: InnoDB
- 行数: 20
- 注释: Transports

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI |  | auto_increment |
| `entry` | `int unsigned` | NO | UNI | 0 |  |
| `name` | `text` | YES |  |  |  |
| `ScriptName` | `char(64)` | NO |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| idx_entry | `entry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `transports` (
  `guid` int unsigned NOT NULL AUTO_INCREMENT,
  `entry` int unsigned NOT NULL DEFAULT '0',
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ScriptName` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`),
  UNIQUE KEY `idx_entry` (`entry`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Transports'
```

---

## updates

- 存储引擎: InnoDB
- 行数: 2474
- 注释: List of all applied updates in this database.

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `name` | `varchar(200)` | NO | PRI |  |  |
| `hash` | `char(40)` | YES |  |  |  |
| `state` | `enum('RELEASED','CUSTOM','MODULE','ARCHIVED','PENDING')` | NO |  | RELEASED |  |
| `timestamp` | `timestamp` | NO |  | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
| `speed` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `name` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `updates` (
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'filename with extension of the update.',
  `hash` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'sha1 hash of the sql file.',
  `state` enum('RELEASED','CUSTOM','MODULE','ARCHIVED','PENDING') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if an update is released or archived.',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'timestamp when the query was applied.',
  `speed` int unsigned NOT NULL DEFAULT '0' COMMENT 'time the query takes to apply in ms.',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of all applied updates in this database.'
```

---

## updates_include

- 存储引擎: InnoDB
- 行数: 4
- 注释: List of directories where we want to include sql updates.

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `path` | `varchar(200)` | NO | PRI |  |  |
| `state` | `enum('RELEASED','ARCHIVED','CUSTOM','PENDING')` | NO |  | RELEASED |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `path` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `updates_include` (
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'directory to include. $ means relative to the source directory.',
  `state` enum('RELEASED','ARCHIVED','CUSTOM','PENDING') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RELEASED' COMMENT 'defines if the directory contains released or archived updates.',
  PRIMARY KEY (`path`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of directories where we want to include sql updates.'
```

---

## vehicle_accessory

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `guid` | `int unsigned` | NO | PRI | 0 |  |
| `accessory_entry` | `int unsigned` | NO |  | 0 |  |
| `seat_id` | `tinyint` | NO | PRI | 0 |  |
| `minion` | `tinyint unsigned` | NO |  | 0 |  |
| `description` | `text` | NO |  |  |  |
| `summontype` | `tinyint unsigned` | NO |  | 6 |  |
| `summontimer` | `int unsigned` | NO |  | 30000 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |
| PRIMARY | `seat_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `vehicle_accessory` (
  `guid` int unsigned NOT NULL DEFAULT '0',
  `accessory_entry` int unsigned NOT NULL DEFAULT '0',
  `seat_id` tinyint NOT NULL DEFAULT '0',
  `minion` tinyint unsigned NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summontype` tinyint unsigned NOT NULL DEFAULT '6' COMMENT 'see enum TempSummonType',
  `summontimer` int unsigned NOT NULL DEFAULT '30000' COMMENT 'timer, only relevant for certain summontypes',
  PRIMARY KEY (`guid`,`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## vehicle_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `TurnSpeed` | `float` | NO |  | 0 |  |
| `PitchSpeed` | `float` | NO |  | 0 |  |
| `PitchMin` | `float` | NO |  | 0 |  |
| `PitchMax` | `float` | NO |  | 0 |  |
| `SeatID_1` | `int` | NO |  | 0 |  |
| `SeatID_2` | `int` | NO |  | 0 |  |
| `SeatID_3` | `int` | NO |  | 0 |  |
| `SeatID_4` | `int` | NO |  | 0 |  |
| `SeatID_5` | `int` | NO |  | 0 |  |
| `SeatID_6` | `int` | NO |  | 0 |  |
| `SeatID_7` | `int` | NO |  | 0 |  |
| `SeatID_8` | `int` | NO |  | 0 |  |
| `MouseLookOffsetPitch` | `float` | NO |  | 0 |  |
| `CameraFadeDistScalarMin` | `float` | NO |  | 0 |  |
| `CameraFadeDistScalarMax` | `float` | NO |  | 0 |  |
| `CameraPitchOffset` | `float` | NO |  | 0 |  |
| `FacingLimitRight` | `float` | NO |  | 0 |  |
| `FacingLimitLeft` | `float` | NO |  | 0 |  |
| `MsslTrgtTurnLingering` | `float` | NO |  | 0 |  |
| `MsslTrgtPitchLingering` | `float` | NO |  | 0 |  |
| `MsslTrgtMouseLingering` | `float` | NO |  | 0 |  |
| `MsslTrgtEndOpacity` | `float` | NO |  | 0 |  |
| `MsslTrgtArcSpeed` | `float` | NO |  | 0 |  |
| `MsslTrgtArcRepeat` | `float` | NO |  | 0 |  |
| `MsslTrgtArcWidth` | `float` | NO |  | 0 |  |
| `MsslTrgtImpactRadius_1` | `float` | NO |  | 0 |  |
| `MsslTrgtImpactRadius_2` | `float` | NO |  | 0 |  |
| `MsslTrgtArcTexture` | `varchar(100)` | YES |  |  |  |
| `MsslTrgtImpactTexture` | `varchar(100)` | YES |  |  |  |
| `MsslTrgtImpactModel_1` | `varchar(100)` | YES |  |  |  |
| `MsslTrgtImpactModel_2` | `varchar(100)` | YES |  |  |  |
| `CameraYawOffset` | `float` | NO |  | 0 |  |
| `UilocomotionType` | `int` | NO |  | 0 |  |
| `MsslTrgtImpactTexRadius` | `float` | NO |  | 0 |  |
| `VehicleUIIndicatorID` | `int` | NO |  | 0 |  |
| `PowerDisplayID_1` | `int` | NO |  | 0 |  |
| `PowerDisplayID_2` | `int` | NO |  | 0 |  |
| `PowerDisplayID_3` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `vehicle_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `TurnSpeed` float NOT NULL DEFAULT '0',
  `PitchSpeed` float NOT NULL DEFAULT '0',
  `PitchMin` float NOT NULL DEFAULT '0',
  `PitchMax` float NOT NULL DEFAULT '0',
  `SeatID_1` int NOT NULL DEFAULT '0',
  `SeatID_2` int NOT NULL DEFAULT '0',
  `SeatID_3` int NOT NULL DEFAULT '0',
  `SeatID_4` int NOT NULL DEFAULT '0',
  `SeatID_5` int NOT NULL DEFAULT '0',
  `SeatID_6` int NOT NULL DEFAULT '0',
  `SeatID_7` int NOT NULL DEFAULT '0',
  `SeatID_8` int NOT NULL DEFAULT '0',
  `MouseLookOffsetPitch` float NOT NULL DEFAULT '0',
  `CameraFadeDistScalarMin` float NOT NULL DEFAULT '0',
  `CameraFadeDistScalarMax` float NOT NULL DEFAULT '0',
  `CameraPitchOffset` float NOT NULL DEFAULT '0',
  `FacingLimitRight` float NOT NULL DEFAULT '0',
  `FacingLimitLeft` float NOT NULL DEFAULT '0',
  `MsslTrgtTurnLingering` float NOT NULL DEFAULT '0',
  `MsslTrgtPitchLingering` float NOT NULL DEFAULT '0',
  `MsslTrgtMouseLingering` float NOT NULL DEFAULT '0',
  `MsslTrgtEndOpacity` float NOT NULL DEFAULT '0',
  `MsslTrgtArcSpeed` float NOT NULL DEFAULT '0',
  `MsslTrgtArcRepeat` float NOT NULL DEFAULT '0',
  `MsslTrgtArcWidth` float NOT NULL DEFAULT '0',
  `MsslTrgtImpactRadius_1` float NOT NULL DEFAULT '0',
  `MsslTrgtImpactRadius_2` float NOT NULL DEFAULT '0',
  `MsslTrgtArcTexture` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MsslTrgtImpactTexture` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MsslTrgtImpactModel_1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MsslTrgtImpactModel_2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CameraYawOffset` float NOT NULL DEFAULT '0',
  `UilocomotionType` int NOT NULL DEFAULT '0',
  `MsslTrgtImpactTexRadius` float NOT NULL DEFAULT '0',
  `VehicleUIIndicatorID` int NOT NULL DEFAULT '0',
  `PowerDisplayID_1` int NOT NULL DEFAULT '0',
  `PowerDisplayID_2` int NOT NULL DEFAULT '0',
  `PowerDisplayID_3` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## vehicle_seat_addon

- 存储引擎: InnoDB
- 行数: 32

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `SeatEntry` | `int unsigned` | NO | PRI |  |  |
| `SeatOrientation` | `float` | YES |  | 0 |  |
| `ExitParamX` | `float` | YES |  | 0 |  |
| `ExitParamY` | `float` | YES |  | 0 |  |
| `ExitParamZ` | `float` | YES |  | 0 |  |
| `ExitParamO` | `float` | YES |  | 0 |  |
| `ExitParamValue` | `tinyint(1)` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `SeatEntry` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `vehicle_seat_addon` (
  `SeatEntry` int unsigned NOT NULL COMMENT 'VehicleSeatEntry.dbc identifier',
  `SeatOrientation` float DEFAULT '0' COMMENT 'Seat Orientation override value',
  `ExitParamX` float DEFAULT '0',
  `ExitParamY` float DEFAULT '0',
  `ExitParamZ` float DEFAULT '0',
  `ExitParamO` float DEFAULT '0',
  `ExitParamValue` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`SeatEntry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
```

---

## vehicle_template_accessory

- 存储引擎: InnoDB
- 行数: 196

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `accessory_entry` | `int unsigned` | NO |  | 0 |  |
| `seat_id` | `tinyint` | NO | PRI | 0 |  |
| `minion` | `tinyint unsigned` | NO |  | 0 |  |
| `description` | `text` | NO |  |  |  |
| `summontype` | `tinyint unsigned` | NO |  | 6 |  |
| `summontimer` | `int unsigned` | NO |  | 30000 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| PRIMARY | `seat_id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `vehicle_template_accessory` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `accessory_entry` int unsigned NOT NULL DEFAULT '0',
  `seat_id` tinyint NOT NULL DEFAULT '0',
  `minion` tinyint unsigned NOT NULL DEFAULT '0',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summontype` tinyint unsigned NOT NULL DEFAULT '6' COMMENT 'see enum TempSummonType',
  `summontimer` int unsigned NOT NULL DEFAULT '30000' COMMENT 'timer, only relevant for certain summontypes',
  PRIMARY KEY (`entry`,`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## vehicleseat_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `AttachmentID` | `int` | NO |  | 0 |  |
| `AttachmentOffsetX` | `float` | NO |  | 0 |  |
| `AttachmentOffsetY` | `float` | NO |  | 0 |  |
| `AttachmentOffsetZ` | `float` | NO |  | 0 |  |
| `EnterPreDelay` | `float` | NO |  | 0 |  |
| `EnterSpeed` | `float` | NO |  | 0 |  |
| `EnterGravity` | `float` | NO |  | 0 |  |
| `EnterMinDuration` | `float` | NO |  | 0 |  |
| `EnterMaxDuration` | `float` | NO |  | 0 |  |
| `EnterMinArcHeight` | `float` | NO |  | 0 |  |
| `EnterMaxArcHeight` | `float` | NO |  | 0 |  |
| `EnterAnimStart` | `int` | NO |  | 0 |  |
| `EnterAnimLoop` | `int` | NO |  | 0 |  |
| `RideAnimStart` | `int` | NO |  | 0 |  |
| `RideAnimLoop` | `int` | NO |  | 0 |  |
| `RideUpperAnimStart` | `int` | NO |  | 0 |  |
| `RideUpperAnimLoop` | `int` | NO |  | 0 |  |
| `ExitPreDelay` | `float` | NO |  | 0 |  |
| `ExitSpeed` | `float` | NO |  | 0 |  |
| `ExitGravity` | `float` | NO |  | 0 |  |
| `ExitMinDuration` | `float` | NO |  | 0 |  |
| `ExitMaxDuration` | `float` | NO |  | 0 |  |
| `ExitMinArcHeight` | `float` | NO |  | 0 |  |
| `ExitMaxArcHeight` | `float` | NO |  | 0 |  |
| `ExitAnimStart` | `int` | NO |  | 0 |  |
| `ExitAnimLoop` | `int` | NO |  | 0 |  |
| `ExitAnimEnd` | `int` | NO |  | 0 |  |
| `PassengerYaw` | `float` | NO |  | 0 |  |
| `PassengerPitch` | `float` | NO |  | 0 |  |
| `PassengerRoll` | `float` | NO |  | 0 |  |
| `PassengerAttachmentID` | `int` | NO |  | 0 |  |
| `VehicleEnterAnim` | `int` | NO |  | 0 |  |
| `VehicleExitAnim` | `int` | NO |  | 0 |  |
| `VehicleRideAnimLoop` | `int` | NO |  | 0 |  |
| `VehicleEnterAnimBone` | `int` | NO |  | 0 |  |
| `VehicleExitAnimBone` | `int` | NO |  | 0 |  |
| `VehicleRideAnimLoopBone` | `int` | NO |  | 0 |  |
| `VehicleEnterAnimDelay` | `float` | NO |  | 0 |  |
| `VehicleExitAnimDelay` | `float` | NO |  | 0 |  |
| `VehicleAbilityDisplay` | `int` | NO |  | 0 |  |
| `EnterUISoundID` | `int` | NO |  | 0 |  |
| `ExitUISoundID` | `int` | NO |  | 0 |  |
| `UiSkin` | `int` | NO |  | 0 |  |
| `FlagsB` | `int` | NO |  | 0 |  |
| `CameraEnteringDelay` | `float` | NO |  | 0 |  |
| `CameraEnteringDuration` | `float` | NO |  | 0 |  |
| `CameraExitingDelay` | `float` | NO |  | 0 |  |
| `CameraExitingDuration` | `float` | NO |  | 0 |  |
| `CameraOffsetX` | `float` | NO |  | 0 |  |
| `CameraOffsetY` | `float` | NO |  | 0 |  |
| `CameraOffsetZ` | `float` | NO |  | 0 |  |
| `CameraPosChaseRate` | `float` | NO |  | 0 |  |
| `CameraFacingChaseRate` | `float` | NO |  | 0 |  |
| `CameraEnteringZoom` | `float` | NO |  | 0 |  |
| `CameraSeatZoomMin` | `float` | NO |  | 0 |  |
| `CameraSeatZoomMax` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `vehicleseat_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `AttachmentID` int NOT NULL DEFAULT '0',
  `AttachmentOffsetX` float NOT NULL DEFAULT '0',
  `AttachmentOffsetY` float NOT NULL DEFAULT '0',
  `AttachmentOffsetZ` float NOT NULL DEFAULT '0',
  `EnterPreDelay` float NOT NULL DEFAULT '0',
  `EnterSpeed` float NOT NULL DEFAULT '0',
  `EnterGravity` float NOT NULL DEFAULT '0',
  `EnterMinDuration` float NOT NULL DEFAULT '0',
  `EnterMaxDuration` float NOT NULL DEFAULT '0',
  `EnterMinArcHeight` float NOT NULL DEFAULT '0',
  `EnterMaxArcHeight` float NOT NULL DEFAULT '0',
  `EnterAnimStart` int NOT NULL DEFAULT '0',
  `EnterAnimLoop` int NOT NULL DEFAULT '0',
  `RideAnimStart` int NOT NULL DEFAULT '0',
  `RideAnimLoop` int NOT NULL DEFAULT '0',
  `RideUpperAnimStart` int NOT NULL DEFAULT '0',
  `RideUpperAnimLoop` int NOT NULL DEFAULT '0',
  `ExitPreDelay` float NOT NULL DEFAULT '0',
  `ExitSpeed` float NOT NULL DEFAULT '0',
  `ExitGravity` float NOT NULL DEFAULT '0',
  `ExitMinDuration` float NOT NULL DEFAULT '0',
  `ExitMaxDuration` float NOT NULL DEFAULT '0',
  `ExitMinArcHeight` float NOT NULL DEFAULT '0',
  `ExitMaxArcHeight` float NOT NULL DEFAULT '0',
  `ExitAnimStart` int NOT NULL DEFAULT '0',
  `ExitAnimLoop` int NOT NULL DEFAULT '0',
  `ExitAnimEnd` int NOT NULL DEFAULT '0',
  `PassengerYaw` float NOT NULL DEFAULT '0',
  `PassengerPitch` float NOT NULL DEFAULT '0',
  `PassengerRoll` float NOT NULL DEFAULT '0',
  `PassengerAttachmentID` int NOT NULL DEFAULT '0',
  `VehicleEnterAnim` int NOT NULL DEFAULT '0',
  `VehicleExitAnim` int NOT NULL DEFAULT '0',
  `VehicleRideAnimLoop` int NOT NULL DEFAULT '0',
  `VehicleEnterAnimBone` int NOT NULL DEFAULT '0',
  `VehicleExitAnimBone` int NOT NULL DEFAULT '0',
  `VehicleRideAnimLoopBone` int NOT NULL DEFAULT '0',
  `VehicleEnterAnimDelay` float NOT NULL DEFAULT '0',
  `VehicleExitAnimDelay` float NOT NULL DEFAULT '0',
  `VehicleAbilityDisplay` int NOT NULL DEFAULT '0',
  `EnterUISoundID` int NOT NULL DEFAULT '0',
  `ExitUISoundID` int NOT NULL DEFAULT '0',
  `UiSkin` int NOT NULL DEFAULT '0',
  `FlagsB` int NOT NULL DEFAULT '0',
  `CameraEnteringDelay` float NOT NULL DEFAULT '0',
  `CameraEnteringDuration` float NOT NULL DEFAULT '0',
  `CameraExitingDelay` float NOT NULL DEFAULT '0',
  `CameraExitingDuration` float NOT NULL DEFAULT '0',
  `CameraOffsetX` float NOT NULL DEFAULT '0',
  `CameraOffsetY` float NOT NULL DEFAULT '0',
  `CameraOffsetZ` float NOT NULL DEFAULT '0',
  `CameraPosChaseRate` float NOT NULL DEFAULT '0',
  `CameraFacingChaseRate` float NOT NULL DEFAULT '0',
  `CameraEnteringZoom` float NOT NULL DEFAULT '0',
  `CameraSeatZoomMin` float NOT NULL DEFAULT '0',
  `CameraSeatZoomMax` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## version

- 存储引擎: InnoDB
- 行数: 1
- 注释: Version Notes

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `core_version` | `varchar(255)` | NO | PRI |  |  |
| `core_revision` | `varchar(120)` | YES |  |  |  |
| `db_version` | `varchar(120)` | YES |  |  |  |
| `cache_id` | `int` | YES |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `core_version` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `version` (
  `core_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Core revision dumped at startup.',
  `core_revision` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `db_version` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Version of world DB.',
  `cache_id` int DEFAULT '0',
  PRIMARY KEY (`core_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Version Notes'
```

---

## warden_checks

- 存储引擎: InnoDB
- 行数: 793

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `smallint unsigned` | NO | PRI |  | auto_increment |
| `type` | `tinyint unsigned` | YES |  |  |  |
| `data` | `varchar(48)` | YES |  |  |  |
| `str` | `varchar(170)` | YES |  |  |  |
| `address` | `int unsigned` | YES |  |  |  |
| `length` | `tinyint unsigned` | YES |  |  |  |
| `result` | `varchar(24)` | YES |  |  |  |
| `comment` | `varchar(50)` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `warden_checks` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint unsigned DEFAULT NULL,
  `data` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `str` varchar(170) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` int unsigned DEFAULT NULL,
  `length` tinyint unsigned DEFAULT NULL,
  `result` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=812 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## waypoint_data

- 存储引擎: InnoDB
- 行数: 150362

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO | PRI | 0 |  |
| `point` | `int unsigned` | NO | PRI | 0 |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | YES |  |  |  |
| `velocity` | `float` | NO |  | 0 |  |
| `delay` | `int unsigned` | NO |  | 0 |  |
| `smoothTransition` | `tinyint` | NO |  | 0 |  |
| `move_type` | `int` | NO |  | 0 |  |
| `action` | `int` | NO |  | 0 |  |
| `action_chance` | `smallint` | NO |  | 100 |  |
| `wpguid` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `id` | 是 | BTREE |
| PRIMARY | `point` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `waypoint_data` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Creature GUID',
  `point` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float DEFAULT NULL,
  `velocity` float NOT NULL DEFAULT '0',
  `delay` int unsigned NOT NULL DEFAULT '0',
  `smoothTransition` tinyint NOT NULL DEFAULT '0',
  `move_type` int NOT NULL DEFAULT '0',
  `action` int NOT NULL DEFAULT '0',
  `action_chance` smallint NOT NULL DEFAULT '100',
  `wpguid` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## waypoint_data_addon

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `PathID` | `int unsigned` | NO | PRI |  |  |
| `PointID` | `int unsigned` | NO | PRI |  |  |
| `SplinePointIndex` | `int unsigned` | NO | PRI |  |  |
| `PositionX` | `float` | NO |  | 0 |  |
| `PositionY` | `float` | NO |  | 0 |  |
| `PositionZ` | `float` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `PathID` | 是 | BTREE |
| PRIMARY | `PointID` | 是 | BTREE |
| PRIMARY | `SplinePointIndex` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `waypoint_data_addon` (
  `PathID` int unsigned NOT NULL,
  `PointID` int unsigned NOT NULL,
  `SplinePointIndex` int unsigned NOT NULL,
  `PositionX` float NOT NULL DEFAULT '0',
  `PositionY` float NOT NULL DEFAULT '0',
  `PositionZ` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`PathID`,`PointID`,`SplinePointIndex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```

---

## waypoint_scripts

- 存储引擎: InnoDB
- 行数: 577

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `id` | `int unsigned` | NO |  | 0 |  |
| `delay` | `int unsigned` | NO |  | 0 |  |
| `command` | `int unsigned` | NO |  | 0 |  |
| `datalong` | `int unsigned` | NO |  | 0 |  |
| `datalong2` | `int unsigned` | NO |  | 0 |  |
| `dataint` | `int unsigned` | NO |  | 0 |  |
| `x` | `float` | NO |  | 0 |  |
| `y` | `float` | NO |  | 0 |  |
| `z` | `float` | NO |  | 0 |  |
| `o` | `float` | NO |  | 0 |  |
| `guid` | `int` | NO | PRI | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `guid` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `waypoint_scripts` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `delay` int unsigned NOT NULL DEFAULT '0',
  `command` int unsigned NOT NULL DEFAULT '0',
  `datalong` int unsigned NOT NULL DEFAULT '0',
  `datalong2` int unsigned NOT NULL DEFAULT '0',
  `dataint` int unsigned NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `guid` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## waypoints

- 存储引擎: InnoDB
- 行数: 13697
- 注释: Creature waypoints

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `entry` | `int unsigned` | NO | PRI | 0 |  |
| `pointid` | `int unsigned` | NO | PRI | 0 |  |
| `position_x` | `float` | NO |  | 0 |  |
| `position_y` | `float` | NO |  | 0 |  |
| `position_z` | `float` | NO |  | 0 |  |
| `orientation` | `float` | YES |  |  |  |
| `delay` | `int unsigned` | NO |  | 0 |  |
| `point_comment` | `text` | YES |  |  |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `entry` | 是 | BTREE |
| PRIMARY | `pointid` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `waypoints` (
  `entry` int unsigned NOT NULL DEFAULT '0',
  `pointid` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float DEFAULT NULL,
  `delay` int unsigned NOT NULL DEFAULT '0',
  `point_comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`entry`,`pointid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature waypoints'
```

---

## wmoareatable_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `WMOID` | `int` | NO |  | 0 |  |
| `NameSetID` | `int` | NO |  | 0 |  |
| `WMOGroupID` | `int` | NO |  | 0 |  |
| `SoundProviderPref` | `int` | NO |  | 0 |  |
| `SoundProviderPrefUnderwater` | `int` | NO |  | 0 |  |
| `AmbienceID` | `int` | NO |  | 0 |  |
| `ZoneMusic` | `int` | NO |  | 0 |  |
| `IntroSound` | `int` | NO |  | 0 |  |
| `Flags` | `int` | NO |  | 0 |  |
| `AreaTableID` | `int` | NO |  | 0 |  |
| `AreaName_Lang_enUS` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_enGB` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_koKR` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_frFR` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_deDE` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_enCN` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_zhCN` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_enTW` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_zhTW` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_esES` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_esMX` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_ruRU` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_ptPT` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_ptBR` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_itIT` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_Unk` | `varchar(100)` | YES |  |  |  |
| `AreaName_Lang_Mask` | `int unsigned` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `wmoareatable_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `WMOID` int NOT NULL DEFAULT '0',
  `NameSetID` int NOT NULL DEFAULT '0',
  `WMOGroupID` int NOT NULL DEFAULT '0',
  `SoundProviderPref` int NOT NULL DEFAULT '0',
  `SoundProviderPrefUnderwater` int NOT NULL DEFAULT '0',
  `AmbienceID` int NOT NULL DEFAULT '0',
  `ZoneMusic` int NOT NULL DEFAULT '0',
  `IntroSound` int NOT NULL DEFAULT '0',
  `Flags` int NOT NULL DEFAULT '0',
  `AreaTableID` int NOT NULL DEFAULT '0',
  `AreaName_Lang_enUS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_enGB` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_koKR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_frFR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_deDE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_enCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_zhCN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_enTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_zhTW` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_esES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_esMX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_ruRU` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_ptPT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_ptBR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_itIT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_Unk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AreaName_Lang_Mask` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## worldmaparea_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `MapID` | `int` | NO |  | 0 |  |
| `AreaID` | `int` | NO |  | 0 |  |
| `AreaName` | `varchar(100)` | YES |  |  |  |
| `LocLeft` | `float` | NO |  | 0 |  |
| `LocRight` | `float` | NO |  | 0 |  |
| `LocTop` | `float` | NO |  | 0 |  |
| `LocBottom` | `float` | NO |  | 0 |  |
| `DisplayMapID` | `int` | NO |  | 0 |  |
| `DefaultDungeonFloor` | `int` | NO |  | 0 |  |
| `ParentWorldMapID` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `worldmaparea_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `MapID` int NOT NULL DEFAULT '0',
  `AreaID` int NOT NULL DEFAULT '0',
  `AreaName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LocLeft` float NOT NULL DEFAULT '0',
  `LocRight` float NOT NULL DEFAULT '0',
  `LocTop` float NOT NULL DEFAULT '0',
  `LocBottom` float NOT NULL DEFAULT '0',
  `DisplayMapID` int NOT NULL DEFAULT '0',
  `DefaultDungeonFloor` int NOT NULL DEFAULT '0',
  `ParentWorldMapID` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

---

## worldmapoverlay_dbc

- 存储引擎: InnoDB
- 行数: 0

### 字段

| 字段 | 类型 | 可为空 | 键 | 默认值 | 额外 |
|------|------|--------|----|--------|------|
| `ID` | `int` | NO | PRI | 0 |  |
| `MapAreaID` | `int` | NO |  | 0 |  |
| `AreaID_1` | `int` | NO |  | 0 |  |
| `AreaID_2` | `int` | NO |  | 0 |  |
| `AreaID_3` | `int` | NO |  | 0 |  |
| `AreaID_4` | `int` | NO |  | 0 |  |
| `MapPointX` | `int` | NO |  | 0 |  |
| `MapPointY` | `int` | NO |  | 0 |  |
| `TextureName` | `varchar(100)` | YES |  |  |  |
| `TextureWidth` | `int` | NO |  | 0 |  |
| `TextureHeight` | `int` | NO |  | 0 |  |
| `OffsetX` | `int` | NO |  | 0 |  |
| `OffsetY` | `int` | NO |  | 0 |  |
| `HitRectTop` | `int` | NO |  | 0 |  |
| `HitRectLeft` | `int` | NO |  | 0 |  |
| `HitRectBottom` | `int` | NO |  | 0 |  |
| `HitRectRight` | `int` | NO |  | 0 |  |

### 索引

| 索引名 | 字段 | 唯一 | 类型 |
|--------|------|------|------|
| PRIMARY | `ID` | 是 | BTREE |

### CREATE TABLE

```sql
CREATE TABLE `worldmapoverlay_dbc` (
  `ID` int NOT NULL DEFAULT '0',
  `MapAreaID` int NOT NULL DEFAULT '0',
  `AreaID_1` int NOT NULL DEFAULT '0',
  `AreaID_2` int NOT NULL DEFAULT '0',
  `AreaID_3` int NOT NULL DEFAULT '0',
  `AreaID_4` int NOT NULL DEFAULT '0',
  `MapPointX` int NOT NULL DEFAULT '0',
  `MapPointY` int NOT NULL DEFAULT '0',
  `TextureName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TextureWidth` int NOT NULL DEFAULT '0',
  `TextureHeight` int NOT NULL DEFAULT '0',
  `OffsetX` int NOT NULL DEFAULT '0',
  `OffsetY` int NOT NULL DEFAULT '0',
  `HitRectTop` int NOT NULL DEFAULT '0',
  `HitRectLeft` int NOT NULL DEFAULT '0',
  `HitRectBottom` int NOT NULL DEFAULT '0',
  `HitRectRight` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

