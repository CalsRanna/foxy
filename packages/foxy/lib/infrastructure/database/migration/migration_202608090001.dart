import 'package:foxy/infrastructure/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

/// Normalizes the default sidebar pins and dashboard favorites.
///
/// Pins and favorites creatures, gossip, items, quests, SmartAI, and spells.
/// Earlier migrations also included game objects and conditions.
/// All other features have their pinned and favorite flags cleared.
class Migration202608090001 implements Migration {
  static const _defaultRouterMenus = [
    'creatureTemplate',
    'gossipMenu',
    'itemTemplate',
    'questTemplate',
    'smartScript',
    'spell',
  ];

  @override
  String get name => 'migration_202608090001';

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
