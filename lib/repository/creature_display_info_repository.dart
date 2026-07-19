import 'package:foxy/entity/brief_creature_display_info_entity.dart';
import 'package:foxy/entity/creature_display_info_entity.dart';
import 'package:foxy/entity/creature_display_info_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureDisplayInfoRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_display_info';
  static const _modelDataTable = 'foxy.dbc_creature_model_data';

  Future<int> copyCreatureDisplayInfo(int key) async {
    final source = await getCreatureDisplayInfo(key);
    if (source == null) {
      throw StateError('原生物显示信息不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeCreatureDisplayInfo(copied);
    return copied.id;
  }

  Future<int> countCreatureDisplayInfos({
    CreatureDisplayInfoFilterEntity? filter,
  }) async {
    final needsModelJoin = filter != null && filter.modelName.isNotEmpty;
    if (!needsModelJoin) {
      var builder = laconic.table(_table);
      if (filter != null && filter.id.isNotEmpty) {
        builder = builder.where('ID', filter.id);
      }
      return builder.count();
    }
    var builder = laconic.table('$_table AS cdi');
    builder = _joinModelData(builder);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureDisplayInfoEntity> createCreatureDisplayInfo() async {
    return CreatureDisplayInfoEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyCreatureDisplayInfo(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物显示信息不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureDisplayInfoEntity>> getBriefCreatureDisplayInfos({
    int page = 1,
    CreatureDisplayInfoFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS cdi');
    builder = builder.select([
      'cdi.ID',
      'cdi.ModelID',
      'cdi.CreatureModelScale',
      'cdi.SizeClass',
      'cdi.BloodID',
      'cmd.ModelName',
    ]);
    builder = _joinModelData(builder);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('cdi.ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefCreatureDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureDisplayInfoEntity?> getCreatureDisplayInfo(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureDisplayInfoEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureDisplayInfoEntity>> getCreatureDisplayInfos() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => CreatureDisplayInfoEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureDisplayInfo(CreatureDisplayInfoEntity info) async {
    if (info.id <= 0) {
      throw StateError('生物显示信息 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([info.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物显示信息 ${info.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureDisplayInfo(
    int originalKey,
    CreatureDisplayInfoEntity info,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(info.toJson());
      if (matchedRows == 0) {
        throw StateError('原生物显示信息不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物显示信息 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureDisplayInfoFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('cdi.ID', filter.id);
    }
    if (filter.modelName.isNotEmpty) {
      builder = builder.where(
        'cmd.ModelName',
        '%${filter.modelName}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _joinModelData(QueryBuilder builder) {
    return builder.leftJoin(
      '$_modelDataTable AS cmd',
      (join) => join.on('cdi.ModelID', 'cmd.ID'),
    );
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
