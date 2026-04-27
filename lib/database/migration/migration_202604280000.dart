import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202604280000 implements Migration {
  @override
  String get name => 'migration_202604280000';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.statement('''
      CREATE TABLE IF NOT EXISTS foxy.activity_log (
        id INT AUTO_INCREMENT PRIMARY KEY,
        module VARCHAR(64) NOT NULL COMMENT '模块名，如 creature_template',
        action_type ENUM('create','update','delete','copy') NOT NULL COMMENT '操作类型',
        entity_id INT NOT NULL COMMENT '被操作实体的ID',
        entity_name VARCHAR(255) DEFAULT '' COMMENT '实体可读名称',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}
