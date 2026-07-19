import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_item_random_suffix_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefItemRandomSuffixEntity(id: 7).key, key);
  });

  test('ItemRandomSuffix Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/item_random_suffix_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeItemRandomSuffix('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(suffix.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveItemRandomSuffixLocales('));
    expect(source, isNot(contains('saveItemRandomSuffix(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefItemRandomSuffix 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_item_random_suffix_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
