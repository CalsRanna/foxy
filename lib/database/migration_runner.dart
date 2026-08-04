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
    // 引导步骤：确保 foxy 数据库和 migrations 表存在。
    // 字符集必须显式锁 utf8mb4：老服务器(MySQL 5.x 一键端)默认 latin1,
    // 不声明则 foxy 库/表继承 latin1,迁移插入的中文即报 1366 无法启动。
    await laconic.statement(
      'CREATE DATABASE IF NOT EXISTS foxy '
      'CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci',
    );
    await laconic.statement('''
      CREATE TABLE IF NOT EXISTS foxy.migrations (
        name VARCHAR(200) NOT NULL PRIMARY KEY,
        applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      ) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    ''');
    // 存量自愈：老库在本次修复前可能已建成 latin1/utf8(非 mb4)。
    // 必须在跑迁移之前执行——插中文的迁移排在列表最前,latin1 表上
    // 它们自身就 1366 卡死,放迁移末尾的新迁移根本跑不到。
    await _ensureUtf8mb4();

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

  /// 把 foxy 库及全部表统一到 utf8mb4(幂等,每次启动执行)。
  ///
  /// 安全性:1366 错误保证了非 utf8mb4 列里不可能有非 ASCII 数据
  /// (中文根本写不进去),因此 `CONVERT TO CHARACTER SET utf8mb4`
  /// 不会产生双重乱码;utf8(3 字节)列里的中文转换无损。
  Future<void> _ensureUtf8mb4() async {
    await laconic.statement(
      'ALTER DATABASE foxy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci',
    );
    final rows = await laconic
        .table('information_schema.TABLES')
        .select(['TABLE_NAME', 'TABLE_COLLATION'])
        .where('TABLE_SCHEMA', 'foxy')
        .get();
    for (final row in rows) {
      final collation = row.toMap()['TABLE_COLLATION'] as String?;
      if (collation != null && collation.startsWith('utf8mb4')) continue;
      final tableName = row.toMap()['TABLE_NAME'] as String;
      await laconic.statement(
        'ALTER TABLE foxy.`$tableName` '
        'CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci',
      );
    }
  }
}
