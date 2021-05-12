let knex;

exports.init = (config) => {
  knex = require("knex")({
    client: "mysql",
    connection: config,
  });
};

exports.knex = () => knex;

exports.dbcDatabaseSql = "CREATE DATABASE IF NOT EXISTS foxy;";

exports.dbcSpellSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_spell` (`ID` INT NOT NULL DEFAULT '0',`Category` INT UNSIGNED NOT NULL DEFAULT '0',`DispelType` INT UNSIGNED NOT NULL DEFAULT '0',`Mechanic` INT UNSIGNED NOT NULL DEFAULT '0',`Attributes` INT UNSIGNED NOT NULL DEFAULT '0',`AttributesEx` INT UNSIGNED NOT NULL DEFAULT '0',`AttributesExB` INT UNSIGNED NOT NULL DEFAULT '0',`AttributesExC` INT UNSIGNED NOT NULL DEFAULT '0',`AttributesExD` INT UNSIGNED NOT NULL DEFAULT '0',`AttributesExE` INT UNSIGNED NOT NULL DEFAULT '0',`AttributesExF` INT UNSIGNED NOT NULL DEFAULT '0',`AttributesExG` INT UNSIGNED NOT NULL DEFAULT '0',`ShapeshiftMask` INT UNSIGNED NOT NULL DEFAULT '0',`Unk_13` INT UNSIGNED NOT NULL DEFAULT '0',`ShapeshiftExclude` INT UNSIGNED NOT NULL DEFAULT '0',`Unk_15` INT UNSIGNED NOT NULL DEFAULT '0',`Targets` INT UNSIGNED NOT NULL DEFAULT '0',`TargetCreatureType` INT UNSIGNED NOT NULL DEFAULT '0',`RequiresSpellFocus` INT UNSIGNED NOT NULL DEFAULT '0',`FacingCasterFlags` INT UNSIGNED NOT NULL DEFAULT '0',`CasterAuraState` INT UNSIGNED NOT NULL DEFAULT '0',`TargetAuraState` INT UNSIGNED NOT NULL DEFAULT '0',`ExcludeCasterAuraState` INT UNSIGNED NOT NULL DEFAULT '0',`ExcludeTargetAuraState` INT UNSIGNED NOT NULL DEFAULT '0',`CasterAuraSpell` INT UNSIGNED NOT NULL DEFAULT '0',`TargetAuraSpell` INT UNSIGNED NOT NULL DEFAULT '0',`ExcludeCasterAuraSpell` INT UNSIGNED NOT NULL DEFAULT '0',`ExcludeTargetAuraSpell` INT UNSIGNED NOT NULL DEFAULT '0',`CastingTimeIndex` INT UNSIGNED NOT NULL DEFAULT '0',`RecoveryTime` INT UNSIGNED NOT NULL DEFAULT '0',`CategoryRecoveryTime` INT UNSIGNED NOT NULL DEFAULT '0',`InterruptFlags` INT UNSIGNED NOT NULL DEFAULT '0',`AuraInterruptFlags` INT UNSIGNED NOT NULL DEFAULT '0',`ChannelInterruptFlags` INT UNSIGNED NOT NULL DEFAULT '0',`ProcTypeMask` INT UNSIGNED NOT NULL DEFAULT '0',`ProcChance` INT UNSIGNED NOT NULL DEFAULT '0',`ProcCharges` INT UNSIGNED NOT NULL DEFAULT '0',`MaxLevel` INT UNSIGNED NOT NULL DEFAULT '0',`BaseLevel` INT UNSIGNED NOT NULL DEFAULT '0',`SpellLevel` INT UNSIGNED NOT NULL DEFAULT '0',`DurationIndex` INT UNSIGNED NOT NULL DEFAULT '0',`PowerType` INT NOT NULL DEFAULT '0',`ManaCost` INT UNSIGNED NOT NULL DEFAULT '0',`ManaCostPerLevel` INT UNSIGNED NOT NULL DEFAULT '0',`ManaPerSecond` INT UNSIGNED NOT NULL DEFAULT '0',`ManaPerSecondPerLevel` INT UNSIGNED NOT NULL DEFAULT '0',`RangeIndex` INT UNSIGNED NOT NULL DEFAULT '0',`Speed` FLOAT NOT NULL DEFAULT '0',`ModalNextSpell` INT UNSIGNED NOT NULL DEFAULT '0',`CumulativeAura` INT UNSIGNED NOT NULL DEFAULT '0',`Totem_1` INT UNSIGNED NOT NULL DEFAULT '0',`Totem_2` INT UNSIGNED NOT NULL DEFAULT '0',`Reagent_1` INT NOT NULL DEFAULT '0',`Reagent_2` INT NOT NULL DEFAULT '0',`Reagent_3` INT NOT NULL DEFAULT '0',`Reagent_4` INT NOT NULL DEFAULT '0',`Reagent_5` INT NOT NULL DEFAULT '0',`Reagent_6` INT NOT NULL DEFAULT '0',`Reagent_7` INT NOT NULL DEFAULT '0',`Reagent_8` INT NOT NULL DEFAULT '0',`ReagentCount_1` INT NOT NULL DEFAULT '0',`ReagentCount_2` INT NOT NULL DEFAULT '0',`ReagentCount_3` INT NOT NULL DEFAULT '0',`ReagentCount_4` INT NOT NULL DEFAULT '0',`ReagentCount_5` INT NOT NULL DEFAULT '0',`ReagentCount_6` INT NOT NULL DEFAULT '0',`ReagentCount_7` INT NOT NULL DEFAULT '0',`ReagentCount_8` INT NOT NULL DEFAULT '0',`EquippedItemClass` INT NOT NULL DEFAULT '0',`EquippedItemSubclass` INT NOT NULL DEFAULT '0',`EquippedItemInvTypes` INT NOT NULL DEFAULT '0',`Effect_1` INT UNSIGNED NOT NULL DEFAULT '0',`Effect_2` INT UNSIGNED NOT NULL DEFAULT '0',`Effect_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectDieSides_1` INT NOT NULL DEFAULT '0',`EffectDieSides_2` INT NOT NULL DEFAULT '0',`EffectDieSides_3` INT NOT NULL DEFAULT '0',`EffectRealPointsPerLevel_1` FLOAT NOT NULL DEFAULT '0',`EffectRealPointsPerLevel_2` FLOAT NOT NULL DEFAULT '0',`EffectRealPointsPerLevel_3` FLOAT NOT NULL DEFAULT '0',`EffectBasePoints_1` INT NOT NULL DEFAULT '0',`EffectBasePoints_2` INT NOT NULL DEFAULT '0',`EffectBasePoints_3` INT NOT NULL DEFAULT '0',`EffectMechanic_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectMechanic_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectMechanic_3` INT UNSIGNED NOT NULL DEFAULT '0',`ImplicitTargetA_1` INT UNSIGNED NOT NULL DEFAULT '0',`ImplicitTargetA_2` INT UNSIGNED NOT NULL DEFAULT '0',`ImplicitTargetA_3` INT UNSIGNED NOT NULL DEFAULT '0',`ImplicitTargetB_1` INT UNSIGNED NOT NULL DEFAULT '0',`ImplicitTargetB_2` INT UNSIGNED NOT NULL DEFAULT '0',`ImplicitTargetB_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectRadiusIndex_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectRadiusIndex_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectRadiusIndex_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectAura_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectAura_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectAura_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectAuraPeriod_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectAuraPeriod_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectAuraPeriod_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectMultipleValue_1` FLOAT NOT NULL DEFAULT '0',`EffectMultipleValue_2` FLOAT NOT NULL DEFAULT '0',`EffectMultipleValue_3` FLOAT NOT NULL DEFAULT '0',`EffectChainTargets_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectChainTargets_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectChainTargets_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectItemType_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectItemType_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectItemType_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectMiscValue_1` INT NOT NULL DEFAULT '0',`EffectMiscValue_2` INT NOT NULL DEFAULT '0',`EffectMiscValue_3` INT NOT NULL DEFAULT '0',`EffectMiscValueB_1` INT NOT NULL DEFAULT '0',`EffectMiscValueB_2` INT NOT NULL DEFAULT '0',`EffectMiscValueB_3` INT NOT NULL DEFAULT '0',`EffectTriggerSpell_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectTriggerSpell_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectTriggerSpell_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectPointsPerCombo_1` FLOAT NOT NULL DEFAULT '0',`EffectPointsPerCombo_2` FLOAT NOT NULL DEFAULT '0',`EffectPointsPerCombo_3` FLOAT NOT NULL DEFAULT '0',`EffectSpellClassMaskA_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskA_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskA_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskB_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskB_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskB_3` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskC_1` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskC_2` INT UNSIGNED NOT NULL DEFAULT '0',`EffectSpellClassMaskC_3` INT UNSIGNED NOT NULL DEFAULT '0',`SpellVisualID_1` INT UNSIGNED NOT NULL DEFAULT '0',`SpellVisualID_2` INT UNSIGNED NOT NULL DEFAULT '0',`SpellIconID` INT UNSIGNED NOT NULL DEFAULT '0',`ActiveIconID` INT UNSIGNED NOT NULL DEFAULT '0',`SpellPriority` INT UNSIGNED NOT NULL DEFAULT '0',`Name_Lang_enUS` TEXT NULL,`Name_Lang_enGB` TEXT NULL,`Name_Lang_koKR` TEXT NULL,`Name_Lang_frFR` TEXT NULL,`Name_Lang_zhCN` TEXT NULL,`Name_Lang_enCN` TEXT NULL,`Name_Lang_deDE` TEXT NULL,`Name_Lang_enTW` TEXT NULL,`Name_Lang_zhTW` TEXT NULL,`Name_Lang_esES` TEXT NULL,`Name_Lang_esMX` TEXT NULL,`Name_Lang_ruRU` TEXT NULL,`Name_Lang_ptPT` TEXT NULL,`Name_Lang_ptBR` TEXT NULL,`Name_Lang_itIT` TEXT NULL,`Name_Lang_Unk` TEXT NULL,`Name_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0',`NameSubtext_Lang_enUS` TEXT NULL,`NameSubtext_Lang_enGB` TEXT NULL,`NameSubtext_Lang_koKR` TEXT NULL,`NameSubtext_Lang_frFR` TEXT NULL,`NameSubtext_Lang_zhCN` TEXT NULL,`NameSubtext_Lang_enCN` TEXT NULL,`NameSubtext_Lang_deDE` TEXT NULL,`NameSubtext_Lang_enTW` TEXT NULL,`NameSubtext_Lang_zhTW` TEXT NULL,`NameSubtext_Lang_esES` TEXT NULL,`NameSubtext_Lang_esMX` TEXT NULL,`NameSubtext_Lang_ruRU` TEXT NULL,`NameSubtext_Lang_ptPT` TEXT NULL,`NameSubtext_Lang_ptBR` TEXT NULL,`NameSubtext_Lang_itIT` TEXT NULL,`NameSubtext_Lang_Unk` TEXT NULL,`NameSubtext_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0',`Description_Lang_enUS` TEXT NULL,`Description_Lang_enGB` TEXT NULL,`Description_Lang_koKR` TEXT NULL,`Description_Lang_frFR` TEXT NULL,`Description_Lang_zhCN` TEXT NULL,`Description_Lang_enCN` TEXT NULL,`Description_Lang_deDE` TEXT NULL,`Description_Lang_enTW` TEXT NULL,`Description_Lang_zhTW` TEXT NULL,`Description_Lang_esES` TEXT NULL,`Description_Lang_esMX` TEXT NULL,`Description_Lang_ruRU` TEXT NULL,`Description_Lang_ptPT` TEXT NULL,`Description_Lang_ptBR` TEXT NULL,`Description_Lang_itIT` TEXT NULL,`Description_Lang_Unk` TEXT NULL,`Description_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0',`AuraDescription_Lang_enUS` TEXT NULL,`AuraDescription_Lang_enGB` TEXT NULL,`AuraDescription_Lang_koKR` TEXT NULL,`AuraDescription_Lang_frFR` TEXT NULL,`AuraDescription_Lang_zhCN` TEXT NULL,`AuraDescription_Lang_enCN` TEXT NULL,`AuraDescription_Lang_deDE` TEXT NULL,`AuraDescription_Lang_enTW` TEXT NULL,`AuraDescription_Lang_zhTW` TEXT NULL,`AuraDescription_Lang_esES` TEXT NULL,`AuraDescription_Lang_esMX` TEXT NULL,`AuraDescription_Lang_ruRU` TEXT NULL,`AuraDescription_Lang_ptPT` TEXT NULL,`AuraDescription_Lang_ptBR` TEXT NULL,`AuraDescription_Lang_itIT` TEXT NULL,`AuraDescription_Lang_Unk` TEXT NULL,`AuraDescription_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0',`ManaCostPct` INT UNSIGNED NOT NULL DEFAULT '0',`StartRecoveryCategory` INT UNSIGNED NOT NULL DEFAULT '0',`StartRecoveryTime` INT UNSIGNED NOT NULL DEFAULT '0',`MaxTargetLevel` INT UNSIGNED NOT NULL DEFAULT '0',`SpellClassSet` INT UNSIGNED NOT NULL DEFAULT '0',`SpellClassMask_1` INT UNSIGNED NOT NULL DEFAULT '0',`SpellClassMask_2` INT UNSIGNED NOT NULL DEFAULT '0',`SpellClassMask_3` INT UNSIGNED NOT NULL DEFAULT '0',`MaxTargets` INT UNSIGNED NOT NULL DEFAULT '0',`DefenseType` INT UNSIGNED NOT NULL DEFAULT '0',`PreventionType` INT UNSIGNED NOT NULL DEFAULT '0',`StanceBarOrder` INT UNSIGNED NOT NULL DEFAULT '0',`EffectChainAmplitude_1` FLOAT NOT NULL DEFAULT '0',`EffectChainAmplitude_2` FLOAT NOT NULL DEFAULT '0',`EffectChainAmplitude_3` FLOAT NOT NULL DEFAULT '0',`MinFactionID` INT UNSIGNED NOT NULL DEFAULT '0',`MinReputation` INT UNSIGNED NOT NULL DEFAULT '0',`RequiredAuraVision` INT UNSIGNED NOT NULL DEFAULT '0',`RequiredTotemCategoryID_1` INT UNSIGNED NOT NULL DEFAULT '0',`RequiredTotemCategoryID_2` INT UNSIGNED NOT NULL DEFAULT '0',`RequiredAreasID` INT NOT NULL DEFAULT '0',`SchoolMask` INT UNSIGNED NOT NULL DEFAULT '0',`RuneCostID` INT UNSIGNED NOT NULL DEFAULT '0',`SpellMissileID` INT UNSIGNED NOT NULL DEFAULT '0',`PowerDisplayID` INT NOT NULL DEFAULT '0',`EffectBonusMultiplier_1` FLOAT NOT NULL DEFAULT '0',`EffectBonusMultiplier_2` FLOAT NOT NULL DEFAULT '0',`EffectBonusMultiplier_3` FLOAT NOT NULL DEFAULT '0',`SpellDescriptionVariableID` INT UNSIGNED NOT NULL DEFAULT '0',`SpellDifficultyID` INT UNSIGNED NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcFactionSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_faction` (`ID` INT NOT NULL DEFAULT '0',`ReputationIndex` INT NOT NULL DEFAULT '0',`ReputationRaceMask_1` INT NOT NULL DEFAULT '0',`ReputationRaceMask_2` INT NOT NULL DEFAULT '0',`ReputationRaceMask_3` INT NOT NULL DEFAULT '0',`ReputationRaceMask_4` INT NOT NULL DEFAULT '0',`ReputationClassMask_1` INT NOT NULL DEFAULT '0',`ReputationClassMask_2` INT NOT NULL DEFAULT '0',`ReputationClassMask_3` INT NOT NULL DEFAULT '0',`ReputationClassMask_4` INT NOT NULL DEFAULT '0',`ReputationBase_1` INT NOT NULL DEFAULT '0',`ReputationBase_2` INT NOT NULL DEFAULT '0',`ReputationBase_3` INT NOT NULL DEFAULT '0',`ReputationBase_4` INT NOT NULL DEFAULT '0',`ReputationFlags_1` INT NOT NULL DEFAULT '0',`ReputationFlags_2` INT NOT NULL DEFAULT '0',`ReputationFlags_3` INT NOT NULL DEFAULT '0',`ReputationFlags_4` INT NOT NULL DEFAULT '0',`ParentFactionID` INT NOT NULL DEFAULT '0',`ParentFactionMod_1` FLOAT NOT NULL DEFAULT '0',`ParentFactionMod_2` FLOAT NOT NULL DEFAULT '0',`ParentFactionCap_1` INT NOT NULL DEFAULT '0',`ParentFactionCap_2` INT NOT NULL DEFAULT '0',`Name_Lang_enUS` TEXT NULL,`Name_Lang_enGB` TEXT NULL,`Name_Lang_koKR` TEXT NULL,`Name_Lang_frFR` TEXT NULL,`Name_Lang_zhCN` TEXT NULL,`Name_Lang_enCN` TEXT NULL,`Name_Lang_deDE` TEXT NULL,`Name_Lang_enTW` TEXT NULL,`Name_Lang_zhTW` TEXT NULL,`Name_Lang_esES` TEXT NULL,`Name_Lang_esMX` TEXT NULL,`Name_Lang_ruRU` TEXT NULL,`Name_Lang_ptPT` TEXT NULL,`Name_Lang_ptBR` TEXT NULL,`Name_Lang_itIT` TEXT NULL,`Name_Lang_Unk` TEXT NULL,`Name_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0',`Description_Lang_enUS` TEXT NULL,`Description_Lang_enGB` TEXT NULL,`Description_Lang_koKR` TEXT NULL,`Description_Lang_frFR` TEXT NULL,`Description_Lang_zhCN` TEXT NULL,`Description_Lang_enCN` TEXT NULL,`Description_Lang_deDE` TEXT NULL,`Description_Lang_enTW` TEXT NULL,`Description_Lang_zhTW` TEXT NULL,`Description_Lang_esES` TEXT NULL,`Description_Lang_esMX` TEXT NULL,`Description_Lang_ruRU` TEXT NULL,`Description_Lang_ptPT` TEXT NULL,`Description_Lang_ptBR` TEXT NULL,`Description_Lang_itIT` TEXT NULL,`Description_Lang_Unk` TEXT NULL,`Description_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcFactionTemplateSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_faction_template` (`ID` INT NOT NULL DEFAULT '0',`Faction` INT NOT NULL DEFAULT '0',`Flags` INT NOT NULL DEFAULT '0',`FactionGroup` INT NOT NULL DEFAULT '0',`FriendGroup` INT NOT NULL DEFAULT '0',`EnemyGroup` INT NOT NULL DEFAULT '0',`Enemies_1` INT NOT NULL DEFAULT '0',`Enemies_2` INT NOT NULL DEFAULT '0',`Enemies_3` INT NOT NULL DEFAULT '0',`Enemies_4` INT NOT NULL DEFAULT '0',`Friend_1` INT NOT NULL DEFAULT '0',`Friend_2` INT NOT NULL DEFAULT '0',`Friend_3` INT NOT NULL DEFAULT '0',`Friend_4` INT NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcItemSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_item` (`ID` INT NOT NULL DEFAULT '0',`ClassID` INT NOT NULL DEFAULT '0',`SubclassID` INT NOT NULL DEFAULT '0',`Sound_Override_Subclassid` INT NOT NULL DEFAULT '0',`Material` INT NOT NULL DEFAULT '0',`DisplayInfoID` INT NOT NULL DEFAULT '0',`InventoryType` INT NOT NULL DEFAULT '0',`SheatheType` INT NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcItemDisplayInfoSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_item_display_info` (`ID` INT NOT NULL DEFAULT '0',`ModelName_1` TEXT NULL,`ModelName_2` TEXT NULL,`ModelTexture_1` TEXT NULL,`ModelTexture_2` TEXT NULL,`InventoryIcon_1` TEXT NULL,`InventoryIcon_2` TEXT NULL,`GeosetGroup_1` INT NOT NULL DEFAULT '0',`GeosetGroup_2` INT NOT NULL DEFAULT '0',`GeosetGroup_3` INT NOT NULL DEFAULT '0',`Flags` INT NOT NULL DEFAULT '0',`SpellVisualID` INT NOT NULL DEFAULT '0',`GroupSoundIndex` INT NOT NULL DEFAULT '0',`HelmetGeosetVis_1` INT NOT NULL DEFAULT '0',`HelmetGeosetVis_2` INT NOT NULL DEFAULT '0',`Texture_1` TEXT NULL,`Texture_2` TEXT NULL,`Texture_3` TEXT NULL,`Texture_4` TEXT NULL,`Texture_5` TEXT NULL,`Texture_6` TEXT NULL,`Texture_7` TEXT NULL,`Texture_8` TEXT NULL,`ItemVisual` INT NOT NULL DEFAULT '0',`ParticleColorID` INT NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcSpellDurationSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_spell_duration` (`ID` INT NOT NULL DEFAULT '0',`Duration` INT NOT NULL DEFAULT '0',`DurationPerLevel` INT NOT NULL DEFAULT '0',`MaxDuration` INT NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcScalingStatDistributionSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_scaling_stat_distribution` (`ID` INT NOT NULL DEFAULT '0',`StatID_1` INT NOT NULL DEFAULT '0',`StatID_2` INT NOT NULL DEFAULT '0',`StatID_3` INT NOT NULL DEFAULT '0',`StatID_4` INT NOT NULL DEFAULT '0',`StatID_5` INT NOT NULL DEFAULT '0',`StatID_6` INT NOT NULL DEFAULT '0',`StatID_7` INT NOT NULL DEFAULT '0',`StatID_8` INT NOT NULL DEFAULT '0',`StatID_9` INT NOT NULL DEFAULT '0',`StatID_10` INT NOT NULL DEFAULT '0',`Bonus_1` INT NOT NULL DEFAULT '0',`Bonus_2` INT NOT NULL DEFAULT '0',`Bonus_3` INT NOT NULL DEFAULT '0',`Bonus_4` INT NOT NULL DEFAULT '0',`Bonus_5` INT NOT NULL DEFAULT '0',`Bonus_6` INT NOT NULL DEFAULT '0',`Bonus_7` INT NOT NULL DEFAULT '0',`Bonus_8` INT NOT NULL DEFAULT '0',`Bonus_9` INT NOT NULL DEFAULT '0',`Bonus_10` INT NOT NULL DEFAULT '0',`Maxlevel` INT NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcScalingStatValuesSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_scaling_stat_values` (`ID` INT NOT NULL DEFAULT '0',`Charlevel` INT NOT NULL DEFAULT '0',`ShoulderBudget` INT NOT NULL DEFAULT '0',`TrinketBudget` INT NOT NULL DEFAULT '0',`WeaponBudget1H` INT NOT NULL DEFAULT '0',`RangedBudget` INT NOT NULL DEFAULT '0',`ClothShoulderArmor` INT NOT NULL DEFAULT '0',`LeatherShoulderArmor` INT NOT NULL DEFAULT '0',`MailShoulderArmor` INT NOT NULL DEFAULT '0',`PlateShoulderArmor` INT NOT NULL DEFAULT '0',`WeaponDPS1H` INT NOT NULL DEFAULT '0',`WeaponDPS2H` INT NOT NULL DEFAULT '0',`SpellcasterDPS1H` INT NOT NULL DEFAULT '0',`SpellcasterDPS2H` INT NOT NULL DEFAULT '0',`RangedDPS` INT NOT NULL DEFAULT '0',`WandDPS` INT NOT NULL DEFAULT '0',`SpellPower` INT NOT NULL DEFAULT '0',`PrimaryBudget` INT NOT NULL DEFAULT '0',`TertiaryBudget` INT NOT NULL DEFAULT '0',`ClothCloakArmor` INT NOT NULL DEFAULT '0',`ClothChestArmor` INT NOT NULL DEFAULT '0',`LeatherChestArmor` INT NOT NULL DEFAULT '0',`MailChestArmor` INT NOT NULL DEFAULT '0',`PlateChestArmor` INT NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE = MyISAM DEFAULT CHARSET = utf8;";

exports.dbcCreatureSpellDataSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_creature_spell_data` (`ID` int(11) NOT NULL DEFAULT '0',`Spells_1` int(11) NOT NULL DEFAULT '0',`Spells_2` int(11) NOT NULL DEFAULT '0',`Spells_3` int(11) NOT NULL DEFAULT '0',`Spells_4` int(11) NOT NULL DEFAULT '0',`Availability_1` int(11) NOT NULL DEFAULT '0',`Availability_2` int(11) NOT NULL DEFAULT '0',`Availability_3` int(11) NOT NULL DEFAULT '0',`Availability_4` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcCreatureDisplayInfoSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_creature_display_info` (`ID` int(11) NOT NULL DEFAULT '0',`ModelID` int(11) NOT NULL DEFAULT '0',`SoundID` int(11) NOT NULL DEFAULT '0',`ExtendedDisplayInfoID` int(11) NOT NULL DEFAULT '0',`CreatureModelScale` float NOT NULL DEFAULT '0',`CreatureModelAlpha` int(11) NOT NULL DEFAULT '0',`TextureVariation_1` text COLLATE utf8_unicode_ci,`TextureVariation_2` text COLLATE utf8_unicode_ci,`TextureVariation_3` text COLLATE utf8_unicode_ci,`PortraitTextureName` text COLLATE utf8_unicode_ci,`BloodLevel` int(11) NOT NULL DEFAULT '0',`BloodID` int(11) NOT NULL DEFAULT '0',`NPCSoundID` int(11) NOT NULL DEFAULT '0',`ParticleColorID` int(11) NOT NULL DEFAULT '0',`CreatureGeosetData` int(11) NOT NULL DEFAULT '0',`ObjectEffectPackageID` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcCreatureModelDataSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_creature_model_data` (`ID` int(11) NOT NULL DEFAULT '0',`Flags` int(11) NOT NULL DEFAULT '0',`ModelName` text COLLATE utf8_unicode_ci,`SizeClass` int(11) NOT NULL DEFAULT '0',`ModelScale` float NOT NULL DEFAULT '0',`BloodID` int(11) NOT NULL DEFAULT '0',`FootprintTextureID` int(11) NOT NULL DEFAULT '0',`FootprintTextureLength` float NOT NULL DEFAULT '0',`FootprintTextureWidth` float NOT NULL DEFAULT '0',`FootprintParticleScale` float NOT NULL DEFAULT '0',`FoleyMaterialID` int(11) NOT NULL DEFAULT '0',`FootstepShakeSize` int(11) NOT NULL DEFAULT '0',`DeathThudShakeSize` int(11) NOT NULL DEFAULT '0',`SoundID` int(11) NOT NULL DEFAULT '0',`CollisionWidth` float NOT NULL DEFAULT '0',`CollisionHeight` float NOT NULL DEFAULT '0',`MountHeight` float NOT NULL DEFAULT '0',`GeoBoxMinX` float NOT NULL DEFAULT '0',`GeoBoxMinY` float NOT NULL DEFAULT '0',`GeoBoxMinZ` float NOT NULL DEFAULT '0',`GeoBoxMaxX` float NOT NULL DEFAULT '0',`GeoBoxMaxY` float NOT NULL DEFAULT '0',`GeoBoxMaxZ` float NOT NULL DEFAULT '0',`WorldEffectScale` float NOT NULL DEFAULT '0',`AttachedEffectScale` float NOT NULL DEFAULT '0',`MissileCollisionRadius` float NOT NULL DEFAULT '0',`MissileCollisionPush` float NOT NULL DEFAULT '0',`MissileCollisionRaise` float NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcItemSetSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_item_set` (`ID` int(11) NOT NULL DEFAULT '0',`Name_Lang_enUS` text COLLATE utf8_unicode_ci,`Name_Lang_enGB` text COLLATE utf8_unicode_ci,`Name_Lang_koKR` text COLLATE utf8_unicode_ci,`Name_Lang_frFR` text COLLATE utf8_unicode_ci,`Name_Lang_deDE` text COLLATE utf8_unicode_ci,`Name_Lang_enCN` text COLLATE utf8_unicode_ci,`Name_Lang_zhCN` text COLLATE utf8_unicode_ci,`Name_Lang_enTW` text COLLATE utf8_unicode_ci,`Name_Lang_zhTW` text COLLATE utf8_unicode_ci,`Name_Lang_esES` text COLLATE utf8_unicode_ci,`Name_Lang_esMX` text COLLATE utf8_unicode_ci,`Name_Lang_ruRU` text COLLATE utf8_unicode_ci,`Name_Lang_ptPT` text COLLATE utf8_unicode_ci,`Name_Lang_ptBR` text COLLATE utf8_unicode_ci,`Name_Lang_itIT` text COLLATE utf8_unicode_ci,`Name_Lang_Unk` text COLLATE utf8_unicode_ci,`Name_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',`ItemID_1` int(11) NOT NULL DEFAULT '0',`ItemID_2` int(11) NOT NULL DEFAULT '0',`ItemID_3` int(11) NOT NULL DEFAULT '0',`ItemID_4` int(11) NOT NULL DEFAULT '0',`ItemID_5` int(11) NOT NULL DEFAULT '0',`ItemID_6` int(11) NOT NULL DEFAULT '0',`ItemID_7` int(11) NOT NULL DEFAULT '0',`ItemID_8` int(11) NOT NULL DEFAULT '0',`ItemID_9` int(11) NOT NULL DEFAULT '0',`ItemID_10` int(11) NOT NULL DEFAULT '0',`ItemID_11` int(11) NOT NULL DEFAULT '0',`ItemID_12` int(11) NOT NULL DEFAULT '0',`ItemID_13` int(11) NOT NULL DEFAULT '0',`ItemID_14` int(11) NOT NULL DEFAULT '0',`ItemID_15` int(11) NOT NULL DEFAULT '0',`ItemID_16` int(11) NOT NULL DEFAULT '0',`ItemID_17` int(11) NOT NULL DEFAULT '0',`SetSpellID_1` int(11) NOT NULL DEFAULT '0',`SetSpellID_2` int(11) NOT NULL DEFAULT '0',`SetSpellID_3` int(11) NOT NULL DEFAULT '0',`SetSpellID_4` int(11) NOT NULL DEFAULT '0',`SetSpellID_5` int(11) NOT NULL DEFAULT '0',`SetSpellID_6` int(11) NOT NULL DEFAULT '0',`SetSpellID_7` int(11) NOT NULL DEFAULT '0',`SetSpellID_8` int(11) NOT NULL DEFAULT '0',`SetThreshold_1` int(11) NOT NULL DEFAULT '0',`SetThreshold_2` int(11) NOT NULL DEFAULT '0',`SetThreshold_3` int(11) NOT NULL DEFAULT '0',`SetThreshold_4` int(11) NOT NULL DEFAULT '0',`SetThreshold_5` int(11) NOT NULL DEFAULT '0',`SetThreshold_6` int(11) NOT NULL DEFAULT '0',`SetThreshold_7` int(11) NOT NULL DEFAULT '0',`SetThreshold_8` int(11) NOT NULL DEFAULT '0',`RequiredSkill` int(11) NOT NULL DEFAULT '0',`RequiredSkillRank` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcSpellItemEnchantmentSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_spell_item_enchantment` (`ID` int(11) NOT NULL DEFAULT '0',`Charges` int(11) NOT NULL DEFAULT '0',`Effect_1` int(11) NOT NULL DEFAULT '0',`Effect_2` int(11) NOT NULL DEFAULT '0',`Effect_3` int(11) NOT NULL DEFAULT '0',`EffectPointsMin_1` int(11) NOT NULL DEFAULT '0',`EffectPointsMin_2` int(11) NOT NULL DEFAULT '0',`EffectPointsMin_3` int(11) NOT NULL DEFAULT '0',`EffectPointsMax_1` int(11) NOT NULL DEFAULT '0',`EffectPointsMax_2` int(11) NOT NULL DEFAULT '0',`EffectPointsMax_3` int(11) NOT NULL DEFAULT '0',`EffectArg_1` int(11) NOT NULL DEFAULT '0',`EffectArg_2` int(11) NOT NULL DEFAULT '0',`EffectArg_3` int(11) NOT NULL DEFAULT '0',`Name_Lang_enUS` text COLLATE utf8_unicode_ci,`Name_Lang_enGB` text COLLATE utf8_unicode_ci,`Name_Lang_koKR` text COLLATE utf8_unicode_ci,`Name_Lang_frFR` text COLLATE utf8_unicode_ci,`Name_Lang_deDE` text COLLATE utf8_unicode_ci,`Name_Lang_enCN` text COLLATE utf8_unicode_ci,`Name_Lang_zhCN` text COLLATE utf8_unicode_ci,`Name_Lang_enTW` text COLLATE utf8_unicode_ci,`Name_Lang_zhTW` text COLLATE utf8_unicode_ci,`Name_Lang_esES` text COLLATE utf8_unicode_ci,`Name_Lang_esMX` text COLLATE utf8_unicode_ci,`Name_Lang_ruRU` text COLLATE utf8_unicode_ci,`Name_Lang_ptPT` text COLLATE utf8_unicode_ci,`Name_Lang_ptBR` text COLLATE utf8_unicode_ci,`Name_Lang_itIT` text COLLATE utf8_unicode_ci,`Name_Lang_Unk` text COLLATE utf8_unicode_ci,`Name_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',`ItemVisual` int(11) NOT NULL DEFAULT '0',`Flags` int(11) NOT NULL DEFAULT '0',`Src_ItemID` int(11) NOT NULL DEFAULT '0',`Condition_Id` int(11) NOT NULL DEFAULT '0',`RequiredSkillID` int(11) NOT NULL DEFAULT '0',`RequiredSkillRank` int(11) NOT NULL DEFAULT '0',`MinLevel` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcItemRandomPropertiesSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_item_random_properties` (`ID` int(11) NOT NULL DEFAULT '0',`Name` text COLLATE utf8_unicode_ci,`Enchantment_1` int(11) NOT NULL DEFAULT '0',`Enchantment_2` int(11) NOT NULL DEFAULT '0',`Enchantment_3` int(11) NOT NULL DEFAULT '0',`Enchantment_4` int(11) NOT NULL DEFAULT '0',`Enchantment_5` int(11) NOT NULL DEFAULT '0',`Name_Lang_enUS` text COLLATE utf8_unicode_ci,`Name_Lang_enGB` text COLLATE utf8_unicode_ci,`Name_Lang_koKR` text COLLATE utf8_unicode_ci,`Name_Lang_frFR` text COLLATE utf8_unicode_ci,`Name_Lang_deDE` text COLLATE utf8_unicode_ci,`Name_Lang_enCN` text COLLATE utf8_unicode_ci,`Name_Lang_zhCN` text COLLATE utf8_unicode_ci,`Name_Lang_enTW` text COLLATE utf8_unicode_ci,`Name_Lang_zhTW` text COLLATE utf8_unicode_ci,`Name_Lang_esES` text COLLATE utf8_unicode_ci,`Name_Lang_esMX` text COLLATE utf8_unicode_ci,`Name_Lang_ruRU` text COLLATE utf8_unicode_ci,`Name_Lang_ptPT` text COLLATE utf8_unicode_ci,`Name_Lang_ptBR` text COLLATE utf8_unicode_ci,`Name_Lang_itIT` text COLLATE utf8_unicode_ci,`Name_Lang_Unk` text COLLATE utf8_unicode_ci,`Name_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcItemRandomSuffixSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_item_random_suffix` (`ID` int(11) NOT NULL DEFAULT '0',`Name_Lang_enUS` text COLLATE utf8_unicode_ci,`Name_Lang_enGB` text COLLATE utf8_unicode_ci,`Name_Lang_koKR` text COLLATE utf8_unicode_ci,`Name_Lang_frFR` text COLLATE utf8_unicode_ci,`Name_Lang_deDE` text COLLATE utf8_unicode_ci,`Name_Lang_enCN` text COLLATE utf8_unicode_ci,`Name_Lang_zhCN` text COLLATE utf8_unicode_ci,`Name_Lang_enTW` text COLLATE utf8_unicode_ci,`Name_Lang_zhTW` text COLLATE utf8_unicode_ci,`Name_Lang_esES` text COLLATE utf8_unicode_ci,`Name_Lang_esMX` text COLLATE utf8_unicode_ci,`Name_Lang_ruRU` text COLLATE utf8_unicode_ci,`Name_Lang_ptPT` text COLLATE utf8_unicode_ci,`Name_Lang_ptBR` text COLLATE utf8_unicode_ci,`Name_Lang_itIT` text COLLATE utf8_unicode_ci,`Name_Lang_Unk` text COLLATE utf8_unicode_ci,`Name_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',`InternalName` text COLLATE utf8_unicode_ci,`Enchantment_1` int(11) NOT NULL DEFAULT '0',`Enchantment_2` int(11) NOT NULL DEFAULT '0',`Enchantment_3` int(11) NOT NULL DEFAULT '0',`Enchantment_4` int(11) NOT NULL DEFAULT '0',`Enchantment_5` int(11) NOT NULL DEFAULT '0',`AllocationPct_1` int(11) NOT NULL DEFAULT '0',`AllocationPct_2` int(11) NOT NULL DEFAULT '0',`AllocationPct_3` int(11) NOT NULL DEFAULT '0',`AllocationPct_4` int(11) NOT NULL DEFAULT '0',`AllocationPct_5` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcSpellCastTimesSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_spell_cast_times` (`ID` int(11) NOT NULL DEFAULT '0',`Base` int(11) NOT NULL DEFAULT '0',`PerLevel` int(11) NOT NULL DEFAULT '0',`Minimum` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcSpellRangeSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_spell_range` (`ID` int(11) NOT NULL DEFAULT '0',`RangeMin_1` float NOT NULL DEFAULT '0',`RangeMin_2` float NOT NULL DEFAULT '0',`RangeMax_1` float NOT NULL DEFAULT '0',`RangeMax_2` float NOT NULL DEFAULT '0',`Flags` int(11) NOT NULL DEFAULT '0',`DisplayName_Lang_enUS` text COLLATE utf8_unicode_ci,`DisplayName_Lang_enGB` text COLLATE utf8_unicode_ci,`DisplayName_Lang_koKR` text COLLATE utf8_unicode_ci,`DisplayName_Lang_frFR` text COLLATE utf8_unicode_ci,`DisplayName_Lang_deDE` text COLLATE utf8_unicode_ci,`DisplayName_Lang_enCN` text COLLATE utf8_unicode_ci,`DisplayName_Lang_zhCN` text COLLATE utf8_unicode_ci,`DisplayName_Lang_enTW` text COLLATE utf8_unicode_ci,`DisplayName_Lang_zhTW` text COLLATE utf8_unicode_ci,`DisplayName_Lang_esES` text COLLATE utf8_unicode_ci,`DisplayName_Lang_esMX` text COLLATE utf8_unicode_ci,`DisplayName_Lang_ruRU` text COLLATE utf8_unicode_ci,`DisplayName_Lang_ptPT` text COLLATE utf8_unicode_ci,`DisplayName_Lang_ptBR` text COLLATE utf8_unicode_ci,`DisplayName_Lang_itIT` text COLLATE utf8_unicode_ci,`DisplayName_Lang_Unk` text COLLATE utf8_unicode_ci,`DisplayName_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',`DisplayNameShort_Lang_enUS` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_enGB` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_koKR` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_frFR` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_deDE` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_enCN` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_zhCN` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_enTW` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_zhTW` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_esES` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_esMX` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_ruRU` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_ptPT` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_ptBR` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_itIT` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_Unk` text COLLATE utf8_unicode_ci,`DisplayNameShort_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcSpellMechanicSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_spell_mechanic` (`ID` int(11) NOT NULL DEFAULT '0',`StateName_Lang_enUS` text COLLATE utf8_unicode_ci,`StateName_Lang_enGB` text COLLATE utf8_unicode_ci,`StateName_Lang_koKR` text COLLATE utf8_unicode_ci,`StateName_Lang_frFR` text COLLATE utf8_unicode_ci,`StateName_Lang_deDE` text COLLATE utf8_unicode_ci,`StateName_Lang_enCN` text COLLATE utf8_unicode_ci,`StateName_Lang_zhCN` text COLLATE utf8_unicode_ci,`StateName_Lang_enTW` text COLLATE utf8_unicode_ci,`StateName_Lang_zhTW` text COLLATE utf8_unicode_ci,`StateName_Lang_esES` text COLLATE utf8_unicode_ci,`StateName_Lang_esMX` text COLLATE utf8_unicode_ci,`StateName_Lang_ruRU` text COLLATE utf8_unicode_ci,`StateName_Lang_ptPT` text COLLATE utf8_unicode_ci,`StateName_Lang_ptBR` text COLLATE utf8_unicode_ci,`StateName_Lang_itIT` text COLLATE utf8_unicode_ci,`StateName_Lang_Unk` text COLLATE utf8_unicode_ci,`StateName_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcTalentSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_talent` (`ID` int(11) NOT NULL DEFAULT '0',`TabID` int(11) NOT NULL DEFAULT '0',`TierID` int(11) NOT NULL DEFAULT '0',`ColumnIndex` int(11) NOT NULL DEFAULT '0',`SpellRank_1` int(11) NOT NULL DEFAULT '0',`SpellRank_2` int(11) NOT NULL DEFAULT '0',`SpellRank_3` int(11) NOT NULL DEFAULT '0',`SpellRank_4` int(11) NOT NULL DEFAULT '0',`SpellRank_5` int(11) NOT NULL DEFAULT '0',`SpellRank_6` int(11) NOT NULL DEFAULT '0',`SpellRank_7` int(11) NOT NULL DEFAULT '0',`SpellRank_8` int(11) NOT NULL DEFAULT '0',`SpellRank_9` int(11) NOT NULL DEFAULT '0',`PrereqTalent_1` int(11) NOT NULL DEFAULT '0',`PrereqTalent_2` int(11) NOT NULL DEFAULT '0',`PrereqTalent_3` int(11) NOT NULL DEFAULT '0',`PrereqRank_1` int(11) NOT NULL DEFAULT '0',`PrereqRank_2` int(11) NOT NULL DEFAULT '0',`PrereqRank_3` int(11) NOT NULL DEFAULT '0',`Flags` int(11) NOT NULL DEFAULT '0',`RequiredSpellID` int(11) NOT NULL DEFAULT '0',`CategoryMask_1` int(11) NOT NULL DEFAULT '0',`CategoryMask_2` int(11) NOT NULL DEFAULT '0',PRIMARY KEY (`ID`)) ENGINE=MyISAM;";

exports.dbcTalentTabSql =
  "CREATE TABLE IF NOT EXISTS `foxy`.`dbc_talent_tab` (`ID` int(11) NOT NULL DEFAULT '0',`Name_Lang_enUS` text COLLATE utf8_unicode_ci,`Name_Lang_enGB` text COLLATE utf8_unicode_ci,`Name_Lang_koKR` text COLLATE utf8_unicode_ci,`Name_Lang_frFR` text COLLATE utf8_unicode_ci,`Name_Lang_deDE` text COLLATE utf8_unicode_ci,`Name_Lang_enCN` text COLLATE utf8_unicode_ci,`Name_Lang_zhCN` text COLLATE utf8_unicode_ci,`Name_Lang_enTW` text COLLATE utf8_unicode_ci,`Name_Lang_zhTW` text COLLATE utf8_unicode_ci,`Name_Lang_esES` text COLLATE utf8_unicode_ci,`Name_Lang_esMX` text COLLATE utf8_unicode_ci,`Name_Lang_ruRU` text COLLATE utf8_unicode_ci,`Name_Lang_ptPT` text COLLATE utf8_unicode_ci,`Name_Lang_ptBR` text COLLATE utf8_unicode_ci,`Name_Lang_itIT` text COLLATE utf8_unicode_ci,`Name_Lang_Unk` text COLLATE utf8_unicode_ci,`Name_Lang_Mask` int(10) unsigned NOT NULL DEFAULT '0',`SpellIconID` int(11) NOT NULL DEFAULT '0',`RaceMask` int(11) NOT NULL DEFAULT '0',`ClassMask` int(11) NOT NULL DEFAULT '0',`PetTalentMask` int(11) NOT NULL DEFAULT '0',`OrderIndex` int(11) NOT NULL DEFAULT '0',`BackgroundFile` text COLLATE utf8_unicode_ci,PRIMARY KEY (`ID`)) ENGINE=MyISAM;";
