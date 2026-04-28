import 'package:foxy/model/item_extended_cost.dart';
import 'package:foxy/model/item_extended_cost_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemExtendedCostRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_extended_cost';

  /// 搜索扩展价格
  Future<List<ItemExtendedCost>> getItemExtendedCosts({
    required ItemExtendedCostFilterEntity filter,
    required int page,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      builder = _applyFilter(builder, filter);
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => ItemExtendedCost.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> countItemExtendedCosts({required ItemExtendedCostFilterEntity filter}) async {
    try {
      var builder = laconic.table(_table);
      builder = _applyFilter(builder, filter);
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 根据ID获取单个扩展价格
  Future<ItemExtendedCost?> getItemExtendedCost(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return ItemExtendedCost.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }

  Future<void> storeItemExtendedCost(ItemExtendedCost data) async {
    var json = data.toJson();
    var nextId = await _getNextId();
    json['ID'] = nextId;
    await laconic.table(_table).insert([json]);
  }

  Future<void> updateItemExtendedCost(ItemExtendedCost data) async {
    var json = data.toJson();
    json.remove('ID');
    await laconic.table(_table).where('ID', data.id).update(json);
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

  Future<int> _getNextId() async {
    var result = await laconic.table(_table).select([
      'MAX(ID) as max_id',
    ]).first();
    var maxId = result.toMap()['max_id'] as int?;
    return (maxId ?? 0) + 1;
  }

  dynamic _applyFilter(dynamic builder, ItemExtendedCostFilterEntity filter) {
    if (filter.id.isNotEmpty) {
      builder = builder.where('ID', filter.id);
    }
    return builder;
  }
}
