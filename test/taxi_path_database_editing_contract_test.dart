import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_taxi_path_entity.dart';
import 'package:foxy/entity/taxi_path_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 21;
    expect((const TaxiPathEntity(id: 21)).id, first);
    expect(const BriefTaxiPathEntity(id: 21).key, first);
  });

  test('TaxiPath Repository 使用显式 Brief、创建键与原始更新键', () {
    final source = File(
      'lib/repository/taxi_path_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copyTaxiPath('));
    expect(source, contains("laconic.table(_table).select(["));
    expect(source, contains("'FromTaxiNode'"));
    expect(source, contains("'ToTaxiNode'"));
    expect(source, contains("'Cost'"));
    expect(source, contains('Future<void> storeTaxiPath('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeTaxiPath')));
    expect(source, isNot(contains('saveTaxiPath(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
