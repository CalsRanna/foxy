import 'package:foxy/entity/brief_dbc_item_entity.dart';
import 'package:foxy/entity/dbc_item_entity.dart';
import 'package:foxy/entity/dbc_item_filter_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class DbcItemRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item';
  static const handEquippableInventoryTypes = [
    13,
    14,
    15,
    17,
    21,
    22,
    23,
    25,
    26,
  ];

  Future<int> copyDbcItem(int key) async {
    final source = await getDbcItem(key);
    if (source == null) {
      throw StateError('原 DBC 物品不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await nextMaxPlusOne(_table, 'ID'));
    await storeDbcItem(copied);
    return copied.id;
  }

  Future<int> countDbcItems({DbcItemFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<DbcItemEntity> createDbcItem() async =>
      DbcItemEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<void> destroyDbcItem(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原 DBC 物品不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefDbcItemEntity>> getBriefDbcItems({
    int page = 1,
    DbcItemFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table).select([
      'ID',
      'ClassID',
      'SubclassID',
      'DisplayInfoID',
      'InventoryType',
    ]);
    builder = _applyFilter(builder, filter).orderBy('ID');
    final rows = await builder
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows.map((row) => BriefDbcItemEntity.fromJson(row.toMap())).toList();
  }

  Future<DbcItemEntity?> getDbcItem(int key) async {
    final rows = await _whereKey(laconic.table(_table), key).limit(1).get();
    return rows.isEmpty ? null : DbcItemEntity.fromJson(rows.first.toMap());
  }

  Future<List<DbcItemEntity>> getDbcItems() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => DbcItemEntity.fromJson(row.toMap())).toList();
  }

  Future<void> storeDbcItem(DbcItemEntity item) async {
    if (item.id <= 0) {
      throw StateError('DBC 物品 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([item.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('DBC 物品 ${item.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateDbcItem(int originalKey, DbcItemEntity item) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(item.toJson());
      if (matchedRows == 0) {
        throw StateError('原 DBC 物品不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的 DBC 物品 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(QueryBuilder builder, DbcItemFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.handEquippableOnly) {
      builder = builder.whereIn('InventoryType', handEquippableInventoryTypes);
    }
    return builder;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
