import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

/// Realigns the out-of-box feature defaults: only 生物/对话/物品/任务/
/// 内建脚本/法术 stay pinned (sidebar) and favorited (dashboard frequent
/// modules). Earlier migrations pinned and favorited a mix that included
/// 游戏对象 and 条件; this migration normalizes every feature to the same
/// default set.
class Migration202608090001 implements Migration {
  @override
  String get name => 'migration_202608090001';

  static const _defaultRouterMenus = [
    'creatureTemplate',
    'gossipMenu',
    'itemTemplate',
    'questTemplate',
    'smartScript',
    'spell',
  ];

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic
        .table('foxy.features')
        .whereIn('router_menu', _defaultRouterMenus)
        .update({'is_pinned': 1, 'is_favorite': 1});
    await laconic
        .table('foxy.features')
        .whereNotIn('router_menu', _defaultRouterMenus)
        .update({'is_pinned': 0, 'is_favorite': 0});
  }
}
