import 'package:foxy/entity/brief_liquid_type_entity.dart';
import 'package:foxy/entity/liquid_type_entity.dart';
import 'package:foxy/entity/liquid_type_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class LiquidTypeRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_liquid_type';

  Future<int> copyLiquidType(int key) async {
    final source = await getLiquidType(key);
    if (source == null) {
      throw StateError('原液体类型不存在，可能已被其他操作修改或删除');
    }
    final copied = LiquidTypeEntity.fromJson({
      ...source.toJson(),
      'ID': await nextMaxPlusOne(_table, 'ID'),
    });
    await storeLiquidType(copied);
    return copied.id;
  }

  Future<int> countLiquidTypes({LiquidTypeFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<LiquidTypeEntity> createLiquidType() async =>
      LiquidTypeEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyLiquidType(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原液体类型不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefLiquidTypeEntity>> getBriefLiquidTypes({
    int page = 1,
    LiquidTypeFilterEntity? filter,
  }) async {
    final rows = await _applyFilter(
      laconic.table(_table).select([
        'ID',
        'Name',
        'Flags',
        'SoundBank',
        'SpellID',
      ]),
      filter,
    ).orderBy('ID').limit(kPageSize).offset((page - 1) * kPageSize).get();
    return rows
        .map((row) => BriefLiquidTypeEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<LiquidTypeEntity?> getLiquidType(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty ? null : LiquidTypeEntity.fromJson(rows.first.toMap());
  }

  Future<List<LiquidTypeEntity>> getLiquidTypes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => LiquidTypeEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeLiquidType(LiquidTypeEntity entity) async {
    if (entity.id <= 0) {
      throw StateError('液体类型 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([entity.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('液体类型 ${entity.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateLiquidType(
    int originalKey,
    LiquidTypeEntity entity,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(entity.toJson());
      if (matchedRows == 0) {
        throw StateError('原液体类型不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的液体类型 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    LiquidTypeFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.where('Name', '%${filter.name}%', comparator: 'like');
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
