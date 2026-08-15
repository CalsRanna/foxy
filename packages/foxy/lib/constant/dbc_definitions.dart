import 'package:warcrafty/warcrafty.dart';

abstract final class DbcDefinitions {
  static final List<String> requiredTableNames = List.unmodifiable(
    all.map((definition) => definition.tableName),
  );

  static final List<DbcDefinition> all = List.unmodifiable([
    DbcDefinition(
      tableName: 'dbc_achievement',
      schema: Definitions.achievement,
    ),
    DbcDefinition(
      tableName: 'dbc_achievement_category',
      schema: Definitions.achievementCategory,
    ),
    DbcDefinition(
      tableName: 'dbc_achievement_criteria',
      schema: Definitions.achievementCriteria,
    ),
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
    DbcDefinition(
      tableName: 'dbc_item_visuals',
      schema: Definitions.itemVisuals,
    ),
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
      tableName: 'dbc_skill_line_ability',
      schema: Definitions.skillLineAbility,
    ),
    DbcDefinition(
      tableName: 'dbc_skill_line_category',
      schema: Definitions.skillLineCategory,
    ),
    DbcDefinition(
      tableName: 'dbc_skill_costs_data',
      schema: Definitions.skillCostsData,
    ),
    DbcDefinition(tableName: 'dbc_skill_tiers', schema: Definitions.skillTiers),
    DbcDefinition(
      tableName: 'dbc_skill_race_class_info',
      schema: Definitions.skillRaceClassInfo,
    ),
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

  static final Map<String, DbcDefinition> byTable = Map.unmodifiable({
    for (final definition in all) definition.tableName: definition,
  });

  static final Map<String, DbcDefinition> byFileName = Map.unmodifiable({
    for (final definition in all) definition.fileName.toLowerCase(): definition,
  });

  /// Discovers all locale-field prefixes (e.g. `Name_lang`) from
  /// [schema].
  ///
  /// Inferred by matching `*_lang_enUS` string columns; used by the
  /// coverage-completeness tests.
  static Set<String> discoverColumnPrefixes(DbcSchema schema) {
    final prefixes = <String>{};
    for (final field in schema.fields) {
      if (!field.type.isString) continue;
      const suffix = '_enUS';
      if (!field.name.endsWith(suffix)) continue;
      // Name_lang_enUS → Name_lang
      final withoutLocale = field.name.substring(
        0,
        field.name.length - suffix.length,
      );
      if (!withoutLocale.endsWith('_lang')) continue;
      prefixes.add(withoutLocale);
    }
    return prefixes;
  }
}

/// A single DBC definition Foxy supports syncing.
///
/// The binary structure of a DBC still follows the warcrafty definition in
/// [schema]; Foxy only adds the corresponding database table name here.
class DbcDefinition {
  final String tableName;
  final DbcSchema schema;

  const DbcDefinition({required this.tableName, required this.schema});

  String get fileName => '${schema.name}.dbc';
  String get qualifiedTableName => 'foxy.$tableName';
}
