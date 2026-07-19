import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_icon_entity.dart';
import 'package:foxy/entity/spell_icon_entity.dart';
import 'package:foxy/entity/spell_icon_key.dart';

void main() {
  test('SpellIconKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = SpellIconKey(id: 71);
    expect(first, const SpellIconKey(id: 71));
    expect(first.hashCode, const SpellIconKey(id: 71).hashCode);
    expect(first, isNot(const SpellIconKey(id: 72)));
    expect(SpellIconKey.fromEntity(const SpellIconEntity(id: 71)), first);
    expect(const BriefSpellIconEntity(id: 71).key, first);
  });

  test('SpellIcon Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/spell_icon_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<SpellIconKey> copySpellIcon('));
    expect(source, contains('Future<void> storeSpellIcon('));
    expect(source, contains('if (icon.id <= 0)'));
    expect(source, contains('insert([icon.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSpellIcon')));
    expect(source, isNot(contains('saveSpellIcon(')));
    expect(source, contains('SpellIconKey originalKey,'));
    expect(source, contains(').update(icon.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });

  test('BriefSpellIcon 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_spell_icon_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson')));
    expect(source, isNot(contains('copyWith')));
  });
}
