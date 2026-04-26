import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202604260000 implements Migration {
  @override
  String get name => 'migration_202604260000';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.statement('''
      CREATE TABLE IF NOT EXISTS foxy.features (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL COMMENT '功能名称',
        description VARCHAR(255) NOT NULL COMMENT '功能描述',
        icon VARCHAR(50) NOT NULL COMMENT 'LucideIcons 图标标识',
        router_menu VARCHAR(50) NOT NULL COMMENT 'RouterMenu 枚举值',
        category VARCHAR(20) NOT NULL DEFAULT 'database' COMMENT '分类: database/dbc',
        is_pinned TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否钉到侧边栏',
        is_favorite TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否收藏到首页常用功能',
        sort_order INT NOT NULL DEFAULT 0 COMMENT '排序号',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      )
    ''');
  }
}
