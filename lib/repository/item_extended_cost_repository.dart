import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/entity/item_extended_cost_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class ItemExtendedCostRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_extended_cost';

  Future<List<BriefItemExtendedCostEntity>> getBriefItemExtendedCosts({
    int page = 1,
    ItemExtendedCostFilterEntity? filter,
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

  Future<List<ItemExtendedCostEntity>> getItemExtendedCosts() async {
    var results = await laconic.table(_table).get();
    return results
        .map((e) => ItemExtendedCostEntity.fromJson(e.toMap()))
        .toList();
  }

  Future<int> countItemExtendedCosts({
    ItemExtendedCostFilterEntity? filter,
  }) async {
    var builder = laconic.table(_table);
    builder = _applyFilter(builder, filter);
    return builder.count();
  }

  Future<ItemExtendedCostEntity?> getItemExtendedCost(int id) async {
    var results = await laconic.table(_table).where('ID', id).limit(1).get();
    if (results.isEmpty) return null;
    return ItemExtendedCostEntity.fromJson(results.first.toMap());
  }

  Future<ItemExtendedCostEntity> createItemExtendedCost() async {
    return const ItemExtendedCostEntity();
  }

  Future<int> storeItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    var json = itemExtendedCost.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
    return nextId;
  }

  Future<void> updateItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    var json = itemExtendedCost.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', itemExtendedCost.id).update(json);
  }

  Future<void> destroyItemExtendedCost(int id) async {
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemExtendedCost(int id) async {
    var source = await getItemExtendedCost(id);
    if (source == null) return;
    var json = source.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> saveItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    if (itemExtendedCost.id == 0) {
      await storeItemExtendedCost(itemExtendedCost);
      return;
    }
    var existing = await getItemExtendedCost(itemExtendedCost.id);
    if (existing != null) {
      await updateItemExtendedCost(itemExtendedCost);
    } else {
      await laconic.table(_table).insert([itemExtendedCost.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    ItemExtendedCostFilterEntity? filter,
  ) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}