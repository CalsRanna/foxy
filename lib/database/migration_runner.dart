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
      // Restricted accounts (world DB read/write only) already fail at
      // database/table creation during bootstrap; the log adds a permission
      // hint so users know extra grants on the foxy database are needed.
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
    // Bootstrap: ensure the foxy database and migrations table exist.
    // The charset must be explicitly pinned to utf8mb4: old servers
    // (MySQL 5.x one-click packs) default to latin1; without the explicit
    // declaration the foxy database/tables inherit latin1 and migrations
    // inserting non-ASCII text fail with 1366, blocking startup.
    await laconic.statement(
      'create database if not exists foxy '
      'character set utf8mb4 collate utf8mb4_unicode_ci',
    );
    await laconic.statement(
      'create table if not exists foxy.migrations ('
      'name varchar(200) not null primary key, '
      'applied_at timestamp default current_timestamp'
      ') default charset=utf8mb4 collate=utf8mb4_unicode_ci',
    );
    // Legacy self-healing: databases created before this fix may already
    // be latin1/utf8 (non-mb4). This must run before migrations — the
    // non-ASCII-inserting migrations come first in the list and would
    // deadlock with 1366 on latin1 tables, so migrations appended later
    // would never run.
    await _ensureUtf8mb4();

    // Run migrations in order: fetch all applied migrations in one query to
    // avoid one COUNT round-trip per migration.
    final applied = (await laconic.table('foxy.migrations').pluck('name'))
        .cast<String>()
        .toSet();
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
      if (applied.contains(migration.name)) continue;

      await migration.migrate(laconic);
      await laconic.table('foxy.migrations').insert([
        {'name': migration.name},
      ]);
    }
  }

  /// Unifies the foxy database and all its tables to utf8mb4 (idempotent,
  /// run on every startup).
  ///
  /// Safety: the 1366 error guarantees non-utf8mb4 columns cannot contain
  /// non-ASCII data (Chinese cannot be written at all), so
  /// `CONVERT TO CHARACTER SET utf8mb4` cannot produce double mojibake;
  /// Chinese in utf8 (3-byte) columns converts losslessly.
  ///
  /// Steady-state optimization: if the database is already utf8mb4, skip
  /// ALTER DATABASE (no DDL); table scanning pushes the filter into SQL,
  /// so zero round-trips when no non-mb4 tables remain.
  Future<void> _ensureUtf8mb4() async {
    final schemaRows = await laconic
        .table('information_schema.schemata')
        .select(['default_collation_name'])
        .where('schema_name', 'foxy')
        .get();
    // Result map keys use the casing the server returns (uppercase for
    // information_schema), unrelated to the lowercase identifiers in the
    // query.
    final dbCollation = schemaRows.isEmpty
        ? null
        : schemaRows.first.toMap()['DEFAULT_COLLATION_NAME'] as String?;
    if (dbCollation == null || !dbCollation.startsWith('utf8mb4')) {
      await laconic.statement(
        'alter database foxy character set utf8mb4 collate utf8mb4_unicode_ci',
      );
    }
    final rows = await laconic
        .table('information_schema.tables')
        .select(['table_name'])
        .where('table_schema', 'foxy')
        .whereRaw('table_collation not like ?', ['utf8mb4%'])
        .get();
    for (final row in rows) {
      final tableName = row.toMap()['TABLE_NAME'] as String;
      await laconic.statement(
        'alter table foxy.`$tableName` '
        'convert to character set utf8mb4 collate utf8mb4_unicode_ci',
      );
    }
  }
}
