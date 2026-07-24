import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/dbc_item_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'dbc_item_repository.g.dart';

@FoxyRepository(DbcItemEntity)
@FoxyFilter.text('id')
@FoxyFilter.boolean('handEquippableOnly')
class DbcItemRepository with RepositoryMixin, _DbcItemRepositoryMixin {
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

  Future<int> countDbcItems({DbcItemFilter? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<DbcItemEntity> createDbcItem() async =>
      DbcItemEntity(id: await nextMaxPlusOne(_table, 'ID'));

  Future<List<BriefDbcItemEntity>> getBriefDbcItems({
    int page = 1,
    DbcItemFilter? filter,
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

  QueryBuilder _applyFilter(QueryBuilder builder, DbcItemFilter? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.handEquippableOnly) {
      builder = builder.whereIn('InventoryType', handEquippableInventoryTypes);
    }
    return builder;
  }
}
