import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_display_info_entity.dart';
import 'package:foxy/entity/item_display_info_key.dart';

void main() {
  test('ItemDisplayInfoKey 使用 ID 值相等且 Brief 暴露完整定位器', () {
    expect(const ItemDisplayInfoKey(id: 7), const ItemDisplayInfoKey(id: 7));
    expect(
      const ItemDisplayInfoKey(id: 7).hashCode,
      const ItemDisplayInfoKey(id: 7).hashCode,
    );
    expect(
      const BriefItemDisplayInfoEntity(id: 7).key,
      const ItemDisplayInfoKey(id: 7),
    );
  });

  test('ItemDisplayInfo Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/item_display_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('ItemDisplayInfoKey key'));
    expect(source, contains('Future<void> storeItemDisplayInfo('));
    expect(source, contains('ItemDisplayInfoKey originalKey'));
    expect(source, contains('.update(info.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveItemDisplayInfo(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefItemDisplayInfo 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_item_display_info_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
