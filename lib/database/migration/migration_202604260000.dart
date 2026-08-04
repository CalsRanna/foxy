import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202604260000 implements Migration {
  @override
  String get name => 'migration_202604260000';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.statement('''
      create table if not exists foxy.features (
        id int auto_increment primary key,
        name varchar(100) not null comment '功能名称',
        description varchar(255) not null comment '功能描述',
        icon varchar(50) not null comment 'LucideIcons 图标标识',
        router_menu varchar(50) not null comment 'RouterMenu 枚举值',
        category varchar(20) not null default 'database' comment '分类: database/dbc',
        is_pinned tinyint(1) not null default 0 comment '是否钉到侧边栏',
        is_favorite tinyint(1) not null default 0 comment '是否收藏到首页常用功能',
        sort_order int not null default 0 comment '排序号',
        created_at timestamp default current_timestamp,
        updated_at timestamp default current_timestamp on update current_timestamp
      ) default charset=utf8mb4 collate=utf8mb4_unicode_ci
    ''');
  }
}
