import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/mpq/mpq_export_worker.dart';
import 'package:foxy_game_file/foxy_game_file.dart';
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
      final inArchive = '${MpqFilePacker.dbcArchivePath}$dbcName';
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

  test('MpqExportWorker.buildPatch produces a readable archive with DBC files under DBFilesClient', () async {
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

  test(
    'MpqExportWorker.buildPatch replaces an existing archive of the same name',
    () async {
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
        expect(
          archive.files,
          contains('${MpqFilePacker.dbcArchivePath}${duration.fileName}'),
        );
      } finally {
        archive.close();
      }
    },
  );

  test('MpqExportWorker.buildPatch skips archive creation when all tables are empty', () async {
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

  test(
    'MpqExportWorker.buildPatch leaves no destination file when canceled',
    () async {
      final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');
      final summary = await MpqExportWorker.buildPatch(
        definitions: [duration, icon],
        loadRows: (_) async => durationRows(),
        mpqFilePath: mpqPath,
        isCancelled: () => true,
      );

      expect(summary.completed, 0);
      expect(await File(mpqPath).exists(), isFalse);
    },
  );

  test('Cancellation during MPQ packaging removes temporary files and leaves no destination file', () async {
    final mpqPath = p.join(outDir.path, 'patch-zhCN-5.mpq');
    // Allow four write-stage checks. Cancel during packing of the second file.
    var checks = 0;
    final summary = await MpqExportWorker.buildPatch(
      definitions: [duration, icon],
      loadRows: (table) async =>
          table == duration.tableName ? durationRows() : iconRows(),
      mpqFilePath: mpqPath,
      isCancelled: () => ++checks >= 6,
    );

    // Both tables were written. Interrupted packing leaves no target or temp file.
    expect(summary.completed, 2);
    expect(await File(mpqPath).exists(), isFalse);
    final leftovers = outDir.listSync().where(
      (entity) => entity is File && entity.path.toLowerCase().contains('.tmp'),
    );
    expect(leftovers, isEmpty);
  });

  test(
    'MpqExportWorker.buildPatch throws when the output directory is missing',
    () async {
      await expectLater(
        MpqExportWorker.buildPatch(
          definitions: [duration],
          loadRows: (_) async => durationRows(),
          mpqFilePath: p.join(outDir.path, 'missing', 'patch.mpq'),
          isCancelled: () => false,
        ),
        throwsA(isA<FileSystemException>()),
      );
    },
  );
}
