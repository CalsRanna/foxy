import 'package:foxy/model/item_extended_cost.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ItemExtendedCostRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_item_extended_cost';

  /// 搜索扩展价格
  Future<List<ItemExtendedCost>> search({
    String? id,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      const fields = ['ID', 'HonorPoints', 'ArenaPoints', 'ArenaBracket'];
      builder = builder.select(fields);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => ItemExtendedCost.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({String? id}) async {
    try {
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 根据ID获取单个扩展价格
  Future<ItemExtendedCost?> find(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return result != null ? ItemExtendedCost.fromJson(result.toMap()) : null;
    } catch (e) {
      return null;
    }
  }
}
