import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_spell_duration_entity.dart';
import 'package:foxy/entity/spell_duration_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 81;
    expect((const SpellDurationEntity(id: 81)).id, first);
    expect(const BriefSpellDurationEntity(id: 81).key, first);
  });

  test('SpellDuration Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/spell_duration_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copySpellDuration('));
    expect(source, contains('Future<void> storeSpellDuration('));
    expect(source, contains('if (duration.id <= 0)'));
    expect(source, contains('insert([duration.toJson()])'));
    expect(source, isNot(contains('Future<int> storeSpellDuration')));
    expect(source, isNot(contains('saveSpellDuration(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(duration.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });

  test('BriefSpellDuration 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_spell_duration_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson')));
    expect(source, isNot(contains('copyWith')));
  });
}
