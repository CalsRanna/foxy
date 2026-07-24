import 'package:foxy/entity/creature_movement_info_entity.dart';
import 'package:foxy/entity/creature_movement_info_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureMovementInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_movement_info';

  Future<int> copyCreatureMovementInfo(int key) async {
    final source = await getCreatureMovementInfo(key);
    if (source == null) {
      throw StateError('原生物移动信息不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeCreatureMovementInfo(copied);
    return copied.id;
  }

  Future<int> countCreatureMovementInfos({
    CreatureMovementInfoFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureMovementInfoEntity> createCreatureMovementInfo() async {
    return CreatureMovementInfoEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyCreatureMovementInfo(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物移动信息不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureMovementInfoEntity>> getBriefCreatureMovementInfos({
    int page = 1,
    CreatureMovementInfoFilterEntity? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select(['ID', 'SmoothFacingChaseRate']);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    final results = await builder.get();
    return results
        .map((row) => BriefCreatureMovementInfoEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<CreatureMovementInfoEntity?> getCreatureMovementInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureMovementInfoEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureMovementInfoEntity>> getCreatureMovementInfos() async {
    final results = await laconic.table(_table).get();
    return results
        .map((row) => CreatureMovementInfoEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeCreatureMovementInfo(
    CreatureMovementInfoEntity movementInfo,
  ) async {
    if (movementInfo.id <= 0) {
      throw StateError('生物移动信息 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([movementInfo.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物移动信息 ${movementInfo.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureMovementInfo(
    int originalKey,
    CreatureMovementInfoEntity movementInfo,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(movementInfo.toJson());
      if (matchedRows == 0) {
        throw StateError('原生物移动信息不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物移动信息 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureMovementInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
