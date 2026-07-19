import 'package:foxy/entity/brief_creature_model_data_entity.dart';
import 'package:foxy/entity/creature_model_data_entity.dart';
import 'package:foxy/entity/creature_model_data_filter_entity.dart';
import 'package:foxy/entity/creature_model_data_key.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CreatureModelDataRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_creature_model_data';

  Future<CreatureModelDataKey> copyCreatureModelData(
    CreatureModelDataKey key,
  ) async {
    final source = await getCreatureModelData(key);
    if (source == null) {
      throw StateError('原生物模型数据不存在，可能已被其他操作修改或删除');
    }
    final copied = CreatureModelDataEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeCreatureModelData(copied);
    return CreatureModelDataKey.fromEntity(copied);
  }

  Future<int> countCreatureModelDatas({
    CreatureModelDataFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<CreatureModelDataEntity> createCreatureModelData() async {
    return CreatureModelDataEntity(id: await nextMaxPlusOne(_table, 'ID'));
  }

  Future<void> destroyCreatureModelData(CreatureModelDataKey key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原生物模型数据不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefCreatureModelDataEntity>> getBriefCreatureModelDatas({
    int page = 1,
    CreatureModelDataFilterEntity? filter,
  }) async {
    final offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table).select([
      'ID',
      'ModelName',
      'SizeClass',
      'ModelScale',
    ]);
    builder = _applyFilter(builder, filter);
    final results = await builder
        .orderBy('ID')
        .limit(kPageSize)
        .offset(offset)
        .get();
    return results
        .map((e) => BriefCreatureModelDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<CreatureModelDataEntity?> getCreatureModelData(
    CreatureModelDataKey key,
  ) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return CreatureModelDataEntity.fromJson(results.first.toMap());
  }

  Future<List<CreatureModelDataEntity>> getCreatureModelDatas() async {
    final results = await laconic.table(_table).orderBy('ID').get();
    return results
        .map((e) => CreatureModelDataEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeCreatureModelData(CreatureModelDataEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('生物模型数据 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('生物模型数据 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateCreatureModelData(
    CreatureModelDataKey originalKey,
    CreatureModelDataEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原生物模型数据不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的生物模型数据 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CreatureModelDataFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    if (filter.modelName.isNotEmpty) {
      builder = builder.where(
        'ModelName',
        '%${filter.modelName}%',
        comparator: 'like',
      );
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, CreatureModelDataKey key) {
    return builder.where('ID', key.id);
  }
}
