import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_loot_template_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/repository/disenchant_loot_template_repository.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/repository/item_loot_template_repository.dart';
import 'package:foxy/repository/milling_loot_template_repository.dart';
import 'package:foxy/repository/prospecting_loot_template_repository.dart';

void main() {
  test(
    'ItemTemplateEntity represents repeated columns as individual fields',
    () {
      const entity = ItemTemplateEntity(
        statType10: 7,
        statValue10: 25,
        spellId5: 123,
        spellTrigger5: 2,
        socketColor3: 4,
        socketContent3: 456,
      );

      expect(entity.statType10, 7);
      expect(entity.statValue10, 25);
      expect(entity.spellId5, 123);
      expect(entity.spellTrigger5, 2);
      expect(entity.socketColor3, 4);
      expect(entity.socketContent3, 456);
      expect(entity.toJson()['stat_type10'], 7);
      expect(entity.toJson()['spellid_5'], 123);
      expect(entity.toJson()['socketColor_3'], 4);
    },
  );

  test(
    'item_template floating-point types and new-record defaults match SQL',
    () {
      final entity = const ItemTemplateEntity();
      final json = entity.toJson();

      expect(entity.statsCount, 0);
      expect(json['SoundOverrideSubclass'], -1);
      expect(json['BuyCount'], 1);
      expect(json['delay'], 1000);
      expect(json['RequiredDisenchantSkill'], -1);
      expect(json['RangedModRange'], isA<double>());
      expect(json['ArmorDamageModifier'], isA<double>());
      for (var i = 1; i <= 5; i++) {
        expect(json['spellppmRate_$i'], isA<double>());
        expect(json['spellcooldown_$i'], -1);
        expect(json['spellcategorycooldown_$i'], -1);
      }
    },
  );

  test('StatsCount is derived from nonzero stat_value fields and is excluded from persistence', () {
    const entity = ItemTemplateEntity(
      statType1: 3,
      statValue1: 10,
      statType3: 7,
      statValue3: -5,
    );
    expect(entity.statsCount, 2);
    expect(entity.toJson(), isNot(contains('StatsCount')));
  });

  test('Entities for the five related tabs use the correct fields and composite primary keys', () {
    expect(const ItemEnchantmentTemplateEntity().toJson().keys.toSet(), {
      'entry',
      'ench',
      'chance',
    });
    expect(const ItemLootTemplateEntity().toJson().keys.toSet(), {
      'Entry',
      'Item',
      'Reference',
      'Chance',
      'QuestRequired',
      'LootMode',
      'GroupId',
      'MinCount',
      'MaxCount',
      'Comment',
    });
    expect(ItemEnchantmentTemplateRepository.primaryKeyColumns, {
      'entry',
      'ench',
    });
    for (final columns in [
      ItemLootTemplateRepository.primaryKeyColumns,
      DisenchantLootTemplateRepository.primaryKeyColumns,
      ProspectingLootTemplateRepository.primaryKeyColumns,
      MillingLootTemplateRepository.primaryKeyColumns,
    ]) {
      expect(columns, {'Entry', 'Item'});
    }
  });

  test(
    'Random property and suffix groups use their corresponding DBC tables',
    () {
      expect(
        ItemEnchantmentTemplateRepository.dbcTableFor(
          ItemEnchantmentKind.randomProperty,
        ),
        'foxy.dbc_item_random_properties',
      );
      expect(
        ItemEnchantmentTemplateRepository.dbcTableFor(
          ItemEnchantmentKind.randomSuffix,
        ),
        'foxy.dbc_item_random_suffix',
      );
    },
  );

  test(
    'DBC definitions required by the item module are marked as required',
    () {
      expect(
        DbcDefinitions.byTable['dbc_item_bag_family']?.fileName,
        'ItemBagFamily.dbc',
      );
      expect(
        DbcDefinitions.byTable['dbc_item_limit_category']?.fileName,
        'ItemLimitCategory.dbc',
      );
      expect(
        DbcDefinitions.byTable['dbc_totem_category']?.fileName,
        'TotemCategory.dbc',
      );
      expect(DbcDefinitions.byTable['dbc_holidays']?.fileName, 'Holidays.dbc');
    },
  );
}
