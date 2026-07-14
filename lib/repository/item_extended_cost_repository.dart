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
    return ItemExtendedCostEntity(id: await _getNextId());
  }

  Future<int> storeItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    final id = itemExtendedCost.id > 0
        ? itemExtendedCost.id
        : await _getNextId();
    final candidate = itemExtendedCost.copyWith(id: id)..validate();
    await _validateReferences(candidate);
    var json = candidate.toJson();
    await laconic.table(_table).insert([json]);
    return id;
  }

  Future<void> updateItemExtendedCost(
    ItemExtendedCostEntity itemExtendedCost,
  ) async {
    itemExtendedCost.validate();
    await _validateReferences(itemExtendedCost);
    var json = itemExtendedCost.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', itemExtendedCost.id).update(json);
  }

  Future<void> destroyItemExtendedCost(int id) async {
    if (await _isReferencedByVendors(id)) {
      throw StateError('扩展价格 $id 仍被商人数据引用，不能删除');
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyItemExtendedCost(int id) async {
    var source = await getItemExtendedCost(id);
    if (source == null) return;
    final nextId = await _getNextId();
    final candidate = source.copyWith(id: nextId)..validate();
    await _validateReferences(candidate);
    var json = candidate.toJson();
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
      itemExtendedCost.validate();
      await _validateReferences(itemExtendedCost);
      await laconic.table(_table).insert([itemExtendedCost.toJson()]);
    }
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 2147483647) {
      throw StateError('扩展价格编号已超出 signed int32 范围');
    }
    return id;
  }

  Future<void> _validateReferences(ItemExtendedCostEntity entity) async {
    await _validateItemReference('物品 0', entity.itemID0);
    await _validateItemReference('物品 1', entity.itemID1);
    await _validateItemReference('物品 2', entity.itemID2);
    await _validateItemReference('物品 3', entity.itemID3);
    await _validateItemReference('物品 4', entity.itemID4);
    if (entity.itemPurchaseGroup != 0) {
      final count = await laconic
          .table('foxy.dbc_item_purchase_group')
          .where('ID', entity.itemPurchaseGroup)
          .count();
      if (count == 0) {
        throw StateError('物品购买组 ${entity.itemPurchaseGroup} 不存在');
      }
    }
  }

  Future<void> _validateItemReference(String label, int itemId) async {
    if (itemId == 0) return;
    final count = await laconic
        .table('item_template')
        .where('entry', itemId)
        .count();
    if (count == 0) {
      throw StateError('$label 引用的物品 $itemId 不存在');
    }
  }

  Future<bool> _isReferencedByVendors(int id) async {
    final vendorCount = await laconic
        .table('npc_vendor')
        .where('ExtendedCost', id)
        .count();
    if (vendorCount > 0) return true;
    final eventVendorCount = await laconic
        .table('game_event_npc_vendor')
        .where('ExtendedCost', id)
        .count();
    return eventVendorCount > 0;
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
