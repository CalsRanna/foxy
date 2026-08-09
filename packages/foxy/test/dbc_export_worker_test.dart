import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory tempDir;
  late Directory outDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_export_worker_');
    outDir = Directory(p.join(tempDir.path, 'out'))..createSync();
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  final duration = dbcDefinitionByTable['dbc_spell_duration']!;
  final icon = dbcDefinitionByTable['dbc_spell_icon']!;

  List<Map<String, dynamic>> durationRows() => [
    {
      'ID': 1,
      'Duration': 1,
      'DurationPerLevel': 0,
      'MaxDuration': 1,
    },
    {
      'ID': 2,
      'Duration': 2,
      'DurationPerLevel': 1,
      'MaxDuration': 2,
    },
  ];

  test('导出 SQL: 有行序列时按原文件顺序排序,新行(NULL)排在末尾', () {
    expect(
      dbcExportSelectSql('dbc_talent', hasRowOrder: true),
      'select * from foxy.dbc_talent order by (__dbc_order is null) asc, '
      '__dbc_order asc, `ID` asc',
    );
  });

  test('导出 SQL: 无行序列的旧表保持原样(无 ORDER BY)', () {
    expect(
      dbcExportSelectSql('dbc_talent', hasRowOrder: false),
      'select * from foxy.dbc_talent',
    );
  });

  test('writeDbcFiles 写出文件且可回读', () async {
    final summary = await writeDbcFiles(
      definitions: [duration],
      loadRows: (_) async => durationRows(),
      outputDirectory: outDir.path,
      isCancelled: () => false,
    );

    expect(summary.completed, 1);
    expect(summary.skipped, 0);
    expect(summary.errors, isEmpty);

    final path = p.join(outDir.path, duration.fileName);
    final loader = DbcLoader(path, duration.schema.format);
    expect(loader.recordCount, 2);
  });

  test('writeDbcFiles 空表跳过且不生成文件', () async {
    final summary = await writeDbcFiles(
      definitions: [duration],
      loadRows: (_) async => [],
      outputDirectory: outDir.path,
      isCancelled: () => false,
    );

    expect(summary.completed, 0);
    expect(summary.skipped, 1);
    expect(await File(p.join(outDir.path, duration.fileName)).exists(), isFalse);
  });

  test('writeDbcFiles 单表失败记录错误且不影响其余表', () async {
    final summary = await writeDbcFiles(
      definitions: [duration, icon],
      loadRows: (table) async {
        if (table == duration.tableName) return durationRows();
        // Missing TextureFilename → DbcExportUtil rejects the row.
        return [
          {'ID': 1},
        ];
      },
      outputDirectory: outDir.path,
      isCancelled: () => false,
    );

    expect(summary.completed, 1);
    expect(summary.errors, hasLength(1));
    expect(summary.errors.single['fileName'], icon.fileName);
    expect(
      await File(p.join(outDir.path, duration.fileName)).exists(),
      isTrue,
    );
    expect(await File(p.join(outDir.path, icon.fileName)).exists(), isFalse);
  });

  test('writeDbcFiles 取消标志在表之间中断', () async {
    var cancelled = false;
    final summary = await writeDbcFiles(
      definitions: [duration, icon],
      loadRows: (_) async => durationRows(),
      outputDirectory: outDir.path,
      isCancelled: () => cancelled,
    );

    expect(summary.completed, 1);
    // The first table completed before the flag was set; no more work runs.
    cancelled = true;
    final second = await writeDbcFiles(
      definitions: [duration, icon],
      loadRows: (_) async => durationRows(),
      outputDirectory: outDir.path,
      isCancelled: () => cancelled,
    );
    expect(second.completed, 0);
  });

  test('writeDbcFiles 输出目录不存在时抛错', () async {
    await expectLater(
      writeDbcFiles(
        definitions: [duration],
        loadRows: (_) async => durationRows(),
        outputDirectory: p.join(outDir.path, 'missing'),
        isCancelled: () => false,
      ),
      throwsA(isA<FileSystemException>()),
    );
  });
}
