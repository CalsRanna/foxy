@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/database/migration_runner.dart';

import 'integration_mysql.dart';

/// Real-MySQL coverage of the app's own startup path:
/// `Database.instance.connect` → `MigrationRunner.run`
/// (see BootstrapApplicationUseCase).
///
/// Every migration only touches `foxy.*` or `information_schema`, so an empty
/// MySQL is enough — no AzerothCore `world` schema is required.
///
/// Keep this directory serialized (a single file today, otherwise `-j 1`):
/// all suites share the single hardcoded `foxy` schema.
void main() {
  // Only `containsAll` is asserted on purpose: appending a migration must not
  // break this suite, but a migration that silently stops being applied must.
  const knownMigrations = [
    'migration_202604260000',
    'migration_202604260001',
    'migration_202604270000',
    'migration_202604280000',
    'migration_202605010000',
    'migration_202607190000',
    'migration_202608030000',
    'migration_202608090000',
    'migration_202608090001',
    'migration_202608090002',
  ];

  setUpAll(() async {
    await connectIntegrationDatabase();
    await MigrationRunner(Database.instance.laconic).run();
  });

  tearDownAll(() => Database.instance.close());

  test('引导后 foxy 库与全部表都是 utf8mb4', () async {
    final schemata = await Database.instance.laconic
        .table('information_schema.schemata')
        .select(['default_collation_name'])
        .where('schema_name', 'foxy')
        .get();
    expect(schemata, hasLength(1), reason: 'MigrationRunner 应已建库 foxy');
    expect(
      schemata.first.toMap()['DEFAULT_COLLATION_NAME'] as String,
      startsWith('utf8mb4'),
    );

    // The same scan _ensureUtf8mb4 performs: at steady state it must find
    // nothing, otherwise the app would ALTER tables on every startup.
    final legacyTables = await Database.instance.laconic
        .table('information_schema.tables')
        .select(['table_name', 'table_collation'])
        .where('table_schema', 'foxy')
        .whereRaw('table_collation not like ?', ['utf8mb4%'])
        .get();
    expect(legacyTables, isEmpty, reason: '不应残留非 utf8mb4 表');
  });

  test('全部迁移按序记录到 foxy.migrations', () async {
    final applied = await _appliedMigrations();
    expect(applied, containsAll(knownMigrations));
    expect(applied.length, greaterThanOrEqualTo(knownMigrations.length));
    expect(applied.toSet(), hasLength(applied.length), reason: '同一迁移不应被记录两次');
  });

  test('重复运行幂等:不新增迁移记录,features 种子不重复', () async {
    final migrationsBefore = await _appliedMigrations();
    final featureCountBefore = await _featureCount();
    expect(featureCountBefore, greaterThan(0), reason: 'features 种子应已写入');

    await MigrationRunner(Database.instance.laconic).run();

    expect(await _appliedMigrations(), migrationsBefore);
    expect(await _featureCount(), featureCountBefore);
  });

  test('features 中文名可原样读回(utf8mb4 端到端)', () async {
    final names =
        (await Database.instance.laconic.table('foxy.features').pluck('name'))
            .cast<String>();
    expect(names, containsAll(['生物', '物品', '任务']));
  });

  test('从零重建:drop 掉 foxy 后首次运行建库、建表并跑完全部迁移', () async {
    if (!allowDropFoxyDatabase) {
      // Deliberately not `skip:` — the documented local command uses
      // `--run-skipped`, which would override a skip and wipe the foxy schema
      // of a real instance.
      markTestSkipped('set FOXY_TEST_MYSQL_ALLOW_DROP=1 to drop foxy first');
      return;
    }

    await Database.instance.laconic.statement('drop database if exists foxy');
    await MigrationRunner(Database.instance.laconic).run();

    expect(await _appliedMigrations(), containsAll(knownMigrations));
    expect(await _featureCount(), greaterThan(0));
  });
}

/// Applied migration names, sorted so repeated reads compare reliably
/// (migration names are timestamps, so lexical order is chronological order).
Future<List<String>> _appliedMigrations() async {
  final names =
      (await Database.instance.laconic.table('foxy.migrations').pluck('name'))
          .cast<String>()
          .toList();
  return names..sort();
}

Future<int> _featureCount() =>
    Database.instance.laconic.table('foxy.features').count();
