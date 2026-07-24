import 'package:foxy/entity/taxi_path_entity.dart';
import 'package:foxy/entity/taxi_path_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class TaxiPathRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_taxi_path';

  Future<int> copyTaxiPath(int key) async {
    final source = await getTaxiPath(key);
    if (source == null) {
      throw StateError('原飞行路径不存在，可能已被其他操作修改或删除');
    }
    final copied = TaxiPathEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeTaxiPath(copied);
    return copied.id;
  }

  Future<int> countTaxiPaths({TaxiPathFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<TaxiPathEntity> createTaxiPath() async =>
      TaxiPathEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyTaxiPath(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原飞行路径不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefTaxiPathEntity>> getBriefTaxiPaths({
    int page = 1,
    TaxiPathFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select([
        'ID',
        'FromTaxiNode',
        'ToTaxiNode',
        'Cost',
      ]),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefTaxiPathEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<TaxiPathEntity?> getTaxiPath(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty ? null : TaxiPathEntity.fromJson(rows.first.toMap());
  }

  Future<List<TaxiPathEntity>> getTaxiPaths() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => TaxiPathEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeTaxiPath(TaxiPathEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('飞行路径 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('飞行路径 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateTaxiPath(int originalKey, TaxiPathEntity entity) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原飞行路径不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的飞行路径 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    TaxiPathFilterEntity? filter,
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
