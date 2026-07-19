import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_broadcast_text_entity.dart';
import 'package:foxy/entity/broadcast_text_key.dart';

void main() {
  test('BroadcastTextKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = BroadcastTextKey(id: 7);
    expect(key, const BroadcastTextKey(id: 7));
    expect(key.hashCode, const BroadcastTextKey(id: 7).hashCode);
    expect(const BriefBroadcastTextEntity(id: 7).key, key);
  });

  test('BroadcastText Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/broadcast_text_repository.dart',
    ).readAsStringSync();
    expect(source, contains('BroadcastTextKey key'));
    expect(source, contains('Future<void> storeBroadcastText('));
    expect(source, contains('BroadcastTextKey originalKey'));
    expect(source, contains('.update(text.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveBroadcastText(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefBroadcastText 不暴露候选写入 API', () {
    final source = File(
      'lib/entity/brief_broadcast_text_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
