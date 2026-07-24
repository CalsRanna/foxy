import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/dbc_emote_entity.dart';

void main() {
  test('Brief key 返回物理 ID 标量', () {
    const first = 14;
    expect((const DbcEmoteEntity(id: 14)).id, first);
    expect(const BriefDbcEmoteEntity(id: 14).key, first);
  });

  test('DbcEmote Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/dbc_emote_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<int> copyDbcEmote('));
    expect(source, contains('Future<void> storeDbcEmote('));
    expect(source, contains('if (emote.id <= 0)'));
    expect(source, contains('insert([emote.toJson()])'));
    expect(source, isNot(contains('Future<int> storeDbcEmote')));
    expect(source, isNot(contains('saveDbcEmote(')));
    expect(source, contains('int originalKey,'));
    expect(source, contains(').update(emote.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
