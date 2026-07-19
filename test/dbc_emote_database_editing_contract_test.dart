import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_dbc_emote_entity.dart';
import 'package:foxy/entity/dbc_emote_entity.dart';
import 'package:foxy/entity/dbc_emote_key.dart';

void main() {
  test('DbcEmoteKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const first = DbcEmoteKey(id: 14);
    expect(first, const DbcEmoteKey(id: 14));
    expect(first.hashCode, const DbcEmoteKey(id: 14).hashCode);
    expect(first, isNot(const DbcEmoteKey(id: 15)));
    expect(DbcEmoteKey.fromEntity(const DbcEmoteEntity(id: 14)), first);
    expect(const BriefDbcEmoteEntity(id: 14).key, first);
  });

  test('DbcEmote Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/dbc_emote_repository.dart',
    ).readAsStringSync();
    expect(source, contains('Future<DbcEmoteKey> copyDbcEmote('));
    expect(source, contains('Future<void> storeDbcEmote('));
    expect(source, contains('if (emote.id <= 0)'));
    expect(source, contains('insert([emote.toJson()])'));
    expect(source, isNot(contains('Future<int> storeDbcEmote')));
    expect(source, isNot(contains('saveDbcEmote(')));
    expect(source, contains('DbcEmoteKey originalKey,'));
    expect(source, contains(').update(emote.toJson())'));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
  });
}
