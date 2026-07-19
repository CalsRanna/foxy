import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_set_entity.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/item_set_key.dart';

void main() {
  test('ItemSetKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = ItemSetKey(id: 7);
    expect(key, const ItemSetKey(id: 7));
    expect(key.hashCode, const ItemSetKey(id: 7).hashCode);
    expect(ItemSetKey.fromEntity(const ItemSetEntity(id: 7)), key);
    expect(const BriefItemSetEntity(id: 7).key, key);
  });

  test('ItemSet 路由只携带 typed key 且列表传 brief.key', () {
    final page = File(
      'lib/page/item_set/item_set_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/item_set/item_set_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final ItemSetKey? itemSetKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });

  test('BriefItemSet 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_item_set_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
