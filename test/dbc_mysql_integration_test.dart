import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;

/// MySQL / 文件系统相关的安全验收桩。
///
/// DBC worker 目前硬编码 `foxy` schema，完整 worker 集成测需后续支持可配置 schema。
/// 本文件**故意不**调用 import worker，也不 DROP 默认 `foxy.*` 表。
///
/// 启用条件（全部满足才跑，否则 skip）：
/// - `FOXY_TEST_MYSQL=1`
/// - `FOXY_TEST_MYSQL_FOXY_SCHEMA` 已设置且 **不等于** `foxy`
///
void main() {
  final enabled = Platform.environment['FOXY_TEST_MYSQL'] == '1';
  final schema = Platform.environment['FOXY_TEST_MYSQL_FOXY_SCHEMA']?.trim();
  final isolated =
      enabled &&
      schema != null &&
      schema.isNotEmpty &&
      schema.toLowerCase() != 'foxy' &&
      RegExp(r'^[A-Za-z0-9_]+$').hasMatch(schema);
  const writeResultTable = '_foxy_write_result_contract';

  group('DBC 导出工具（无 DB 副作用）', () {
    late Directory workDir;
    final definition = dbcDefinitionByTable['dbc_spell_duration']!;

    setUp(() async {
      workDir = await Directory.systemTemp.createTemp('foxy_dbc_safe_');
    });

    tearDown(() async {
      if (await workDir.exists()) {
        await workDir.delete(recursive: true);
      }
    });

    test('写出确定性 DBC 文件到临时目录', () async {
      await DbcExportUtil().write(
        definition: definition,
        rows: [
          {
            'ID': 101,
            'Duration': 1000,
            'DurationPerLevel': 0,
            'MaxDuration': 2000,
          },
        ],
        outputDirectory: workDir.path,
      );
      final file = File(p.join(workDir.path, definition.fileName));
      expect(await file.exists(), isTrue);
      expect(await file.length(), greaterThan(0));
    });
  });

  group(
    'MySQL 写入结果（隔离 schema）',
    () {
      late Laconic laconic;
      final queries = <LaconicQuery>[];

      setUpAll(() async {
        laconic = Laconic(
          MysqlDriver(
            MysqlConfig(
              database: schema!,
              host: Platform.environment['FOXY_TEST_MYSQL_HOST'] ?? '127.0.0.1',
              password: Platform.environment['FOXY_TEST_MYSQL_PASSWORD'] ?? '',
              port:
                  int.tryParse(
                    Platform.environment['FOXY_TEST_MYSQL_PORT'] ?? '',
                  ) ??
                  3306,
              username:
                  Platform.environment['FOXY_TEST_MYSQL_USERNAME'] ?? 'root',
            ),
          ),
          listen: queries.add,
        );
        await laconic.statement('DROP TABLE IF EXISTS `$writeResultTable`');
        await laconic.statement(
          'CREATE TABLE `$writeResultTable` ('
          '`id` INT NOT NULL, '
          '`value` VARCHAR(32) NOT NULL, '
          'PRIMARY KEY (`id`)'
          ') ENGINE=InnoDB',
        );
      });

      setUp(() async {
        queries.clear();
        await laconic.statement('DELETE FROM `$writeResultTable`');
        await laconic.table(writeResultTable).insert([
          {'id': 1, 'value': 'alpha'},
          {'id': 2, 'value': 'beta'},
        ]);
        queries.clear();
      });

      tearDownAll(() async {
        await laconic.statement('DROP TABLE IF EXISTS `$writeResultTable`');
        await laconic.close();
      });

      test('UPDATE 区分变化、无变化和不存在', () async {
        final changedRows = await laconic
            .table(writeResultTable)
            .where('id', 1)
            .update({'value': 'changed'});
        final unchangedRows = await laconic
            .table(writeResultTable)
            .where('id', 2)
            .update({'value': 'beta'});
        final missingRows = await laconic
            .table(writeResultTable)
            .where('id', 999)
            .update({'value': 'missing'});

        expect(changedRows, 1);
        expect(unchangedRows, 1);
        expect(missingRows, 0);
      });

      test('DELETE 区分实际删除和不存在', () async {
        expect(
          await laconic.table(writeResultTable).where('id', 1).delete(),
          1,
        );
        expect(
          await laconic.table(writeResultTable).where('id', 999).delete(),
          0,
        );
      });

      test('重复键保留稳定 MySQL 错误码', () async {
        Object? error;
        try {
          await laconic.table(writeResultTable).where('id', 1).update({
            'id': 2,
          });
        } catch (caught) {
          error = caught;
        }

        expect(error, isNotNull);
        expect(MysqlErrorUtil.isDuplicateEntry(error!), isTrue);
      });

      test('参数化 LIMIT 1 写入返回结果并通知 listener', () async {
        final matchedRows = await laconic.affectingStatement(
          'UPDATE `$writeResultTable` SET `value` = ? '
          'WHERE `value` = ? ORDER BY `id` LIMIT 1',
          ['updated', 'alpha'],
        );
        final deletedRows = await laconic.affectingStatement(
          'DELETE FROM `$writeResultTable` WHERE `value` = ? LIMIT 1',
          ['updated'],
        );

        expect(matchedRows, 1);
        expect(deletedRows, 1);
        expect(queries[0].bindings, ['updated', 'alpha']);
        expect(queries[1].bindings, ['updated']);
      });

      test('事务连接同样使用 matched-row 语义', () async {
        await laconic.transaction(() async {
          final matchedRows = await laconic
              .table(writeResultTable)
              .where('id', 1)
              .update({'value': 'alpha'});
          expect(matchedRows, 1);
        });
      });
    },
    skip: isolated
        ? false
        : '需 FOXY_TEST_MYSQL=1 且 FOXY_TEST_MYSQL_FOXY_SCHEMA 为非 foxy 的隔离 schema；'
              '写入结果集成测试只能连接隔离 schema',
  );
}
