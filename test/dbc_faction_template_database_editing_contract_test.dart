import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_dbc_faction_template_entity.dart';
import 'package:foxy/entity/dbc_faction_template_key.dart';

void main() {
  test('DbcFactionTemplateKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = DbcFactionTemplateKey(id: 7);
    expect(key, const DbcFactionTemplateKey(id: 7));
    expect(key.hashCode, const DbcFactionTemplateKey(id: 7).hashCode);
    expect(const BriefDbcFactionTemplateEntity(id: 7).key, key);
  });

  test('DbcFactionTemplate Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/dbc_faction_template_repository.dart',
    ).readAsStringSync();
    expect(source, contains('DbcFactionTemplateKey key'));
    expect(source, contains('Future<void> storeDbcFactionTemplate('));
    expect(source, contains('DbcFactionTemplateKey originalKey'));
    expect(source, contains('.update(factionTemplate.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveDbcFactionTemplate(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefDbcFactionTemplate 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_dbc_faction_template_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
