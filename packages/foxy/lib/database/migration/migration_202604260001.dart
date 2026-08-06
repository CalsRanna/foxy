import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202604260001 implements Migration {
  @override
  String get name => 'migration_202604260001';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.table('foxy.features').insert([
      {
        'name': '生物',
        'description': 'NPC 与怪物的模板定义，控制生物的外观、属性、战斗数值和行为模式。',
        'icon': 'pawPrint',
        'router_menu': 'creatureTemplate',
        'category': 'database',
        'is_pinned': 1,
        'is_favorite': 1,
        'sort_order': 1,
      },
      {
        'name': '物品',
        'description': '装备与道具的数据定义，涵盖品质、属性加成、装备要求和使用效果。',
        'icon': 'swords',
        'router_menu': 'itemTemplate',
        'category': 'database',
        'is_pinned': 1,
        'is_favorite': 1,
        'sort_order': 2,
      },
      {
        'name': '任务',
        'description': '任务链的完整配置，包括目标、奖励、前置条件和触发对话。',
        'icon': 'badgeQuestionMark',
        'router_menu': 'questTemplate',
        'category': 'database',
        'is_pinned': 1,
        'is_favorite': 1,
        'sort_order': 3,
      },
      {
        'name': '游戏对象',
        'description': '场景中可交互物体的配置，如宝箱、门、陷阱、采集物等。',
        'icon': 'mapPin',
        'router_menu': 'gameObjectTemplate',
        'category': 'database',
        'is_pinned': 0,
        'is_favorite': 1,
        'sort_order': 4,
      },
      {
        'name': '对话',
        'description': 'NPC 菜单系统的编辑，配置对话面板文本与选项交互逻辑。',
        'icon': 'messageCircle',
        'router_menu': 'gossipMenu',
        'category': 'database',
        'is_pinned': 0,
        'is_favorite': 1,
        'sort_order': 5,
      },
      {
        'name': '内建脚本',
        'description': '基于条件与动作的脚本系统，驱动生物和物体的智能行为逻辑。',
        'icon': 'code',
        'router_menu': 'smartScript',
        'category': 'database',
        'is_pinned': 0,
        'is_favorite': 1,
        'sort_order': 6,
      },
      {
        'name': '法术',
        'description': '法术与技能的完整配置，定义施法效果、消耗、冷却和光环机制。',
        'icon': 'shell',
        'router_menu': 'spell',
        'category': 'dbc',
        'is_pinned': 1,
        'is_favorite': 1,
        'sort_order': 7,
      },
    ]);
  }
}
