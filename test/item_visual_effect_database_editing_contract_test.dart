import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_visual_effect_entity.dart';
import 'package:foxy/entity/item_visual_effect_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 31;
    expect((const ItemVisualEffectEntity(id: 31)).id, first);
    expect(const BriefItemVisualEffectEntity(id: 31).key, first);
  });

  test('ItemVisualEffect Repository 使用原始键且写入只触及自身表', () {
    final source = File(
      'lib/repository/item_visual_effect_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copyItemVisualEffect('));
    expect(source, contains('Future<void> storeItemVisualEffect('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeItemVisualEffect')));
    expect(source, isNot(contains('saveItemVisualEffect(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('foxy.dbc_item_visuals')));
    expect(source, isNot(contains('_countSlot')));
  });
}
