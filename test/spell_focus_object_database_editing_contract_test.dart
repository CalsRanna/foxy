import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 61;
    expect((const SpellFocusObjectEntity(id: 61)).id, first);
    expect(const BriefSpellFocusObjectEntity(id: 61).key, first);
    expect(
      const BriefSpellFocusObjectEntity(
        nameLangZhCN: '中文',
        nameLangEnUS: 'English',
      ).displayName,
      '中文',
    );
  });

  test('SpellFocusObject Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/spell_focus_object_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copySpellFocusObject('));
    expect(source, contains('Future<void> storeSpellFocusObject('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSpellFocusObject')));
    expect(source, isNot(contains('saveSpellFocusObject(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('storeDbcLocaleField(id, field, locales)'));
  });
}
