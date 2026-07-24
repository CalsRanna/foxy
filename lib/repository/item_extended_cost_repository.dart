import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'item_extended_cost_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'ItemExtendedCostFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class ItemExtendedCostRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_extended_cost';

  Future<int> copyItemExtendedCost(int key) async {
    final source = await getItemExtendedCost(key);
    if (source == null) {
      throw StateError('原扩展价格不存在，可能已被其他操作修改或删除');
    }
    final copied = source.copyWith(id: await _getNextId());
    await storeItemExtendedCost(copied);
    return copied.id;
  }

  Future<int> countItemExtendedCosts({ItemExtendedCostFilter? filter}) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemExtendedCostEntity> createItemExtendedCost() async {
    return ItemExtendedCostEntity(id: await _getNextId());
  }

  Future<void> destroyItemExtendedCost(int key) async {
    final deletedRows = await _whereKey(laconic.table(_table), key).delete();
    if (deletedRows == 0) {
      throw StateError('原扩展价格不存在，可能已被其他操作修改或删除');
    }
  }

  Future<List<BriefItemExtendedCostEntity>> getBriefItemExtendedCosts({
    int page = 1,
    ItemExtendedCostFilter? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    const fields = [
      'ID',
      'HonorPoints',
      'ArenaPoints',
      'ArenaBracket',
      'ItemID0',
      'ItemID1',
      'ItemID2',
      'ItemID3',
      'ItemID4',
      'ItemCount0',
      'ItemCount1',
      'ItemCount2',
      'ItemCount3',
      'ItemCount4',
    ];
    builder = builder.select(fields);
    builder = _applyFilter(builder, filter);
    builder = builder.orderBy('ID');
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results
        .map((e) => BriefItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<ItemExtendedCostEntity?> getItemExtendedCost(int key) async {
    final results = await _whereKey(laconic.table(_table), key).limit(1).get();
    if (results.isEmpty) return null;
    return ItemExtendedCostEntity.fromJson(results.first.toMap());
  }

  Future<List<ItemExtendedCostEntity>> getItemExtendedCosts() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<void> storeItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    if (itemExtendedCost.id <= 0) {
      throw StateError('扩展价格 ID 必须在新建表单打开时显式分配');
    }
    try {
      await laconic.table(_table).insert([itemExtendedCost.toJson()]);
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('扩展价格 ${itemExtendedCost.id} 已存在，无法新建');
      }
      rethrow;
    }
  }

  Future<void> updateItemExtendedCost(
    int originalKey,
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    try {
      final matchedRows = await _whereKey(
        laconic.table(_table),
        originalKey,
      ).update(itemExtendedCost.toJson());
      if (matchedRows == 0) {
        throw StateError('原扩展价格不存在，可能已被其他操作修改或删除');
      }
    } catch (error) {
      if (MysqlErrorUtil.isDuplicateEntry(error)) {
        throw StateError('修改后的扩展价格 ID 已存在，无法保存');
      }
      rethrow;
    }
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemExtendedCostFilter? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 2147483647) {
      throw StateError('扩展价格编号已超出 signed int32 范围');
    }
    return id;
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('ID', key);
  }
}
