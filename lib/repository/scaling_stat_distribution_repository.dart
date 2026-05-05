import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ScalingStatDistributionRepository with RepositoryMixin {
  // DBC 表在 foxy 数据库中
  static const _table = 'foxy.dbc_scaling_stat_distribution';

  /// 搜索（分页）
  Future<List<BriefItemEnchantmentTemplateEntity>> getScalingStatDistributions({
    String? id,
    int page = 1,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table('$_table AS ssd');
    builder = builder.select(['ssd.ID', 'ssd.Name_lang_zhCN']);
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ssd.ID', id);
    }
    builder = builder.limit(kPageSize).offset(offset);
    var results = await builder.get();
    return results.map((e) {
      var map = e.toMap();
      return BriefItemEnchantmentTemplateEntity(
        entry: (map['ID'] as int?) ?? 0,
        name: (map['Name_lang_zhCN'] as String?) ?? '',
      );
    }).toList();
  }

  /// 计数
  Future<int> countScalingStatDistributions({String? id}) async {
    var builder = laconic.table('$_table AS ssd');
    if (id != null && id.isNotEmpty) {
      builder = builder.where('ssd.ID', id);
    }
    return await builder.count();
  }
}
