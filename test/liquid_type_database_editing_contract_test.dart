import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_liquid_type_entity.dart';
import 'package:foxy/entity/liquid_type_entity.dart';
import 'package:foxy/entity/liquid_type_key.dart';

void main() {
  test('LiquidTypeKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = LiquidTypeKey(id: 11);
    const same = LiquidTypeKey(id: 11);

    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(const LiquidTypeKey(id: 12)));
    expect(LiquidTypeKey.fromEntity(const LiquidTypeEntity(id: 11)), first);
    expect(const BriefLiquidTypeEntity(id: 11).key, first);
  });

  test('LiquidType Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/liquid_type_repository.dart',
    ).readAsStringSync();

    expect(source, contains('Future<LiquidTypeKey> copyLiquidType('));
    expect(source, contains('Future<void> storeLiquidType('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeLiquidType')));
    expect(source, isNot(contains('saveLiquidType(')));
    expect(source, isNot(contains('insertAndGetId')));

    expect(source, contains('LiquidTypeKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
