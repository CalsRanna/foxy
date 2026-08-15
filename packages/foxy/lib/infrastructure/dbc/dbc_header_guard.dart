import 'dart:io';
import 'dart:typed_data';

import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';

/// Hard cap on the DBC record payload claimed by a file header. warcrafty's
/// loader allocates the full `recordCount * recordSize + stringBlockSize`
/// payload before parsing, with no upper bound — a malicious/sparse DBC can
/// claim up to 4 GiB and OOM the process. Real tables are orders of
/// magnitude below this (a 16-locale wide table is ~50 MiB at most), so the
/// cap only rejects hostile files.
abstract final class DbcHeaderGuard {
  static const maxPayloadBytes = 512 << 20; // 512 MiB

  /// Reads the 20-byte DBC header and rejects files whose claimed payload
  /// exceeds [maxPayloadBytes] before warcrafty allocates it.
  static void assertPayloadSafe(String path) {
    final file = File(path);
    final header = file.openSync();
    try {
      if (header.lengthSync() < 20) {
        // DbcLoader reports the short header itself.
        return;
      }
      header.setPositionSync(0);
      final bytes = header.readSync(20);
      final view = ByteData.sublistView(bytes);
      final recordCount = view.getInt32(4, Endian.little);
      final recordSize = view.getInt32(12, Endian.little);
      final stringBlockSize = view.getInt32(16, Endian.little);
      // int32 * int32 + int32 is at most 2^62, which fits a 64-bit int.
      final payload = recordCount * recordSize + stringBlockSize;
      final safe =
          recordCount <= 0 ||
          recordSize <= 0 ||
          stringBlockSize < 0 ||
          payload <= maxPayloadBytes;
      if (!safe) {
        throw ValidationException(
          'DBC payload too large: $recordCount records × $recordSize bytes '
          '+ $stringBlockSize string block exceeds the $maxPayloadBytes '
          'byte safety cap ($path)',
        );
      }
    } finally {
      header.closeSync();
    }
  }
}
