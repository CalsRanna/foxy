import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

/// MpqExportWorker helper functions.
abstract final class MpqExportWorker {
/// In-archive directory for DBC files, matching the WoW 3.3.5 client layout.
  static const dbcArchivePath = r'DBFilesClient\';

  /// Builds a WoW patch MPQ from database DBC tables.
  ///
  /// Writes the selected tables as `.dbc` files into a staging directory
  /// (reusing [DbcExportWorker.writeFiles]), then packs them into [mpqFilePath] under
  /// `DBFilesClient\`, the path the client looks for DBC overrides in.
  /// The archive is written to a `.tmp` sibling first and atomically renamed
  /// over the target (an existing patch of the same name is replaced).
  ///
  /// Returns the DBC-write aggregation; packing failures are appended to
  /// [DbcExportSummary.errors]. Cancellation between files leaves no target
  /// file behind and the caller reports `cancelled: true`.
  static Future<DbcExportSummary> buildPatch({
    required List<DbcDefinition> definitions,
    required DbcExportRowLoader loadRows,
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
    final outputDirectory = Directory(mpqFilePath).parent.path;
    if (!await Directory(outputDirectory).exists()) {
      throw FileSystemException(
        'output directory does not exist',
        outputDirectory,
      );
    }

    final staging = await Directory.systemTemp.createTemp('foxy_mpq_export_');
    try {
      final summary = await DbcExportWorker.writeFiles(
        definitions: definitions,
        loadRows: loadRows,
        outputDirectory: staging.path,
        isCancelled: isCancelled,
        onProgress: onProgress,
      );
      if (isCancelled()) return summary;

      onStatus?.call('packing', '正在打包 MPQ 补丁...');
      final files = <File>[
        await for (final entity in staging.list(followLinks: false))
          if (entity is File && entity.path.toLowerCase().endsWith('.dbc'))
            entity,
      ]..sort((left, right) => left.path.compareTo(right.path));
      if (files.isEmpty) return summary;

      final tmpPath =
          '$mpqFilePath.foxy.${DateTime.now().microsecondsSinceEpoch}.tmp';
      var replaced = false;
      try {
        final archive = MpqArchive.create(
          tmpPath,
          maxFileCount: files.length + 2,
        );
        try {
          for (final file in files) {
            if (isCancelled()) break;
            archive.addFile(
              '${MpqExportWorker.dbcArchivePath}${p.basename(file.path)}',
              file.readAsBytesSync(),
            );
          }
        } finally {
          archive.close();
        }
        if (isCancelled()) return summary;

        await _replaceFile(targetPath: mpqFilePath, temporaryPath: tmpPath);
        replaced = true;
      } finally {
        if (!replaced) {
          try {
            await File(tmpPath).delete();
          } catch (_) {
            // A leftover tmp file never shadows the real archive.
          }
        }
      }
      return summary;
    } finally {
      try {
        await staging.delete(recursive: true);
      } catch (_) {
        // A failed staging cleanup must not fail the export.
      }
    }
  }
}



/// Atomic three-step replacement (target → .bak, tmp → target, drop .bak),
/// the same pattern as DbcExportUtil's file commit.
Future<void> _replaceFile({
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

/// Isolate entry point for MPQ-patch export: connects to MySQL, writes the
/// selected tables into a staging directory and packs them into the target
/// MPQ. Message protocol matches the import/export workers.
Future<void> runMpqExportWorker(MpqExportWorkerArgs args) async {
  final (
    :sendPort,
    :tableNames,
    :mpqFilePath,
    :host,
    :port,
    :database,
    :username,
    :password,
    :useSsl,
  ) = args;
  final cancelPort = ReceivePort();
  var cancelled = false;
  final cancelSubscription = cancelPort.listen((message) {
    if (message == 'cancel') cancelled = true;
  });
  sendPort.send(('control', cancelPort.sendPort));

  Laconic? laconic;
  var workerStage = 'preparing';

  try {
    workerStage = 'scanning';
    _sendStatus(sendPort, workerStage, '正在准备导出 MPQ...');

    final definitions = <DbcDefinition>[
      for (final table in tableNames)
        DbcDefinitions.byTable[table] ??
            (throw ValidationException('unknown DBC table: $table')),
    ];
    if (definitions.isEmpty) {
      _sendResult(sendPort, 0, 0, const [], false);
      return;
    }

    laconic = Laconic(
      MysqlDriver(
        MysqlConfig(
          host: host,
          port: port,
          database: database,
          username: username,
          password: password,
          useSsl: useSsl,
          allowPublicKeyRetrieval: !useSsl,
        ),
      ),
    );

    final summary = await MpqExportWorker.buildPatch(
      definitions: definitions,
      loadRows: (table) => DbcExportWorker.loadRows(laconic!, table),
      mpqFilePath: mpqFilePath,
      isCancelled: () => cancelled,
      onStatus: (stage, message) => _sendStatus(sendPort, stage, message),
      onProgress: (fileName, completedFiles, totalFiles, processed, total) {
        _sendCount(
          sendPort,
          fileName,
          completedFiles,
          totalFiles,
          processed,
          total,
        );
      },
    );

    _sendResult(
      sendPort,
      summary.completed,
      summary.skipped,
      summary.errors,
      cancelled,
    );
  } catch (error) {
    _sendResult(sendPort, 0, 0, [
      _workerError(stage: workerStage, message: 'Worker 错误: $error'),
    ], false);
  } finally {
    await laconic?.close();
    await cancelSubscription.cancel();
    cancelPort.close();
  }
}

void _sendCount(
  SendPort sendPort,
  String fileName,
  int completedFiles,
  int totalFiles,
  int processedRows,
  int? totalRows,
) {
  sendPort.send((
    'count',
    fileName,
    completedFiles,
    totalFiles,
    processedRows,
    totalRows,
  ));
}

void _sendResult(
  SendPort sendPort,
  int completed,
  int skipped,
  List<Map<String, String?>> errors,
  bool cancelled,
) {
  sendPort.send(('result', completed, skipped, errors, cancelled));
}

void _sendStatus(
  SendPort sendPort,
  String stage,
  String message, [
  String? fileName,
]) {
  sendPort.send(('status', stage, message, fileName));
}

Map<String, String?> _workerError({
  String? tableName,
  String? fileName,
  required String stage,
  required String message,
}) {
  return {
    'tableName': tableName,
    'fileName': fileName,
    'stage': stage,
    'message': message,
  };
}

typedef MpqExportWorkerArgs = ({
  SendPort sendPort,
  List<String> tableNames,
  String mpqFilePath,
  String host,
  int port,
  String database,
  String username,
  String password,
  bool useSsl,
});

/// Isolate entry signature, injectable for tests (a fake entry replaces the
/// real worker without touching MySQL).
typedef MpqExportWorkerEntry = Future<void> Function(MpqExportWorkerArgs args);
