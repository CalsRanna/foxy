import 'package:foxy/entity/creature_model_info_entity.dart';
import 'package:foxy/entity/creature_model_info_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureModelInfoRepository with RepositoryMixin {
  static const _table = 'creature_model_info';

  Future<int> copyCreatureModelInfo(int key) async {
    final source = await getCreatureModelInfo(key);
    if (source == null) {
      throw StateError('原生物模型信息不存在，可能已被其他操作修改或删除');
    }
    final copied = CreatureModelInfoEntity.fromJson({
      ...source.toJson(),
      'DisplayID': await nextMaxPlusOne(_table, 'DisplayID'),
    });
    await storeCreatureModelInfo(copied);
    return copied.displayId;
  }

  Future<int> countCreatureModelInfos({
    CreatureModelInfoFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureModelInfoEntity> createCreatureModelInfo() async {
    return CreatureModelInfoEntity(
      displayId: await nextMaxPlusOne(_table, 'DisplayID'),
    );
  }

  Future<void> destroyCreatureModelInfo(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物模型信息不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureModelInfoEntity>> getBriefCreatureModelInfos({
    int page = 1,
    CreatureModelInfoFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    builder = builder.select([
      'DisplayID',
      'BoundingRadius',
      'CombatReach',
      'Gender',
      'DisplayID_Other_Gender',
    ]);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('DisplayID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureModelInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureModelInfoEntity?> getCreatureModelInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureModelInfoEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureModelInfoEntity>> getCreatureModelInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureModelInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureModelInfo(CreatureModelInfoEntity info) async {
    if (info.displayId <= 0) {
      throw StateError('生物模型信息 DisplayID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([info.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物模型信息 ${info.displayId} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureModelInfo(
    int originalKey,
    CreatureModelInfoEntity info,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(info.toJson());
      if (matchedRows == 0) {
        throw StateError('原生物模型信息不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物模型信息 DisplayID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureModelInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('DisplayID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('DisplayID', key);
  }
}
