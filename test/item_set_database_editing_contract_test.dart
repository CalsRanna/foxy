import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_set_entity.dart';
import 'package:foxy/entity/item_set_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect((const ItemSetEntity(id: 7)).id, key);
    expect(const BriefItemSetEntity(id: 7).key, key);
  });

  test('ItemSet 路由只携带标量 key 且列表传 brief.key', () {
    final page = File(
      'lib/page/item_set/item_set_detail_page.dart',
    ).readAsStringSync();
    final list = File(
      'lib/page/item_set/item_set_list_page.dart',
    ).readAsStringSync();
    expect(page, contains('final int? itemSetKey'));
    expect(page, contains('viewModel.persistedKey.value'));
    expect(list, contains('items[row].key'));
  });
}
