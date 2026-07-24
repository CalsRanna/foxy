import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/creature_movement_info_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_movement_info_repository.g.dart';

@FoxyRepository(CreatureMovementInfoEntity)
@FoxyFilter.text('id')
class CreatureMovementInfoRepository
    with RepositoryMixin, _CreatureMovementInfoRepositoryMixin {
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
    CreatureMovementInfoFilter? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureMovementInfoEntity> createCreatureMovementInfo() async {
    return CreatureMovementInfoEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<List<BriefCreatureMovementInfoEntity>> getBriefCreatureMovementInfos({
    int page = 1,
    CreatureMovementInfoFilter? filter,
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

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureMovementInfoFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
