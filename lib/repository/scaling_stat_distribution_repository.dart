import 'package:foxy/model/item_enchantment_template.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ScalingStatDistributionRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  final String _table = 'foxy.dbc_scaling_stat_distribution';

  /// 搜索（分页）
  Future<List<ItemEnchantmentTemplate>> search({
    String? id,
    int page = 1,
  }) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table('$_table AS ssd');
      builder = builder.select(['ssd.ID', 'ssd.Name_lang_zhCN']);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ssd.ID', id);
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      // ItemEnchantmentTemplate 有 name 字段，可以复用其 fromJson
      // 但这里用更轻量的解析
      return results.map((e) {
        var map = e.toMap();
        var model = ItemEnchantmentTemplate();
        model.entry = (map['ID'] as int?) ?? 0;
        model.name = (map['Name_lang_zhCN'] as String?) ?? '';
        return model;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({String? id}) async {
    try {
      var builder = laconic.table('$_table AS ssd');
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ssd.ID', id);
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }
}
