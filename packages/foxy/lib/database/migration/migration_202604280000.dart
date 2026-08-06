import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202604280000 implements Migration {
  @override
  String get name => 'migration_202604280000';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.statement('''
      create table if not exists foxy.activity_log (
        id int auto_increment primary key,
        module varchar(64) not null comment '模块名，如 creature_template',
        action_type enum('create','update','delete','copy') not null comment '操作类型',
        entity_id int not null comment '被操作实体的ID',
        entity_name varchar(255) default '' comment '实体可读名称',
        created_at timestamp default current_timestamp
      ) default charset=utf8mb4 collate=utf8mb4_unicode_ci
    ''');
  }
}
