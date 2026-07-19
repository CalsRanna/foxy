import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_focus_object_entity.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';
import 'package:foxy/entity/spell_focus_object_key.dart';

void main() {
  test('SpellFocusObjectKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = SpellFocusObjectKey(id: 61);
    expect(first, const SpellFocusObjectKey(id: 61));
    expect(first.hashCode, const SpellFocusObjectKey(id: 61).hashCode);
    expect(first, isNot(const SpellFocusObjectKey(id: 62)));
    expect(
      SpellFocusObjectKey.fromEntity(const SpellFocusObjectEntity(id: 61)),
      first,
    );
    expect(const BriefSpellFocusObjectEntity(id: 61).key, first);
  });

  test('SpellFocusObject Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/spell_focus_object_repository.dart',
    ).readAsStringSync();
    expect(
      source,
      contains('Future<SpellFocusObjectKey> copySpellFocusObject('),
    );
    expect(source, contains('Future<void> storeSpellFocusObject('));
    expect(source, contains('if (entity.id <= 0)'));
    expect(source, contains('insert([entity.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSpellFocusObject')));
    expect(source, isNot(contains('saveSpellFocusObject(')));
    expect(source, contains('SpellFocusObjectKey originalKey,'));
    expect(source, contains(').update(entity.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, contains('storeDbcLocaleField(id, field, locales)'));
  });
}
