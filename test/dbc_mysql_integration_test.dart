import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/util/dbc_export_util.dart';
import 'package:foxy/util/dbc_sync_progress.dart';
import 'package:foxy/util/dbc_sync_util.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// 真实 MySQL staging 验收。
///
/// 启用方式（任选其一）：
/// 1. 环境变量 `FOXY_TEST_MYSQL=1`，并设置
///    `FOXY_TEST_MYSQL_HOST/PORT/USER/PASSWORD/DATABASE`
/// 2. 或仓库根目录存在可用的 `config.yaml`，且设置 `FOXY_TEST_MYSQL=1`
///
/// 未启用时整组 skip，不阻断日常 `flutter test`。
void main() {
  final enabled = Platform.environment['FOXY_TEST_MYSQL'] == '1';

  group('DBC MySQL 集成', () {
    late MysqlConfig config;
    late Laconic laconic;
    late Directory workDir;
    final definition = dbcDefinitionByTable['dbc_spell_duration']!;
    final table = definition.qualifiedTableName;

    setUpAll(() async {
      config = await _loadMysqlConfig();
      laconic = Laconic(
        MysqlDriver(
          MysqlConfig(
            host: config.host,
            port: config.port,
            database: config.database,
            username: config.username,
            password: config.password,
          ),
        ),
      );
      // 连通性探测
      await laconic.select('SELECT 1');
    });

    tearDownAll(() async {
      try {
        await laconic.close();
      } catch (_) {}
    });

    setUp(() async {
      workDir = await Directory.systemTemp.createTemp('foxy_mysql_dbc_');
      await laconic.statement('CREATE DATABASE IF NOT EXISTS foxy');
      await laconic.statement('DROP TABLE IF EXISTS $table');
    });

    tearDown(() async {
      await laconic.statement('DROP TABLE IF EXISTS $table');
      // 清理可能残留的 staging
      try {
        final rows = await laconic.select(
          "SELECT TABLE_NAME FROM information_schema.TABLES "
          "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE "
          "'dbc_spell_duration__staging_%'",
        );
        for (final row in rows) {
          final name = row['TABLE_NAME'] as String;
          await laconic.statement('DROP TABLE IF EXISTS foxy.`$name`');
        }
      } catch (_) {}
      if (await workDir.exists()) {
        await workDir.delete(recursive: true);
      }
    });

    test('导入空库表后可导出相同行数', () async {
      await DbcExportUtil().write(
        definition: definition,
        rows: [
          {
            'ID': 101,
            'Duration': 1000,
            'DurationPerLevel': 0,
            'MaxDuration': 2000,
          },
          {
            'ID': 102,
            'Duration': 500,
            'DurationPerLevel': 1,
            'MaxDuration': 900,
          },
        ],
        outputDirectory: workDir.path,
      );

      final util = DbcSyncUtil();
      final events = await util
          .import(directory: workDir.path, mysqlConfig: config)
          .toList()
          .timeout(const Duration(minutes: 2));

      final result = events.whereType<DbcSyncResult>().single;
      expect(result.cancelled, isFalse, reason: result.errors.join('\n'));
      expect(result.errors, isEmpty, reason: result.errors.join('\n'));
      expect(result.completed, greaterThan(0));

      final count = await laconic.table(table).count();
      expect(count, 2);

      // 非空表再次导入应跳过，原表行数不变
      final second = await util
          .import(directory: workDir.path, mysqlConfig: config)
          .toList()
          .timeout(const Duration(minutes: 2));
      final secondResult = second.whereType<DbcSyncResult>().single;
      expect(secondResult.errors, isEmpty, reason: secondResult.errors.join());
      expect(secondResult.skipped, greaterThan(0));
      expect(await laconic.table(table).count(), 2);
    });

    test('staging 失败路径：正式表在失败后仍可查询（导入坏文件）', () async {
      // 先导入合法数据
      await DbcExportUtil().write(
        definition: definition,
        rows: [
          {
            'ID': 1,
            'Duration': 10,
            'DurationPerLevel': 0,
            'MaxDuration': 10,
          },
        ],
        outputDirectory: workDir.path,
      );
      final util = DbcSyncUtil();
      final first = await util
          .import(directory: workDir.path, mysqlConfig: config)
          .toList()
          .timeout(const Duration(minutes: 2));
      expect(first.whereType<DbcSyncResult>().single.errors, isEmpty);
      expect(await laconic.table(table).count(), 1);

      // 写入损坏 DBC，覆盖同名文件；因表非空，导入应跳过，原表不变
      await File(
        p.join(workDir.path, definition.fileName),
      ).writeAsBytes(const [0, 1, 2, 3, 4, 5]);

      final second = await util
          .import(directory: workDir.path, mysqlConfig: config)
          .toList()
          .timeout(const Duration(minutes: 2));
      final secondResult = second.whereType<DbcSyncResult>().single;
      // 非空跳过：不应用坏文件
      expect(await laconic.table(table).count(), 1);
      expect(secondResult.skipped, greaterThan(0));
    });
  }, skip: enabled ? false : '设置 FOXY_TEST_MYSQL=1 并提供 MySQL 连接后启用');
}

Future<MysqlConfig> _loadMysqlConfig() async {
  final env = Platform.environment;
  if (env['FOXY_TEST_MYSQL_HOST'] != null ||
      env['FOXY_TEST_MYSQL_USER'] != null) {
    return MysqlConfig(
      host: env['FOXY_TEST_MYSQL_HOST'] ?? '127.0.0.1',
      port: int.tryParse(env['FOXY_TEST_MYSQL_PORT'] ?? '') ?? 3306,
      database: env['FOXY_TEST_MYSQL_DATABASE'] ?? 'acore_world',
      username: env['FOXY_TEST_MYSQL_USER'] ?? 'acore',
      password: env['FOXY_TEST_MYSQL_PASSWORD'] ?? 'acore',
    );
  }

  final file = File('config.yaml');
  if (await file.exists()) {
    final yaml = loadYaml(await file.readAsString());
    if (yaml is Map) {
      return MysqlConfig(
        host: yaml['host']?.toString() ?? '127.0.0.1',
        port: int.tryParse(yaml['port']?.toString() ?? '') ?? 3306,
        database: yaml['database']?.toString() ?? 'acore_world',
        username: yaml['username']?.toString() ?? 'acore',
        password: yaml['password']?.toString() ?? 'acore',
      );
    }
  }

  return const MysqlConfig(
    host: '127.0.0.1',
    port: 3306,
    database: 'acore_world',
    username: 'acore',
    password: 'acore',
  );
}
