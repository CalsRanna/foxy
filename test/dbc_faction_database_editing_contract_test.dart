import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/dbc_faction_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const key = 7;
    expect(const BriefDbcFactionEntity(id: 7).key, key);
  });

  test('DbcFaction Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/dbc_faction_repository.dart',
    ).readAsStringSync();
    expect(source, contains('int key'));
    expect(source, contains('Future<void> storeDbcFaction('));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(faction.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveDbcFactionLocales('));
    expect(source, isNot(contains('saveDbcFaction(')));
    expect(source, isNot(contains("remove('ID')")));
  });
}
