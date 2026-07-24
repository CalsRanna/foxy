import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/entity/lock_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'lock_repository.g.dart';

@FoxyRepository(LockEntity)
@FoxyFilter.text('id')
class LockRepository with RepositoryMixin, _LockRepositoryMixin {
  static const _table = 'foxy.dbc_lock';

  Future<int> copyLock(int key) async {
    final source = await getLock(key);
    if (source == null) {
      throw StateError('原锁定义不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeLock(copied);
    return copied.id;
  }

  Future<int> countLocks({LockFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<LockEntity> createLock() async {
    return LockEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefLockEntity>> getBriefLocks({
    int page = 1,
    LockFilter? filter,
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

  Future<List<LockEntity>> getLocks() async {
    var results = await laconic.table(_table).get();
    return results.map((e) => LockEntity.fromJson(e.toMap())).toList();
  }

  QueryBuilder _applyFilter(QueryBuilder builder, LockFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
