import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202608090000 implements Migration {
  @override
  String get name => 'migration_202608090000';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.table('foxy.features').insert([
      {
        'name': '专业技能',
        'description': '管理专业技能的定义，配置技能名称、描述与图标的多语言文本，并维护专业技能关联的职业法术能力列表。',
        'icon': 'hammer',
        'router_menu': 'skillLine',
        'category': 'dbc',
        'is_pinned': 0,
        'is_favorite': 0,
        'sort_order': 27,
      },
    ]);
  }
}
