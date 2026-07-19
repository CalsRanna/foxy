import 'package:foxy/entity/brief_lock_entity.dart';
import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/entity/lock_filter_entity.dart';
import 'package:foxy/entity/lock_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class LockRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_lock';

  Future<LockKey> copyLock(LockKey key) async {
    final source = await getLock(key);
    if (source == null) {
      throw StateError('原锁定义不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeLock(copied);
    return LockKey.fromEntity(copied);
  }

  Future<int> countLocks({LockFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<LockEntity> createLock() async {
    return LockEntity(id: await _getNextId());
  }

  Future<void> destroyLock(LockKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原锁定义不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefLockEntity>> getBriefLocks({
    int page = 1,
    LockFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select(['ID', 'Type0', 'Index0', 'Skill0']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) => BriefLockEntity.fromJson(e.toMap())).toList();
  }

  Future<LockEntity?> getLock(LockKey key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return LockEntity.fromJson(results.first.toMap());
  }

  Future<List<LockEntity>> getLocks() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => LockEntity.fromJson(e.toMap())).toList();
  }

  Future<void> storeLock(LockEntity lock) async {
    if (lock.id <= 0) {
      throw StateError('锁定义 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([lock.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('锁定义 ${lock.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateLock(LockKey originalKey, LockEntity lock) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(lock.toJson());
      if (matchedRows == 0) {
        throw StateError('原锁定义不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的锁定义 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, LockFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() => nextMaxPlusOne(_table, 'ID');

  QueryBuilder _whereKey(QueryBuilder builder, LockKey key) {
    return builder.where('ID', key.id);
  }
}
