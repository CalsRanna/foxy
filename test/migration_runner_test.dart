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
        contains(contains('CREATE DATABASE IF NOT EXISTS')),
      );
      // 建库必须显式锁 utf8mb4,否则老服务器默认 latin1 导致迁移插中文 1366。
      expect(
        driver.sqlLog.firstWhere((sql) => sql.contains('CREATE DATABASE')),
        contains('CHARACTER SET utf8mb4'),
      );
      expect(
        driver.sqlLog,
        contains(contains('ALTER DATABASE foxy CHARACTER SET utf8mb4')),
      );
      expect(driver.sqlLog, contains(contains('CREATE TABLE IF NOT EXISTS')));
      // 7 个迁移全部执行并写入 foxy.migrations 记录。
      expect(driver.appliedMigrations, hasLength(7));
      expect(
        driver.appliedMigrations,
        containsAll([
          'migration_202604260000',
          'migration_202604270000',
          'migration_202607190000',
          'migration_202608030000',
        ]),
      );
      // information_schema 空表驱动下,202607190000 走「列不存在跳过」分支,
      // 不产生 DROP COLUMN;202608030000 对未导入的 DBC 表跳过 ALTER。
      expect(
        driver.sqlLog.where((sql) => sql.contains('DROP COLUMN')),
        isEmpty,
      );
      expect(
        driver.sqlLog.where((sql) => sql.contains('ALTER TABLE')),
        isEmpty,
      );
      // 记录顺序 = 建库 → 建表 → 迁移。
      final createDatabaseIndex = driver.sqlLog.indexWhere(
        (sql) => sql.contains('CREATE DATABASE'),
      );
      final createTableIndex = driver.sqlLog.indexWhere(
        (sql) => sql.contains('CREATE TABLE'),
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
      // 第二次运行不产生任何 INSERT(全部跳过)。
      expect(insertCountAfterSecondRun, insertCountAfterFirstRun);
      expect(driver.appliedMigrations, hasLength(7));
    });

    test('存在非 utf8mb4 存量表时,引导段逐个转换后仍跑完迁移', () async {
      final driver = _FakeDriver(latin1Tables: ['features', 'activity_log']);
      await MigrationRunner(Laconic(driver)).run();

      // 每个 latin1 存量表产生一条 CONVERT 语句,utf8mb4 表不产生。
      final converts = driver.sqlLog.where(
        (sql) => sql.contains('CONVERT TO CHARACTER SET utf8mb4'),
      );
      expect(converts, hasLength(2));
      expect(converts.first, contains('`features`'));
      expect(converts.last, contains('`activity_log`'));
      // 存量表存在不影响迁移执行。
      expect(driver.appliedMigrations, hasLength(7));
    });

    test('迁移执行失败时不记录版本,后续迁移不执行', () async {
      // 'DROP COLUMN' 只出现在 202607190000(activity_log 迁移)中;
      // 模拟 entity_id 列存在,使该迁移真正执行 DDL,失败点落在第 6 个迁移。
      final driver = _FakeDriver(
        failOnSql: 'DROP COLUMN',
        hasEntityIdColumn: true,
      );
      await expectLater(
        MigrationRunner(Laconic(driver)).run(),
        throwsA(isA<StateError>()),
      );
      // 失败迁移之前的 5 个已执行并记录;失败迁移本身与后续迁移
      // (202608030000)都不记录。
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

/// 模拟 foxy.migrations 表状态的内存驱动:
/// - 记录全部 SQL;
/// - `insert` 解析参数维护已应用版本集合;
/// - `count` 查询按该集合返回(重复 run 可跳过);
/// - information_schema 查询返回空(表/列不存在的分支)。
final class _FakeDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  final String? failOnSql;

  /// 模拟 202607190000 探测的 activity_log.entity_id 列是否存在。
  final bool hasEntityIdColumn;

  /// 模拟引导段 _ensureUtf8mb4 扫描到的存量非 utf8mb4 表清单。
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

  /// laconic 对无自增列的 insert 走 [statement],两者都记录。
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
    if (sql.contains('migrations') && sql.contains('COUNT(*)')) {
      final name = params.isNotEmpty ? params.first.toString() : null;
      final count = name == null
          ? appliedMigrations.length
          : (appliedMigrations.contains(name) ? 1 : 0);
      return [
        LaconicResult.fromMap({'aggregate': count}),
      ];
    }
    if (sql.contains('information_schema')) {
      if (sql.contains('TABLE_COLLATION')) {
        // 引导段 _ensureUtf8mb4 的表清单查询:按配置返回存量表。
        return [
          for (final table in latin1Tables)
            LaconicResult.fromMap({
              'TABLE_NAME': table,
              'TABLE_COLLATION': 'latin1_swedish_ci',
            }),
        ];
      }
      // COLUMNS 探测(202607190000)按配置;TABLES 探测(202608030000)
      // 一律返回「表不存在」→ 迁移空转。
      final count = sql.contains('COLUMNS') && hasEntityIdColumn ? 1 : 0;
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
