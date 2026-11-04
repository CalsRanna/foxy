import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

abstract final class MpqFilePacker {
  static const dbcArchivePath = r'DBFilesClient\';

  /// Packs every `.dbc` file in [directory] into a WoW patch MPQ at
  /// [mpqFilePath] under `DBFilesClient\`.
  ///
  /// Returns the number of files packed, including partial progress when
  /// cancelled. Cancellation leaves the target unchanged. Files are
  /// packed in sorted order; an empty directory produces no archive. The
  /// archive is written to a `.tmp` sibling first and atomically renamed
  /// over the target.
  static Future<int> packDbcFiles({
    required String directory,
    required String mpqFilePath,
    required bool Function() isCancelled,
    void Function(String stage, String message)? onStatus,
    void Function(
      String fileName,
      int completedFiles,
      int totalFiles,
      int processedRows,
      int? totalRows,
    )?
    onProgress,
  }) async {
    final source = Directory(directory);
    if (!await source.exists()) {
      throw FileSystemException('directory does not exist', directory);
    }

    final files = <File>[
      await for (final entity in source.list(followLinks: false))
        if (entity is File && entity.path.toLowerCase().endsWith('.dbc'))
          entity,
    ]..sort((left, right) => left.path.compareTo(right.path));
    if (files.isEmpty) {
      return 0;
    }

    onStatus?.call('packing', '正在打包 MPQ 补丁...');
    final tmpPath =
        '$mpqFilePath.foxy.${DateTime.now().microsecondsSinceEpoch}.tmp';
    var replaced = false;
    try {
      final archive = MpqArchive.create(
        tmpPath,
        maxFileCount: files.length + 2,
      );
      var packed = 0;
      try {
        for (final file in files) {
          if (isCancelled()) break;
          archive.addFile(
            '${MpqFilePacker.dbcArchivePath}${p.basename(file.path)}',
            file.readAsBytesSync(),
          );
          packed++;
          onProgress?.call(
            p.basename(file.path),
            packed,
            files.length,
            0,
            null,
          );
        }
      } finally {
        archive.close();
      }
      if (isCancelled()) {
        return packed;
      }

      await _replaceFile(targetPath: mpqFilePath, temporaryPath: tmpPath);
      replaced = true;
      return packed;
    } finally {
      if (!replaced) {
        try {
          await File(tmpPath).delete();
        } catch (_) {
          // A leftover tmp file never shadows the real archive.
        }
      }
    }
  }

  /// Atomic three-step replacement (target → .bak, tmp → target, drop .bak),
  /// the same pattern as DbcFileWriter's file commit.
  static Future<void> _replaceFile({
    required String targetPath,
    required String temporaryPath,
  }) async {
    final targetFile = File(targetPath);
    final backupPath =
        '$targetPath.foxy.${DateTime.now().microsecondsSinceEpoch}.bak';
    final backupFile = File(backupPath);
    final temporaryFile = File(temporaryPath);

    final hadTarget = await targetFile.exists();
    if (hadTarget) await targetFile.rename(backupFile.path);

    try {
      await temporaryFile.rename(targetFile.path);
    } catch (_) {
      if (hadTarget && await backupFile.exists()) {
        await backupFile.rename(targetFile.path);
      }
      rethrow;
    }

    if (await backupFile.exists()) {
      try {
        await backupFile.delete();
      } catch (_) {
        // The target archive has been safely replaced; a leftover backup
        // does not affect the result.
      }
    }
  }
}
