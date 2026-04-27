import 'package:foxy/database/migration/migration_202604260000.dart';
import 'package:foxy/database/migration/migration_202604260001.dart';
import 'package:foxy/database/migration/migration_202604270000.dart';
import 'package:foxy/database/migration/migration_202604280000.dart';
import 'package:laconic/laconic.dart';

abstract class Migration {
  String get name;
  Future<void> migrate(Laconic laconic);
}

class MigrationRunner {
  final Laconic laconic;

  const MigrationRunner(this.laconic);

  Future<void> run() async {
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
