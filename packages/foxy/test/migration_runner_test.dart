import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  group('MigrationRunner', () {
    test('首次运行:建库、建表、按序执行全部迁移并逐条记录', () async {
      final driver = _FakeDriver();
      await MigrationRunner(Laconic(driver)).run();

      expect(
        driver.sqlLog,
        contains(contains('create database if not exists')),
      );
      // Database creation must explicitly pin utf8mb4, otherwise old
      // servers default to latin1 and migrations inserting non-ASCII text
      // fail with 1366.
      expect(
        driver.sqlLog.firstWhere((sql) => sql.contains('create database')),
        contains('character set utf8mb4'),
      );
      // New databases default to utf8mb4; self-healing skips ALTER
      // DATABASE (no DDL).
      expect(
        driver.sqlLog.where((sql) => sql.contains('alter database')),
        isEmpty,
      );
      expect(driver.sqlLog, contains(contains('create table if not exists')));
      // All 7 migrations run and are recorded in foxy.migrations.
      expect(driver.appliedMigrations, hasLength(8));
      expect(
        driver.appliedMigrations,
        containsAll([
          'migration_202604260000',
          'migration_202604270000',
          'migration_202607190000',
          'migration_202608030000',
          'migration_202608090000',
        ]),
      );
      // With an empty information_schema driver, 202607190000 takes the
      // "column missing → skip" branch and produces no DROP COLUMN;
      // 202608030000 skips ALTER for never-imported DBC tables.
      expect(
        driver.sqlLog.where((sql) => sql.contains('drop column')),
        isEmpty,
      );
      expect(
        driver.sqlLog.where((sql) => sql.contains('alter table')),
        isEmpty,
      );
      // Record order = create database → create table → migrations.
      final createDatabaseIndex = driver.sqlLog.indexWhere(
        (sql) => sql.contains('create database'),
      );
      final createTableIndex = driver.sqlLog.indexWhere(
        (sql) => sql.contains('create table'),
      );
      expect(createDatabaseIndex, lessThan(createTableIndex));
    });

    test('已应用的迁移重复运行自动跳过', () async {
      final driver = _FakeDriver();
      final runner = MigrationRunner(Laconic(driver));
      await runner.run();
      final insertCountAfterFirstRun = driver.sqlLog
          .where((sql) => sql.toLowerCase().contains('insert'))
          .length;

      await runner.run();

      final insertCountAfterSecondRun = driver.sqlLog
          .where((sql) => sql.toLowerCase().contains('insert'))
          .length;
      // A second run produces no INSERTs (all skipped).
      expect(insertCountAfterSecondRun, insertCountAfterFirstRun);
      expect(driver.appliedMigrations, hasLength(8));
    });

    test('存在非 utf8mb4 存量表时,引导段逐个转换后仍跑完迁移', () async {
      final driver = _FakeDriver(latin1Tables: ['features', 'activity_log']);
      await MigrationRunner(Laconic(driver)).run();

      // A legacy latin1 database triggers ALTER DATABASE, one CONVERT
      // statement per latin1 legacy table, and none for utf8mb4 tables.
      expect(
        driver.sqlLog,
        contains(contains('alter database foxy character set utf8mb4')),
      );
      final converts = driver.sqlLog.where(
        (sql) => sql.contains('convert to character set utf8mb4'),
      );
      expect(converts, hasLength(2));
      expect(converts.first, contains('`features`'));
      expect(converts.last, contains('`activity_log`'));
      // Existing legacy tables do not affect migration execution.
      expect(driver.appliedMigrations, hasLength(8));
    });

    test('迁移执行失败时不记录版本,后续迁移不执行', () async {
      // 'drop column' only appears in 202607190000 (the activity_log
      // migration); simulate the entity_id column existing so that
      // migration really executes DDL and the failure lands on the 6th
      // migration.
      final driver = _FakeDriver(
        failOnSql: 'drop column',
        hasEntityIdColumn: true,
      );
      await expectLater(
        MigrationRunner(Laconic(driver)).run(),
        throwsA(isA<StateError>()),
      );
      // The 5 migrations before the failing one ran and were recorded;
      // neither the failing migration nor any later one is recorded.
      expect(driver.appliedMigrations, hasLength(5));
      expect(
        driver.appliedMigrations,
        isNot(contains('migration_202607190000')),
      );
      expect(
        driver.appliedMigrations,
        isNot(contains('migration_202608030000')),
      );
    });
  });
}

/// In-memory driver simulating the foxy.migrations table state:
/// - records all SQL;
/// - `insert` parses params to maintain the applied-version set;
/// - `count` queries return from that set (repeated runs are skipped);
/// - information_schema queries return empty (table/column-missing
///   branches).
final class _FakeDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  final String? failOnSql;

  /// Simulates whether 202607190000's probed activity_log.entity_id column
  /// exists.
  final bool hasEntityIdColumn;

  /// Simulates the legacy non-utf8mb4 table list scanned by the bootstrap
  /// _ensureUtf8mb4.
  final List<String> latin1Tables;
  final sqlLog = <String>[];
  final appliedMigrations = <String>{};

  _FakeDriver({
    this.failOnSql,
    this.hasEntityIdColumn = false,
    this.latin1Tables = const [],
  });

  void _maybeFail(String sql) {
    if (failOnSql != null && sql.contains(failOnSql!)) {
      throw StateError('boom: $sql');
    }
  }

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    sqlLog.add(sql);
    _maybeFail(sql);
    _recordInsert(sql, params);
    return 1;
  }

  /// laconic routes inserts without auto-increment columns through
  /// [statement]; both paths are recorded.
  void _recordInsert(String sql, List<Object?> params) {
    if (sql.toLowerCase().contains('migrations') &&
        sql.toLowerCase().contains('insert')) {
      appliedMigrations.add(params.first.toString());
    }
  }

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    sqlLog.add(sql);
    _maybeFail(sql);
    return 1;
  }

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async {
    sqlLog.add(sql);
    _maybeFail(sql);
    if (sql.contains('migrations')) {
      // Applied-migration list: pluck fetches all names in one call.
      return [
        for (final name in appliedMigrations)
          LaconicResult.fromMap({'name': name}),
      ];
    }
    if (sql.contains('information_schema')) {
      if (sql.contains('schemata')) {
        // SCHEMATA probe: legacy non-utf8mb4 tables mean the database still
        // defaults to latin1; otherwise it is already utf8mb4. Result keys
        // use declared casing (uppercase from information_schema).
        return [
          LaconicResult.fromMap({
            'DEFAULT_COLLATION_NAME': latin1Tables.isEmpty
                ? 'utf8mb4_unicode_ci'
                : 'latin1_swedish_ci',
          }),
        ];
      }
      if (sql.contains('table_collation')) {
        // The bootstrap _ensureUtf8mb4 table scan (filter pushed into SQL):
        // only legacy non-utf8mb4 tables are returned.
        return [
          for (final table in latin1Tables)
            LaconicResult.fromMap({'TABLE_NAME': table}),
        ];
      }
      // The columns probe (202607190000) follows config; the tables probe
      // (202608030000) always returns "table missing" → the migration
      // idles.
      final count = sql.contains('columns') && hasEntityIdColumn ? 1 : 0;
      return [
        LaconicResult.fromMap({'aggregate': count}),
      ];
    }
    return const [];
  }

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {
    sqlLog.add(sql);
    _maybeFail(sql);
    _recordInsert(sql, params);
  }

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}
