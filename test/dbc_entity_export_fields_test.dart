import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/creature_display_info_entity.dart';
import 'package:foxy/entity/creature_model_data_entity.dart';
import 'package:foxy/entity/creature_spell_data_entity.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/entity/scaling_stat_value_entity.dart';
import 'package:foxy/entity/spell_duration_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_range_entity.dart';
import 'package:foxy/entity/talent_entity.dart';
import 'package:foxy/entity/vehicle_entity.dart';
import 'package:warcrafty/warcrafty.dart';

Map<String, dynamic> _emptyEntityJson(String tableName) {
  return switch (tableName) {
    'dbc_achievement' => const AchievementEntity().toJson(),
    'dbc_area_table' => const AreaTableEntity().toJson(),
    'dbc_char_titles' => const CharTitleEntity().toJson(),
    'dbc_creature_display_info' => const CreatureDisplayInfoEntity().toJson(),
    'dbc_creature_model_data' => const CreatureModelDataEntity().toJson(),
    'dbc_creature_spell_data' => const CreatureSpellDataEntity().toJson(),
    'dbc_currency_types' => const CurrencyTypeEntity().toJson(),
    'dbc_emotes_text' => const EmoteTextEntity().toJson(),
    'dbc_faction' => const DbcFactionEntity().toJson(),
    'dbc_gem_properties' => const GemPropertyEntity().toJson(),
    'dbc_glyph_properties' => const GlyphPropertyEntity().toJson(),
    'dbc_item_display_info' => const ItemDisplayInfoEntity().toJson(),
    'dbc_item_extended_cost' => const ItemExtendedCostEntity().toJson(),
    'dbc_item_random_properties' =>
      const ItemRandomPropertiesEntity().toJson(),
    'dbc_item_random_suffix' => const ItemRandomSuffixEntity().toJson(),
    'dbc_item_set' => const ItemSetEntity().toJson(),
    'dbc_lock' => const LockEntity().toJson(),
    'dbc_map' => const MapInfoEntity().toJson(),
    'dbc_quest_faction_reward' => const QuestFactionRewardEntity().toJson(),
    'dbc_quest_info' => const QuestInfoEntity().toJson(),
    'dbc_quest_sort' => const QuestSortEntity().toJson(),
    'dbc_scaling_stat_distribution' =>
      const ScalingStatDistributionEntity().toJson(),
    'dbc_scaling_stat_values' => const ScalingStatValueEntity().toJson(),
    'dbc_spell' => const SpellEntity().toJson(),
    'dbc_spell_duration' => const SpellDurationEntity().toJson(),
    'dbc_spell_icon' => const SpellIconEntity().toJson(),
    'dbc_spell_item_enchantment' =>
      const SpellItemEnchantmentEntity().toJson(),
    'dbc_spell_range' => const SpellRangeEntity().toJson(),
    'dbc_talent' => const TalentEntity().toJson(),
    'dbc_vehicle' => const VehicleEntity().toJson(),
    _ => throw StateError('未覆盖的导出表: $tableName'),
  };
}

Map<String, dynamic> _sampleRow(DbcDefinition definition) {
  final row = <String, dynamic>{};
  for (final field in definition.schema.fields) {
    if (field.type.isSkip || field.type == FieldType.sort) continue;
    switch (field.type) {
      case FieldType.string:
        row[field.name] = 'sample-${field.name}';
      case FieldType.float:
        row[field.name] = 1.5;
      default:
        row[field.name] = field.name == 'ID' ? 42 : 7;
    }
  }
  return row;
}

Map<String, dynamic> _roundTrip(String tableName, Map<String, dynamic> row) {
  return switch (tableName) {
    'dbc_achievement' => AchievementEntity.fromJson(row).toJson(),
    'dbc_area_table' => AreaTableEntity.fromJson(row).toJson(),
    'dbc_char_titles' => CharTitleEntity.fromJson(row).toJson(),
    'dbc_creature_display_info' =>
      CreatureDisplayInfoEntity.fromJson(row).toJson(),
    'dbc_creature_model_data' => CreatureModelDataEntity.fromJson(row).toJson(),
    'dbc_creature_spell_data' => CreatureSpellDataEntity.fromJson(row).toJson(),
    'dbc_currency_types' => CurrencyTypeEntity.fromJson(row).toJson(),
    'dbc_emotes_text' => EmoteTextEntity.fromJson(row).toJson(),
    'dbc_faction' => DbcFactionEntity.fromJson(row).toJson(),
    'dbc_gem_properties' => GemPropertyEntity.fromJson(row).toJson(),
    'dbc_glyph_properties' => GlyphPropertyEntity.fromJson(row).toJson(),
    'dbc_item_display_info' => ItemDisplayInfoEntity.fromJson(row).toJson(),
    'dbc_item_extended_cost' => ItemExtendedCostEntity.fromJson(row).toJson(),
    'dbc_item_random_properties' =>
      ItemRandomPropertiesEntity.fromJson(row).toJson(),
    'dbc_item_random_suffix' => ItemRandomSuffixEntity.fromJson(row).toJson(),
    'dbc_item_set' => ItemSetEntity.fromJson(row).toJson(),
    'dbc_lock' => LockEntity.fromJson(row).toJson(),
    'dbc_map' => MapInfoEntity.fromJson(row).toJson(),
    'dbc_quest_faction_reward' =>
      QuestFactionRewardEntity.fromJson(row).toJson(),
    'dbc_quest_info' => QuestInfoEntity.fromJson(row).toJson(),
    'dbc_quest_sort' => QuestSortEntity.fromJson(row).toJson(),
    'dbc_scaling_stat_distribution' =>
      ScalingStatDistributionEntity.fromJson(row).toJson(),
    'dbc_scaling_stat_values' => ScalingStatValueEntity.fromJson(row).toJson(),
    'dbc_spell' => SpellEntity.fromJson(row).toJson(),
    'dbc_spell_duration' => SpellDurationEntity.fromJson(row).toJson(),
    'dbc_spell_icon' => SpellIconEntity.fromJson(row).toJson(),
    'dbc_spell_item_enchantment' =>
      SpellItemEnchantmentEntity.fromJson(row).toJson(),
    'dbc_spell_range' => SpellRangeEntity.fromJson(row).toJson(),
    'dbc_talent' => TalentEntity.fromJson(row).toJson(),
    'dbc_vehicle' => VehicleEntity.fromJson(row).toJson(),
    _ => throw StateError('未覆盖的导出表: $tableName'),
  };
}

void main() {
  test('全部 30 张 DBC 表：默认 toJson 覆盖 Schema 全部必需字段', () {
    expect(dbcDefinitions, hasLength(30));

    for (final definition in dbcDefinitions) {
      final json = _emptyEntityJson(definition.tableName);
      final missing = <String>[];
      for (final field in definition.schema.fields) {
        if (field.type.isSkip || field.type == FieldType.sort) continue;
        if (!json.containsKey(field.name)) missing.add(field.name);
      }
      expect(
        missing,
        isEmpty,
        reason: '${definition.tableName} 缺少: ${missing.join(', ')}',
      );
    }
  });

  test('全部 30 张 DBC 表：fromJson/toJson round-trip 保留字段取值', () {
    for (final definition in dbcDefinitions) {
      final sample = _sampleRow(definition);
      final json = _roundTrip(definition.tableName, sample);
      for (final field in definition.schema.fields) {
        if (field.type.isSkip || field.type == FieldType.sort) continue;
        expect(
          json[field.name],
          sample[field.name],
          reason: '${definition.tableName}.${field.name}',
        );
      }
    }
  });
}
