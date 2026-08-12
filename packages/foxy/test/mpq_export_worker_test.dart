import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/mpq_export_worker.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

void main() {
  late Directory tempDir;
  late Directory outDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_mpq_worker_');
    outDir = Directory(p.join(tempDir.path, 'out'))..createSync();
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  final duration = DbcDefinitions.byTable['dbc_spell_duration']!;
  final icon = DbcDefinitions.byTable['dbc_spell_icon']!;

  List<Map<String, dynamic>> durationRows() => [
    {'ID': 1, 'Duration': 1, 'DurationPerLevel': 0, 'MaxDuration': 1},
    {'ID': 2, 'Duration': 2, 'DurationPerLevel': 1, 'MaxDuration': 2},
  ];

  List<Map<String, dynamic>> iconRows() => [
    {
      'ID': 1,
      'Name': 'TestIcon',
      'TextureFilename': 'INV_Foo',
      'TextureFilename2': '',
      'TextureFilename3': '',
      'TextureFilename4': '',
      'TextureFilename5': '',
      'TextureFilename6': '',
      'TextureFilename7': '',
      'TextureFilename8': '',
      'TextureFilename9': '',
      'TextureFilename10': '',
      'TextureFilename11': '',
      'TextureFilename12': '',
      'TextureFilename13': '',
      'TextureFilename14': '',
      'TextureFilename15': '',
      'TextureFilename16': '',
      'TextureFilename17': '',
      'TextureFilename18': '',
      'TextureFilename19': '',
      'TextureFilename20': '',
      'TextureFilename21': '',
      'TextureFilename22': '',
      'TextureFilename23': '',
      'TextureFilename24': '',
      'TextureFilename25': '',
      'TextureFilename26': '',
      'TextureFilename27': '',
      'TextureFilename28': '',
      'TextureFilename29': '',
      'TextureFilename30': '',
    },
  ];

  /// Reads a DBC back out of the generated MPQ and verifies its rows.
  void expectArchiveDbc(String mpqPath, String dbcName, int expectedRecords) {
    final archive = MpqArchive.open(mpqPath);
    try {
      final inArchive = '${MpqExportWorker.dbcArchivePath}$dbcName';
      expect(archive.files, contains(inArchive));
      final bytes = archive.extract(inArchive);
      final tmp = File(p.join(tempDir.path, 'verify.dbc'))
        ..writeAsBytesSync(bytes);
      final loader = DbcLoader(tmp.path, duration.schema.format);
      expect(loader.recordCount, expectedRecords);
    } finally {
      archive.close();
    }
  }

  test('MpqExportWorker.buildPatch 打包 DBC 到 DBFilesClient 路径并可回读', () async {
    final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');
    final summary = await MpqExportWorker.buildPatch(
      definitions: [duration, icon],
      loadRows: (table) async =>
          table == duration.tableName ? durationRows() : iconRows(),
      mpqFilePath: mpqPath,
      isCancelled: () => false,
    );

    expect(summary.completed, 2);
    expect(summary.errors, isEmpty);
    expect(await File(mpqPath).exists(), isTrue);
    expectArchiveDbc(mpqPath, duration.fileName, 2);
  });

  test('MpqExportWorker.buildPatch 已存在同名 MPQ 时覆盖', () async {
    final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');
    // Pre-create a stale archive (one file, no DBCs).
    final stale = MpqArchive.create(mpqPath, maxFileCount: 4);
    stale.addFile(r'stale.txt', Uint8List(16));
    stale.close();

    final summary = await MpqExportWorker.buildPatch(
      definitions: [duration],
      loadRows: (_) async => durationRows(),
      mpqFilePath: mpqPath,
      isCancelled: () => false,
    );

    expect(summary.errors, isEmpty);
    final archive = MpqArchive.open(mpqPath);
    try {
      expect(archive.files, isNot(contains('stale.txt')));
      expect(archive.files, contains('${MpqExportWorker.dbcArchivePath}${duration.fileName}'));
    } finally {
      archive.close();
    }
  });

  test('MpqExportWorker.buildPatch 全部空表时不生成 MPQ', () async {
    final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');
    final summary = await MpqExportWorker.buildPatch(
      definitions: [duration, icon],
      loadRows: (_) async => [],
      mpqFilePath: mpqPath,
      isCancelled: () => false,
    );

    expect(summary.skipped, 2);
    expect(await File(mpqPath).exists(), isFalse);
  });

  test('MpqExportWorker.buildPatch 取消时不留下目标文件', () async {
    final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');
    final summary = await MpqExportWorker.buildPatch(
      definitions: [duration, icon],
      loadRows: (_) async => durationRows(),
      mpqFilePath: mpqPath,
      isCancelled: () => true,
    );

    expect(summary.completed, 0);
    expect(await File(mpqPath).exists(), isFalse);
  });

  test('MpqExportWorker.buildPatch 打包阶段中途取消 → 无目标文件且 tmp 清理', () async {
    final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');
    // 写表阶段放行前 4 次检查;打包阶段 addFile 循环的第 2 个文件时取消。
    var checks = 0;
    final summary = await MpqExportWorker.buildPatch(
      definitions: [duration, icon],
      loadRows: (table) async =>
          table == duration.tableName ? durationRows() : iconRows(),
      mpqFilePath: mpqPath,
      isCancelled: () => ++checks >= 6,
    );

    // 两表都在取消前写完;打包中断 → target 不存在,tmp 被清理。
    expect(summary.completed, 2);
    expect(await File(mpqPath).exists(), isFalse);
    final leftovers = outDir.listSync().where(
      (entity) => entity is File && entity.path.toLowerCase().contains('.tmp'),
    );
    expect(leftovers, isEmpty);
  });

  test('MpqExportWorker.buildPatch 输出目录不存在时抛错', () async {
    await expectLater(
      MpqExportWorker.buildPatch(
        definitions: [duration],
        loadRows: (_) async => durationRows(),
        mpqFilePath: p.join(outDir.path, 'missing', 'patch.mpq'),
        isCancelled: () => false,
      ),
      throwsA(isA<FileSystemException>()),
    );
  });

  group('packDbcFiles', () {
    late Directory srcDir;

    setUp(() {
      srcDir = Directory(p.join(tempDir.path, 'src'))..createSync();
    });

    test('打包已有 .dbc 文件目录为 MPQ 并可回读', () async {
      // 直接用真实 DBC 写入器产出合法 .dbc 文件,而非伪造字节。
      await DbcExportUtil().write(
        definition: duration,
        rows: durationRows(),
        outputDirectory: srcDir.path,
      );
      File(p.join(srcDir.path, 'notes.txt')).writeAsBytesSync([4]);
      final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');

      final summary = await MpqExportWorker.packDbcFiles(
        directory: srcDir.path,
        mpqFilePath: mpqPath,
        isCancelled: () => false,
      );

      expect(summary.completed, 1);
      expect(summary.errors, isEmpty);
      expect(await File(mpqPath).exists(), isTrue);
      expectArchiveDbc(mpqPath, duration.fileName, 2);
    });

    test('空目录不生成归档并返回空汇总', () async {
      final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');

      final summary = await MpqExportWorker.packDbcFiles(
        directory: srcDir.path,
        mpqFilePath: mpqPath,
        isCancelled: () => false,
      );

      expect(summary.completed, 0);
      expect(await File(mpqPath).exists(), isFalse);
    });

    test('目录不存在时抛 FileSystemException', () async {
      await expectLater(
        MpqExportWorker.packDbcFiles(
          directory: p.join(tempDir.path, 'missing'),
          mpqFilePath: p.join(outDir.path, 'patch.mpq'),
          isCancelled: () => false,
        ),
        throwsA(isA<FileSystemException>()),
      );
    });
  });
}
