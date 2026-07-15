import 'package:warcrafty/warcrafty.dart';

/// Foxy 支持同步的单个 DBC 定义。
///
/// DBC 的二进制结构仍以 [schema] 中的 warcrafty 定义为准；
/// Foxy 只在此补充对应的数据库表名。
class DbcDefinition {
  final String tableName;
  final DbcSchema schema;

  const DbcDefinition({required this.tableName, required this.schema});

  String get qualifiedTableName => 'foxy.$tableName';
  String get fileName => '${schema.name}.dbc';
}

final List<DbcDefinition> dbcDefinitions = List.unmodifiable([
  DbcDefinition(tableName: 'dbc_achievement', schema: Definitions.achievement),
  DbcDefinition(tableName: 'dbc_area_table', schema: Definitions.areaTable),
  DbcDefinition(tableName: 'dbc_char_titles', schema: Definitions.charTitles),
  DbcDefinition(
    tableName: 'dbc_cinematic_sequences',
    schema: Definitions.cinematicSequences,
  ),
  DbcDefinition(
    tableName: 'dbc_creature_display_info',
    schema: Definitions.creatureDisplayInfo,
  ),
  DbcDefinition(
    tableName: 'dbc_creature_model_data',
    schema: Definitions.creatureModelData,
  ),
  DbcDefinition(
    tableName: 'dbc_creature_movement_info',
    schema: Definitions.creatureMovementInfo,
  ),
  DbcDefinition(
    tableName: 'dbc_creature_spell_data',
    schema: Definitions.creatureSpellData,
  ),
  DbcDefinition(
    tableName: 'dbc_currency_category',
    schema: Definitions.currencyCategory,
  ),
  DbcDefinition(
    tableName: 'dbc_currency_types',
    schema: Definitions.currencyTypes,
  ),
  DbcDefinition(
    tableName: 'dbc_destructible_model_data',
    schema: Definitions.destructibleModelData,
  ),
  DbcDefinition(tableName: 'dbc_emotes_text', schema: Definitions.emotesText),
  DbcDefinition(
    tableName: 'dbc_emotes_text_data',
    schema: Definitions.emotesTextData,
  ),
  DbcDefinition(tableName: 'dbc_emotes', schema: Definitions.emotes),
  DbcDefinition(tableName: 'dbc_faction', schema: Definitions.faction),
  DbcDefinition(
    tableName: 'dbc_faction_template',
    schema: Definitions.factionTemplate,
  ),
  DbcDefinition(
    tableName: 'dbc_gem_properties',
    schema: Definitions.gemProperties,
  ),
  DbcDefinition(
    tableName: 'dbc_glyph_properties',
    schema: Definitions.glyphProperties,
  ),
  DbcDefinition(
    tableName: 'dbc_game_object_art_kit',
    schema: Definitions.gameObjectArtKit,
  ),
  DbcDefinition(
    tableName: 'dbc_game_object_display_info',
    schema: Definitions.gameObjectDisplayInfo,
  ),
  DbcDefinition(tableName: 'dbc_holidays', schema: Definitions.holidays),
  DbcDefinition(
    tableName: 'dbc_item_display_info',
    schema: Definitions.itemDisplayInfo,
  ),
  DbcDefinition(tableName: 'dbc_item', schema: Definitions.item),
  DbcDefinition(
    tableName: 'dbc_item_bag_family',
    schema: Definitions.itemBagFamily,
  ),
  DbcDefinition(
    tableName: 'dbc_item_extended_cost',
    schema: Definitions.itemExtendedCost,
  ),
  DbcDefinition(
    tableName: 'dbc_item_purchase_group',
    schema: Definitions.itemPurchaseGroup,
  ),
  DbcDefinition(
    tableName: 'dbc_item_limit_category',
    schema: Definitions.itemLimitCategory,
  ),
  DbcDefinition(
    tableName: 'dbc_item_random_properties',
    schema: Definitions.itemRandomProperties,
  ),
  DbcDefinition(
    tableName: 'dbc_item_random_suffix',
    schema: Definitions.itemRandomSuffix,
  ),
  DbcDefinition(tableName: 'dbc_item_set', schema: Definitions.itemSet),
  DbcDefinition(
    tableName: 'dbc_item_visual_effects',
    schema: Definitions.itemVisualEffects,
  ),
  DbcDefinition(tableName: 'dbc_item_visuals', schema: Definitions.itemVisuals),
  DbcDefinition(tableName: 'dbc_lock', schema: Definitions.lock),
  DbcDefinition(tableName: 'dbc_light', schema: Definitions.light),
  DbcDefinition(tableName: 'dbc_liquid_type', schema: Definitions.liquidType),
  DbcDefinition(
    tableName: 'dbc_mail_template',
    schema: Definitions.mailTemplate,
  ),
  DbcDefinition(tableName: 'dbc_map', schema: Definitions.map),
  DbcDefinition(
    tableName: 'dbc_quest_faction_reward',
    schema: Definitions.questFactionReward,
  ),
  DbcDefinition(tableName: 'dbc_quest_info', schema: Definitions.questInfo),
  DbcDefinition(tableName: 'dbc_quest_sort', schema: Definitions.questSort),
  DbcDefinition(
    tableName: 'dbc_scaling_stat_distribution',
    schema: Definitions.scalingStatDistribution,
  ),
  DbcDefinition(
    tableName: 'dbc_scaling_stat_values',
    schema: Definitions.scalingStatValues,
  ),
  DbcDefinition(tableName: 'dbc_spell', schema: Definitions.spell),
  DbcDefinition(
    tableName: 'dbc_spell_focus_object',
    schema: Definitions.spellFocusObject,
  ),
  DbcDefinition(
    tableName: 'dbc_spell_duration',
    schema: Definitions.spellDuration,
  ),
  DbcDefinition(tableName: 'dbc_spell_icon', schema: Definitions.spellIcon),
  DbcDefinition(
    tableName: 'dbc_spell_item_enchantment',
    schema: Definitions.spellItemEnchantment,
  ),
  DbcDefinition(
    tableName: 'dbc_spell_item_enchantment_condition',
    schema: Definitions.spellItemEnchantmentCondition,
  ),
  DbcDefinition(tableName: 'dbc_spell_range', schema: Definitions.spellRange),
  DbcDefinition(tableName: 'dbc_skill_line', schema: Definitions.skillLine),
  DbcDefinition(
    tableName: 'dbc_sound_ambience',
    schema: Definitions.soundAmbience,
  ),
  DbcDefinition(
    tableName: 'dbc_sound_provider_preferences',
    schema: Definitions.soundProviderPreferences,
  ),
  DbcDefinition(tableName: 'dbc_talent', schema: Definitions.talent),
  DbcDefinition(tableName: 'dbc_talent_tab', schema: Definitions.talentTab),
  DbcDefinition(tableName: 'dbc_taxi_path', schema: Definitions.taxiPath),
  DbcDefinition(
    tableName: 'dbc_totem_category',
    schema: Definitions.totemCategory,
  ),
  DbcDefinition(tableName: 'dbc_vehicle', schema: Definitions.vehicle),
  DbcDefinition(tableName: 'dbc_zone_music', schema: Definitions.zoneMusic),
  DbcDefinition(
    tableName: 'dbc_zone_intro_music_table',
    schema: Definitions.zoneIntroMusicTable,
  ),
]);

final Map<String, DbcDefinition> dbcDefinitionByTable = Map.unmodifiable({
  for (final definition in dbcDefinitions) definition.tableName: definition,
});

final Map<String, DbcDefinition> dbcDefinitionByFileName = Map.unmodifiable({
  for (final definition in dbcDefinitions)
    definition.fileName.toLowerCase(): definition,
});

final List<String> requiredDbcTableNames = List.unmodifiable(
  dbcDefinitions.map((definition) => definition.tableName),
);
