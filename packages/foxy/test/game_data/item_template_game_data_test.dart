import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/item_constants.dart';
import 'package:foxy/constant/item_enums.dart';
import 'package:foxy/constant/item_flags.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/entity/item_loot_template_entity.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/repository/disenchant_loot_template_repository.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/repository/item_loot_template_repository.dart';
import 'package:foxy/repository/milling_loot_template_repository.dart';
import 'package:foxy/repository/prospecting_loot_template_repository.dart';

void main() {

  test('ItemTemplateEntity 成组列使用独立字段而不是数组', () {
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
  });

  test('item_template SQL 浮点类型和新建默认值正确', () {
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
  });

  test('StatsCount 按非零 stat_value 派生，不参与持久化', () {
    const entity = ItemTemplateEntity(
      statType1: 3,
      statValue1: 10,
      statType3: 7,
      statValue3: -5,
    );
    expect(entity.statsCount, 2);
    expect(entity.toJson(), isNot(contains('StatsCount')));
  });

  test('item_template 枚举、运行时保留值和 Flags 覆盖 AzerothCore 取值集', () {
    expect(ItemConstants.itemClasses, hasLength(17));
    expect(ItemConstants.itemInventoryTypes, hasLength(29));
    expect(ItemEnums.itemQualityOptions.keys.toSet(), {0, 1, 2, 3, 4, 5, 6, 7});
    expect(ItemEnums.itemBondingOptions.keys.toSet(), {0, 1, 2, 3, 4, 5});
    expect(ItemEnums.itemMaterialOptions.keys.toSet(), {
      for (var value = -1; value <= 8; value++) value,
    });
    expect(ItemEnums.itemSpellTriggerOptions.keys.toSet(), {0, 1, 2, 4, 5, 6});
    expect(ItemEnums.itemStatTypeOptions.keys.toSet(), {
      for (var value = 0; value < 49; value++) value,
    });
    expect(ItemEnums.itemStatTypeOptions[22], '近战被命中等级');
    expect(ItemEnums.itemStatTypeOptions[28], '近战急速等级');
    expect(ItemEnums.itemStatTypeOptions[40], contains('3.3.5a 未使用'));
    expect(ItemEnums.itemStatTypeOptions[41], contains('已弃用'));
    expect(ItemEnums.itemStatTypeOptions[42], contains('已弃用'));
    expect(ItemEnums.itemReputationRankOptions.keys.toSet(), {
      for (var value = 0; value < 8; value++) value,
    });
    expect(_valuesOf(ItemFlags.itemFlagOptions), _bits(0, 31));
    expect(_valuesOf(ItemFlags.itemFlagsExtraOptions), _bits(0, 31));
    expect(_valuesOf(ItemFlags.itemFlagsCustomOptions), {1, 2, 4});
    expect(_valuesOf(ItemFlags.itemBagFamilyOptions), _bits(0, 14));
    expect(_valuesOf(ItemFlags.itemSocketColorFlagOptions), {1, 2, 4, 8});
  });

  test('5 个关联 Tab 的 Entity 字段和复合主键正确', () {
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

  test('随机附魔组按 RandomProperty/RandomSuffix 使用正确 DBC', () {
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
  });

  test('item 模块所需 DBC 已纳入 required 定义', () {
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
  });
}

Set<int> _bits(int start, int end) => {
  for (var bit = start; bit <= end; bit++) 1 << bit,
};

Set<int> _valuesOf(List<FlagItem> flags) => {
  for (final flag in flags) flag.value,
};
