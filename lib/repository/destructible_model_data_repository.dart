import 'package:foxy/entity/brief_destructible_model_data_entity.dart';
import 'package:foxy/entity/destructible_model_data_entity.dart';
import 'package:foxy/entity/destructible_model_data_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DestructibleModelDataRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_destructible_model_data';

  Future<int> copyDestructibleModelData(int key) async {
    final source = await getDestructibleModelData(key);
    if (source == null) {
      throw StateError('原可破坏模型数据不存在，可能已被其他操作修改或删除');
    }
    final copied = DestructibleModelDataEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeDestructibleModelData(copied);
    return copied.id;
  }

  Future<int> countDestructibleModelDatas({
    DestructibleModelDataFilterEntity? filter,
  }) => _applyFilter(laconic.table(_table), filter).count();

  Future<DestructibleModelDataEntity> createDestructibleModelData() async =>
      DestructibleModelDataEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyDestructibleModelData(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原可破坏模型数据不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefDestructibleModelDataEntity>>
  getBriefDestructibleModelDatas({
    int page = 1,
    DestructibleModelDataFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select([
        'ID',
        'State1WMO',
        'State2WMO',
        'State3WMO',
      ]),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefDestructibleModelDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<DestructibleModelDataEntity?> getDestructibleModelData(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty
        ? null
        : DestructibleModelDataEntity.fromJson(rows.first.toMap());
  }

  Future<List<DestructibleModelDataEntity>> getDestructibleModelDatas() async {
    final rows = await laconic.table(_table).get();
    return rows
        .map((row) => DestructibleModelDataEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<void> storeDestructibleModelData(
    DestructibleModelDataEntity entity,
  ) async {
    if (entity.id <= 0) {
      throw StateError('可破坏模型数据 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('可破坏模型数据 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateDestructibleModelData(
    int originalKey,
    DestructibleModelDataEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原可破坏模型数据不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的可破坏模型数据 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    DestructibleModelDataFilterEntity? filter,
  ) {
    if (filter != null && filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
