import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';
import 'package:foxy/entity/item_display_info_entity.dart';
import 'package:foxy/entity/item_random_properties_entity.dart';
import 'package:foxy/entity/item_random_suffix_entity.dart';
import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/entity/map_info_entity.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_range_entity.dart';
import 'package:warcrafty/warcrafty.dart';

Map<String, dynamic> _emptyEntityJson(String tableName) {
  return switch (tableName) {
    'dbc_area_table' => const AreaTableEntity().toJson(),
    'dbc_char_titles' => const CharTitleEntity().toJson(),
    'dbc_faction' => const DbcFactionEntity().toJson(),
    'dbc_item_display_info' => const ItemDisplayInfoEntity().toJson(),
    'dbc_item_random_properties' =>
      const ItemRandomPropertiesEntity().toJson(),
    'dbc_item_random_suffix' => const ItemRandomSuffixEntity().toJson(),
    'dbc_lock' => const LockEntity().toJson(),
    'dbc_map' => const MapInfoEntity().toJson(),
    'dbc_quest_info' => const QuestInfoEntity().toJson(),
    'dbc_quest_sort' => const QuestSortEntity().toJson(),
    'dbc_spell' => const SpellEntity().toJson(),
    'dbc_spell_item_enchantment' =>
      const SpellItemEnchantmentEntity().toJson(),
    'dbc_spell_range' => const SpellRangeEntity().toJson(),
    _ => throw StateError('未覆盖的表: $tableName'),
  };
}

Map<String, dynamic> _roundTripJson(
  String tableName,
  Map<String, dynamic> row,
) {
  return switch (tableName) {
    'dbc_area_table' => AreaTableEntity.fromJson(row).toJson(),
    'dbc_char_titles' => CharTitleEntity.fromJson(row).toJson(),
    'dbc_faction' => DbcFactionEntity.fromJson(row).toJson(),
    'dbc_item_display_info' => ItemDisplayInfoEntity.fromJson(row).toJson(),
    'dbc_item_random_properties' =>
      ItemRandomPropertiesEntity.fromJson(row).toJson(),
    'dbc_item_random_suffix' => ItemRandomSuffixEntity.fromJson(row).toJson(),
    'dbc_lock' => LockEntity.fromJson(row).toJson(),
    'dbc_map' => MapInfoEntity.fromJson(row).toJson(),
    'dbc_quest_info' => QuestInfoEntity.fromJson(row).toJson(),
    'dbc_quest_sort' => QuestSortEntity.fromJson(row).toJson(),
    'dbc_spell' => SpellEntity.fromJson(row).toJson(),
    'dbc_spell_item_enchantment' =>
      SpellItemEnchantmentEntity.fromJson(row).toJson(),
    'dbc_spell_range' => SpellRangeEntity.fromJson(row).toJson(),
    _ => throw StateError('未覆盖的表: $tableName'),
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

void main() {
  const targets = {
    'dbc_area_table',
    'dbc_char_titles',
    'dbc_faction',
    'dbc_item_display_info',
    'dbc_item_random_properties',
    'dbc_item_random_suffix',
    'dbc_lock',
    'dbc_map',
    'dbc_quest_info',
    'dbc_quest_sort',
    'dbc_spell',
    'dbc_spell_item_enchantment',
    'dbc_spell_range',
  };

  test('默认构造的 Entity.toJson 包含 Schema 全部必需字段（无 dbcRow 捷径）', () {
    for (final definition in dbcDefinitions) {
      if (!targets.contains(definition.tableName)) continue;

      final json = _emptyEntityJson(definition.tableName);
      final missing = <String>[];
      for (final field in definition.schema.fields) {
        if (field.type.isSkip || field.type == FieldType.sort) continue;
        if (!json.containsKey(field.name)) missing.add(field.name);
      }

      expect(
        missing,
        isEmpty,
        reason: '${definition.tableName} 默认 toJson 缺少: ${missing.join(', ')}',
      );
    }
  });

  test('fromJson/toJson round-trip 保留全部 Schema 字段与取值', () {
    for (final definition in dbcDefinitions) {
      if (!targets.contains(definition.tableName)) continue;

      final sample = _sampleRow(definition);
      final json = _roundTripJson(definition.tableName, sample);

      for (final field in definition.schema.fields) {
        if (field.type.isSkip || field.type == FieldType.sort) continue;
        expect(
          json.containsKey(field.name),
          isTrue,
          reason: '${definition.tableName} 缺少 ${field.name}',
        );
        expect(
          json[field.name],
          sample[field.name],
          reason: '${definition.tableName}.${field.name} 取值未保留',
        );
      }
    }
  });
}
