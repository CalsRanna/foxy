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
  /// (reusing [DbcExportWorker.writeFiles]), then packs them into
  /// [mpqFilePath] under `DBFilesClient\`, the path the client looks for DBC
  /// overrides in (reusing [MpqExportWorker.packDbcFiles]). The archive is
  /// written to a `.tmp` sibling first and atomically renamed over the target
  /// (an existing patch of the same name is replaced).
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

      final packSummary = await MpqExportWorker.packDbcFiles(
        directory: staging.path,
        mpqFilePath: mpqFilePath,
        isCancelled: isCancelled,
        onStatus: onStatus,
        onProgress: onProgress,
      );
      return DbcExportSummary(
        completed: summary.completed,
        skipped: summary.skipped,
        errors: [...summary.errors, ...packSummary.errors],
      );
    } finally {
      try {
        await staging.delete(recursive: true);
      } catch (_) {
        // A failed staging cleanup must not fail the export.
      }
    }
  }

  /// Packs every `.dbc` file in [directory] into a WoW patch MPQ at
  /// [mpqFilePath] under `DBFilesClient\`.
  ///
  /// Shared by [MpqExportWorker.buildPatch] (files just written into a
  /// staging dir) and the combined DBC+MPQ export (files already exported
  /// into a shared temp dir, avoiding a second database read). Files are
  /// packed in sorted order; an empty directory produces no archive. The
  /// archive is written to a `.tmp` sibling first and atomically renamed
  /// over the target.
  static Future<DbcExportSummary> packDbcFiles({
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
      return const DbcExportSummary(completed: 0, skipped: 0, errors: []);
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
            '${MpqExportWorker.dbcArchivePath}${p.basename(file.path)}',
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
        return DbcExportSummary(completed: packed, skipped: 0, errors: []);
      }

      await _replaceFile(targetPath: mpqFilePath, temporaryPath: tmpPath);
      replaced = true;
      return DbcExportSummary(completed: packed, skipped: 0, errors: []);
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
  /// the same pattern as DbcExportUtil's file commit.
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

  static void _sendCount(
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

  static void _sendResult(
    SendPort sendPort,
    int completed,
    int skipped,
    List<Map<String, String?>> errors,
    bool cancelled,
  ) {
    sendPort.send(('result', completed, skipped, errors, cancelled));
  }

  static void _sendStatus(
    SendPort sendPort,
    String stage,
    String message, [
    String? fileName,
  ]) {
    sendPort.send(('status', stage, message, fileName));
  }

  static Map<String, String?> _workerError({
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
    MpqExportWorker._sendStatus(sendPort, workerStage, '正在准备导出 MPQ...');

    final definitions = <DbcDefinition>[
      for (final table in tableNames)
        DbcDefinitions.byTable[table] ??
            (throw ValidationException('unknown DBC table: $table')),
    ];
    if (definitions.isEmpty) {
      MpqExportWorker._sendResult(sendPort, 0, 0, const [], false);
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
      onStatus: (stage, message) => MpqExportWorker._sendStatus(sendPort, stage, message),
      onProgress: (fileName, completedFiles, totalFiles, processed, total) {
        MpqExportWorker._sendCount(
          sendPort,
          fileName,
          completedFiles,
          totalFiles,
          processed,
          total,
        );
      },
    );

    // Warn about tables whose row-order data is missing (never re-imported
    // after the row-order migration), so the UI can prompt a re-import.
    final missingRowOrder = <String>[];
    for (final definition in definitions) {
      final hasMissing = await DbcExportWorker.hasMissingRowOrder(
        laconic,
        definition.tableName,
      );
      if (hasMissing) missingRowOrder.add(definition.fileName);
    }
    if (missingRowOrder.isNotEmpty) {
      sendPort.send(('warning', missingRowOrder));
    }

    MpqExportWorker._sendResult(
      sendPort,
      summary.completed,
      summary.skipped,
      summary.errors,
      cancelled,
    );
  } catch (error) {
    MpqExportWorker._sendResult(sendPort, 0, 0, [
      MpqExportWorker._workerError(stage: workerStage, message: 'Worker 错误: $error'),
    ], false);
  } finally {
    await laconic?.close();
    await cancelSubscription.cancel();
    cancelPort.close();
  }
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

/// Isolate entry point for packing an already-exported DBC directory into an
/// MPQ patch — the combined DBC+MPQ export flow, where the `.dbc` files come
/// from the shared temp dir instead of a second database read. No MySQL
/// connection is made. Message protocol matches the other workers.
Future<void> runMpqPackWorker(MpqPackWorkerArgs args) async {
  final (:sendPort, :directory, :mpqFilePath) = args;
  final cancelPort = ReceivePort();
  var cancelled = false;
  final cancelSubscription = cancelPort.listen((message) {
    if (message == 'cancel') cancelled = true;
  });
  sendPort.send(('control', cancelPort.sendPort));

  var workerStage = 'packing';

  try {
    final summary = await MpqExportWorker.packDbcFiles(
      directory: directory,
      mpqFilePath: mpqFilePath,
      isCancelled: () => cancelled,
      onStatus: (stage, message) => MpqExportWorker._sendStatus(sendPort, stage, message),
      onProgress: (fileName, completedFiles, totalFiles, processed, total) {
        MpqExportWorker._sendCount(
          sendPort,
          fileName,
          completedFiles,
          totalFiles,
          processed,
          total,
        );
      },
    );

    MpqExportWorker._sendResult(
      sendPort,
      summary.completed,
      summary.skipped,
      summary.errors,
      cancelled,
    );
  } catch (error) {
    MpqExportWorker._sendResult(sendPort, 0, 0, [
      MpqExportWorker._workerError(stage: workerStage, message: 'Worker 错误: $error'),
    ], false);
  } finally {
    await cancelSubscription.cancel();
    cancelPort.close();
  }
}

typedef MpqPackWorkerArgs = ({
  SendPort sendPort,
  String directory,
  String mpqFilePath,
});

/// Isolate entry signature, injectable for tests (a fake entry replaces the
/// real pack worker).
typedef MpqPackWorkerEntry = Future<void> Function(MpqPackWorkerArgs args);
