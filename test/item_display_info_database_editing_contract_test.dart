import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/item_display_info_entity.dart';

void main() {
  test('Brief key 返回完整物理 ID 标量', () {
    expect(7, 7);
    expect(7.hashCode, 7.hashCode);
    expect(const BriefItemDisplayInfoEntity(id: 7).key, 7);
  });

  test('ItemDisplayInfo Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/item_display_info_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeItemDisplayInfo('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(info.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveItemDisplayInfo(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
