import 'package:foxy/database/migration/migration_202604260000.dart';
import 'package:foxy/database/migration/migration_202604260001.dart';
import 'package:foxy/database/migration/migration_202604270000.dart';
import 'package:foxy/database/migration/migration_202604280000.dart';
import 'package:foxy/database/migration/migration_202605010000.dart';
import 'package:foxy/database/migration/migration_202607190000.dart';
import 'package:foxy/database/migration/migration_202608030000.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:laconic/laconic.dart';

abstract class Migration {
  String get name;
  Future<void> migrate(Laconic laconic);
}

class MigrationRunner {
  final Laconic laconic;

  const MigrationRunner(this.laconic);

  Future<void> run() async {
    try {
      await _run();
    } catch (error, stackTrace) {
      // 受限账号(只给世界库读写)在 bootstrap 阶段即失败于建库/建表,
      // 日志补充权限提示,让用户知道需要 foxy 库的额外授权。
      LoggerUtil.instance.e(
        '迁移失败:检查数据库账号是否拥有 foxy 库的 CREATE/ALTER/RENAME 权限。'
        '原始错误: $error',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> _run() async {
    // 引导步骤：确保 foxy 数据库和 migrations 表存在
    await laconic.statement('CREATE DATABASE IF NOT EXISTS foxy');
    await laconic.statement('''
      CREATE TABLE IF NOT EXISTS foxy.migrations (
        name VARCHAR(200) NOT NULL PRIMARY KEY,
        applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // 按顺序运行迁移
    final List<Migration> migrations = [
      Migration202604260000(),
      Migration202604260001(),
      Migration202604270000(),
      Migration202604280000(),
      Migration202605010000(),
      Migration202607190000(),
      Migration202608030000(),
    ];

    for (final migration in migrations) {
      final count = await laconic
          .table('foxy.migrations')
          .where('name', migration.name)
          .count();

      if (count > 0) continue;

      await migration.migrate(laconic);
      await laconic.table('foxy.migrations').insert([
        {'name': migration.name},
      ]);
    }
  }
}
