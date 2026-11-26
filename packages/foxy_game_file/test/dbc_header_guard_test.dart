import 'dart:io';
import 'dart:typed_data';

import 'package:foxy_game_file/foxy_game_file.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Verifies the DBC header payload cap: warcrafty's loader allocates
/// `recordCount × recordSize + stringBlockSize` with no upper bound, so a
/// malicious DBC header can claim up to 4 GiB and OOM the process. The
/// guard must reject oversized claims before the loader runs.
void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_dbc_guard_test_');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  void writeHeader(
    String name, {
    required int recordCount,
    int recordSize = 4,
    int stringBlockSize = 0,
  }) {
    final file = File(p.join(tempDir.path, name));
    final bytes = ByteData(20)
      ..setUint32(0, 0x43424457, Endian.little) // 'WDBC'
      ..setInt32(4, recordCount, Endian.little)
      ..setInt32(8, 1, Endian.little) // fieldCount
      ..setInt32(12, recordSize, Endian.little)
      ..setInt32(16, stringBlockSize, Endian.little);
    file.writeAsBytesSync(bytes.buffer.asUint8List());
  }

  test('Rejects oversized recordCount times recordSize', () {
    writeHeader('evil.dbc', recordCount: 1 << 30, recordSize: 1 << 20);
    expect(
      () => DbcHeaderGuard.assertPayloadSafe(p.join(tempDir.path, 'evil.dbc')),
      throwsA(isA<DbcFileException>()),
    );
  });

  test('Rejects an oversized stringBlockSize', () {
    writeHeader(
      'evil2.dbc',
      recordCount: 1,
      recordSize: 4,
      stringBlockSize: 1 << 30,
    );
    expect(
      () => DbcHeaderGuard.assertPayloadSafe(p.join(tempDir.path, 'evil2.dbc')),
      throwsA(isA<DbcFileException>()),
    );
  });

  test('Accepts a valid header', () {
    // Forty thousand rows at 300 bytes each use about 12 MB, below the cap.
    writeHeader(
      'ok.dbc',
      recordCount: 40000,
      recordSize: 300,
      stringBlockSize: 1 << 20,
    );
    expect(
      () => DbcHeaderGuard.assertPayloadSafe(p.join(tempDir.path, 'ok.dbc')),
      returnsNormally,
    );
  });

  test('Accepts exactly the size limit and rejects one byte above it', () {
    writeHeader(
      'boundary_ok.dbc',
      recordCount: DbcHeaderGuard.maxPayloadBytes ~/ 4,
      recordSize: 4,
      stringBlockSize: 0,
    );
    expect(
      () => DbcHeaderGuard.assertPayloadSafe(
        p.join(tempDir.path, 'boundary_ok.dbc'),
      ),
      returnsNormally,
    );
    writeHeader(
      'boundary_bad.dbc',
      recordCount: DbcHeaderGuard.maxPayloadBytes ~/ 4 + 1,
      recordSize: 4,
      stringBlockSize: 0,
    );
    expect(
      () => DbcHeaderGuard.assertPayloadSafe(
        p.join(tempDir.path, 'boundary_bad.dbc'),
      ),
      throwsA(isA<DbcFileException>()),
    );
  });

  test('Short files without headers pass through to DbcLoader', () {
    final file = File(p.join(tempDir.path, 'tiny.dbc'));
    file.writeAsBytesSync([1, 2, 3]);
    expect(() => DbcHeaderGuard.assertPayloadSafe(file.path), returnsNormally);
  });
}
