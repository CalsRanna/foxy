import 'package:foxy/model/gossip_menu_option_locale.dart';
import 'package:foxy/repository/repository_mixin.dart';

/// gossip_menu_option_locale 表的数据访问层（只读）
/// 仅在 GossipMenuOptionRepository.search 中通过 JOIN 读取；
/// 本 Repository 提供直查方法以备未来扩展。
class GossipMenuOptionLocaleRepository with RepositoryMixin {
  static const _table = 'gossip_menu_option_locale';

  /// 按 MenuID 查询所有 locale 记录
  Future<List<GossipMenuOptionLocale>> getGossipMenuOptionLocales({required int menuId}) async {
    try {
      final results = await laconic.table(_table).where('MenuID', menuId).get();
      return results
          .map((e) => GossipMenuOptionLocale.fromJson(e.toMap()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
