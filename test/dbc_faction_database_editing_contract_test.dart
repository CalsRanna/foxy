import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_dbc_faction_entity.dart';
import 'package:foxy/entity/dbc_faction_key.dart';

void main() {
  test('DbcFactionKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = DbcFactionKey(id: 7);
    expect(key, const DbcFactionKey(id: 7));
    expect(key.hashCode, const DbcFactionKey(id: 7).hashCode);
    expect(const BriefDbcFactionEntity(id: 7).key, key);
  });

  test('DbcFaction Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/dbc_faction_repository.dart',
    ).readAsStringSync();
    expect(source, contains('DbcFactionKey key'));
    expect(source, contains('Future<void> storeDbcFaction('));
    expect(source, contains('DbcFactionKey originalKey'));
    expect(source, contains('.update(faction.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('saveDbcFactionLocales('));
    expect(source, isNot(contains('saveDbcFaction(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefDbcFaction 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_dbc_faction_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
