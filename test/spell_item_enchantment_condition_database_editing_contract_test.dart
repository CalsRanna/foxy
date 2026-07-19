import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_item_enchantment_condition_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_key.dart';

void main() {
  test('SpellItemEnchantmentConditionKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = SpellItemEnchantmentConditionKey(id: 7);
    expect(key, const SpellItemEnchantmentConditionKey(id: 7));
    expect(
      key.hashCode,
      const SpellItemEnchantmentConditionKey(id: 7).hashCode,
    );
    expect(const BriefSpellItemEnchantmentConditionEntity(id: 7).key, key);
  });

  test('SpellItemEnchantmentCondition Repository 使用显式键和单表边界', () {
    final source = File(
      'lib/repository/spell_item_enchantment_condition_repository.dart',
    ).readAsStringSync();
    expect(source, contains('SpellItemEnchantmentConditionKey key'));
    expect(
      source,
      contains('Future<void> storeSpellItemEnchantmentCondition('),
    );
    expect(source, contains('SpellItemEnchantmentConditionKey originalKey'));
    expect(source, contains('.update(entity.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveSpellItemEnchantmentCondition(')));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, isNot(contains("table('foxy.dbc_spell_item_enchantment')")));
  });

  test('BriefSpellItemEnchantmentCondition 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_spell_item_enchantment_condition_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
