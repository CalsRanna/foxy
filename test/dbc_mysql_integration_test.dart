import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/util/dbc_export_util.dart';
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
/// 当前可执行用例仅验证：导出工具在隔离临时目录写出文件（无 MySQL 写操作）。
void main() {
  final enabled = Platform.environment['FOXY_TEST_MYSQL'] == '1';
  final schema = Platform.environment['FOXY_TEST_MYSQL_FOXY_SCHEMA']?.trim();
  final isolated =
      enabled &&
      schema != null &&
      schema.isNotEmpty &&
      schema.toLowerCase() != 'foxy';

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
    'DBC MySQL worker 集成（预留）',
    () {
      test('占位：待 worker 支持可配置 schema 后补回导入/overwrite/rebuild 用例', () {
        // 刻意空实现，避免误操作真实 foxy schema。
        expect(schema, isNot(equals('foxy')));
      });
    },
    skip: isolated
        ? false
        : '需 FOXY_TEST_MYSQL=1 且 FOXY_TEST_MYSQL_FOXY_SCHEMA 为非 foxy 的隔离 schema；'
              '完整 worker 覆盖/重建集成测尚未恢复',
  );
}
