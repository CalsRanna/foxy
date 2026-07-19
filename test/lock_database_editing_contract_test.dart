import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_lock_entity.dart';
import 'package:foxy/entity/lock_key.dart';

void main() {
  test('LockKey 使用 ID 值相等且 Brief 暴露定位器', () {
    const key = LockKey(id: 7);
    expect(key, const LockKey(id: 7));
    expect(key.hashCode, const LockKey(id: 7).hashCode);
    expect(const BriefLockEntity(id: 7).key, key);
  });

  test('Lock Repository 使用显式创建键与原始更新键', () {
    final source = File(
      'lib/repository/lock_repository.dart',
    ).readAsStringSync();
    expect(source, contains('LockKey key'));
    expect(source, contains('Future<void> storeLock('));
    expect(source, contains('LockKey originalKey'));
    expect(source, contains('.update(lock.toJson())'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains('saveLock(')));
    expect(source, isNot(contains("remove('ID')")));
  });

  test('BriefLock 不暴露候选写入 API', () {
    final source = File('lib/entity/brief_lock_entity.dart').readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
