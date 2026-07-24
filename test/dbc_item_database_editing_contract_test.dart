import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/dbc_item_entity.dart';

void main() {
  test('DbcItem Entity 精确覆盖八个标量物理列', () {
    final json = const DbcItemEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'ClassID',
      'SubclassID',
      'Sound_override_subclassID',
      'Material',
      'DisplayInfoID',
      'InventoryType',
      'SheatheType',
    ]);
    final source = File('lib/entity/dbc_item_entity.dart').readAsStringSync();
    expect(source, isNot(contains('final Map<')));
    expect(DbcItemEntity.fromJson(json).toJson(), json);
  });

  test('Brief key 返回物理 ID 标量', () {
    const first = 51;
    expect((const DbcItemEntity(id: 51)).id, first);
    expect(const BriefDbcItemEntity(id: 51).key, first);
  });

  test('DbcItem Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/dbc_item_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copyDbcItem('));
    expect(source, contains('Future<void> storeDbcItem('));
    expect(source, contains('if (item.id <= 0)'));
    expect(source, contains('insert([item.toJson()])'));
    expect(source, isNot(contains('Future<int> storeDbcItem')));
    expect(source, isNot(contains('saveDbcItem(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(item.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
