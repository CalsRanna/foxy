import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202605010000 implements Migration {
  @override
  String get name => 'migration_202605010000';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.table('foxy.features').insert([
      {
        'name': '成就',
        'description': '管理成就系统的完整定义，包括成就标题、描述、奖励文本、分类和图标等配置信息。',
        'icon': 'award',
        'router_menu': 'achievement',
        'category': 'dbc',
        'is_pinned': 0,
        'is_favorite': 0,
        'sort_order': 22,
      },
      {
        'name': '货币',
        'description': '配置游戏内各类货币代币的定义，关联物品ID、货币分类和位索引等属性。',
        'icon': 'banknote',
        'router_menu': 'currencyType',
        'category': 'dbc',
        'is_pinned': 0,
        'is_favorite': 0,
        'sort_order': 23,
      },
      {
        'name': '套装',
        'description': '管理装备套装的完整定义，配置套装包含的物品、套装法术效果和各件触发阈值。',
        'icon': 'layers',
        'router_menu': 'itemSet',
        'category': 'dbc',
        'is_pinned': 0,
        'is_favorite': 0,
        'sort_order': 24,
      },
      {
        'name': '缩放属性值',
        'description': '定义等级缩放系统的数值表，配置各等级下的装备预算、护甲值和武器DPS等参数。',
        'icon': 'ruler',
        'router_menu': 'scalingStatValue',
        'category': 'dbc',
        'is_pinned': 0,
        'is_favorite': 0,
        'sort_order': 25,
      },
      {
        'name': '天赋',
        'description': '管理职业天赋树的配置，定义各天赋的法术等级、前置条件和分类掩码等信息。',
        'icon': 'sparkles',
        'router_menu': 'talent',
        'category': 'dbc',
        'is_pinned': 0,
        'is_favorite': 0,
        'sort_order': 26,
      },
    ]);
  }
}
