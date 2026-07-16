import 'package:foxy/entity/dbc_item_entity.dart';
import 'package:foxy/entity/dbc_item_filter_entity.dart';
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

  Future<void> copyDbcItem(int id) async {
    final source = await getDbcItem(id);
    if (source == null) return;
    final json = source.toJson()..['ID'] = await nextMaxPlusOne(_table, 'ID');
    await laconic.table(_table).insert([json]);
  }

  Future<int> countDbcItems({DbcItemFilterEntity? filter}) =>
      _applyFilter(laconic.table(_table), filter).count();

  Future<DbcItemEntity> createDbcItem() async =>
      DbcItemEntity.fromJson({'ID': await nextMaxPlusOne(_table, 'ID')});

  Future<void> destroyDbcItem(int id) async {
    await laconic.table(_table).where('ID', id).delete();
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

  Future<DbcItemEntity?> getDbcItem(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty ? null : DbcItemEntity.fromJson(rows.first.toMap());
  }

  Future<List<DbcItemEntity>> getDbcItems() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => DbcItemEntity.fromJson(row.toMap())).toList();
  }

  Future<void> saveDbcItem(DbcItemEntity item) async {
    if (await getDbcItem(item.id) == null) {
      await storeDbcItem(item);
    } else {
      await updateDbcItem(item);
    }
  }

  Future<int> storeDbcItem(DbcItemEntity item) async {
    final json = item.toJson();
    final id = item.id > 0 ? item.id : await nextMaxPlusOne(_table, 'ID');
    json['ID'] = id;
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateDbcItem(DbcItemEntity item) async {
    final json = item.toJson()..remove('ID');
    await laconic.table(_table).where('ID', item.id).update(json);
  }

  QueryBuilder _applyFilter(QueryBuilder builder, DbcItemFilterEntity? filter) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ID', filter.id);
    if (filter.handEquippableOnly) {
      builder = builder.whereIn('InventoryType', handEquippableInventoryTypes);
    }
    return builder;
  }
}
