import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_item_enchantment_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const SpellItemEnchantmentEntity(id: 7)).id, key);
    expect(const BriefSpellItemEnchantmentEntity(id: 7).key, key);
  });

  test('SpellItemEnchantment 路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/spell_item_enchantment/spell_item_enchantment_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/spell_item_enchantment/spell_item_enchantment_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? spellItemEnchantmentKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });

  test('BriefSpellItemEnchantment 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_spell_item_enchantment_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
