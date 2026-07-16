import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/entity/lock_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class LockRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_lock';

  Future<void> copyLock(int id) async {
    var source = await getLock(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<int> countLocks({LockFilterEntity? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<LockEntity> createLock() async {
    return LockEntity(id: await _getNextId());
  }

  Future<void> destroyLock(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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

  Future<LockEntity?> getLock(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return LockEntity.fromJson(results.first.toMap());
  }

  Future<List<LockEntity>> getLocks() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => LockEntity.fromJson(e.toMap())).toList();
  }

  Future<void> saveLock(LockEntity lock) async {
    if (lock.id == 0) {
      await storeLock(lock);
      return;
    }
    var existing = await getLock(lock.id);
    if (existing != null) {
      await updateLock(lock);
    } else {
      await laconic.table(_table).insert([lock.toJson()]);
    }
  }

  Future<int> storeLock(LockEntity lock) async {
    var json = lock.toJson();
    final nextId = lock.id > 0 ? lock.id : await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateLock(LockEntity lock) async {
    var json = lock.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', lock.id).update(json);
  }

  QueryBuilder _applyFilter(QueryBuilder builder, LockFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    return nextMaxPlusOne(_table, 'ID');
  }
}
