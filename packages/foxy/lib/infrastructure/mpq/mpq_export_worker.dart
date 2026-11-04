import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:foxy_game_file/foxy_game_file.dart';

/// MpqExportWorker helper functions.
abstract final class MpqExportWorker {
  /// Builds a WoW patch MPQ from database DBC tables.
  ///
  /// Writes the selected tables as `.dbc` files into a staging directory
  /// (reusing [DbcExportWorker.writeFiles]), then packs them into
  /// [mpqFilePath] under `DBFilesClient\`, the path the client looks for DBC
  /// overrides in (reusing [MpqFilePacker.packDbcFiles]). The archive is
  /// written to a `.tmp` sibling first and atomically renamed over the target
  /// (an existing patch of the same name is replaced).
  ///
  /// Returns the DBC-write aggregation; packing failures propagate to the
  /// worker's error handler. Cancellation between files leaves no target
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

      await MpqFilePacker.packDbcFiles(
        directory: staging.path,
        mpqFilePath: mpqFilePath,
        isCancelled: isCancelled,
        onStatus: onStatus,
        onProgress: onProgress,
      );
      return summary;
    } finally {
      try {
        await staging.delete(recursive: true);
      } catch (_) {
        // A failed staging cleanup must not fail the export.
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
      onStatus: (stage, message) =>
          MpqExportWorker._sendStatus(sendPort, stage, message),
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
      MpqExportWorker._workerError(
        stage: workerStage,
        message: 'Worker 错误: $error',
      ),
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
    final packed = await MpqFilePacker.packDbcFiles(
      directory: directory,
      mpqFilePath: mpqFilePath,
      isCancelled: () => cancelled,
      onStatus: (stage, message) =>
          MpqExportWorker._sendStatus(sendPort, stage, message),
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

    MpqExportWorker._sendResult(sendPort, packed, 0, const [], cancelled);
  } catch (error) {
    MpqExportWorker._sendResult(sendPort, 0, 0, [
      MpqExportWorker._workerError(
        stage: workerStage,
        message: 'Worker 错误: $error',
      ),
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
