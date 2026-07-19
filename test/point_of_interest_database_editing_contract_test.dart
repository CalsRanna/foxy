import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_point_of_interest_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefPointOfInterestEntity(id: 7).key, key);
  });

  test('PointOfInterest Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/point_of_interest_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storePointOfInterest('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(entity.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('savePointOfInterest(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefPointOfInterest 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_point_of_interest_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
