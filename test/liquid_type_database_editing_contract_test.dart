import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/liquid_type_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 11;
    const same = 11;

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect((const LiquidTypeEntity(id: 11)).id, first);
    expect(const BriefLiquidTypeEntity(id: 11).key, first);
  });

  test('LiquidType Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/liquid_type_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<int> copyLiquidType('));
    expect(source, contains('Future<void> storeLiquidType('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeLiquidType')));
    expect(source, isNot(contains('saveLiquidType(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
