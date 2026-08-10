import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_row_order.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

/// DbcExportWorker helper functions.
abstract final class DbcExportWorker {
  /// Writes DBC files for [definitions] into [outputDirectory].
  ///
  /// Shared by the plain DBC-export worker and the MPQ-patch worker (which
  /// writes into a staging directory first). Per-table isolation mirrors the
  /// import worker: one failing table records an error and the others
  /// continue. Empty tables are skipped without producing a file.
  static Future<DbcExportSummary> writeFiles({
    required List<DbcDefinition> definitions,
    required DbcExportRowLoader loadRows,
    required String outputDirectory,
    required bool Function() isCancelled,
    void Function(
      String fileName,
      int completedFiles,
      int totalFiles,
      int processedRows,
      int? totalRows,
    )?
    onProgress,
  }) async {
    final directory = Directory(outputDirectory);
    if (!await directory.exists()) {
      throw FileSystemException(
        'output directory does not exist',
        outputDirectory,
      );
    }

    var completed = 0;
    var skipped = 0;
    final errors = <Map<String, String?>>[];

    for (var index = 0; index < definitions.length; index++) {
      if (isCancelled()) break;
      final definition = definitions[index];
      var processedRows = 0;

      try {
        final rows = await loadRows(definition.tableName);
        if (isCancelled()) break;
        processedRows = rows.length;
        if (rows.isEmpty) {
          skipped++;
        } else {
          await DbcExportUtil().write(
            definition: definition,
            rows: rows,
            outputDirectory: outputDirectory,
          );
          completed++;
        }
      } catch (error) {
        errors.add(
          _workerError(
            tableName: definition.tableName,
            fileName: definition.fileName,
            stage: 'writing',
            message: error.toString(),
          ),
        );
      }

      onProgress?.call(
        definition.fileName,
        index + 1,
        definitions.length,
        processedRows,
        processedRows,
      );
    }
    return DbcExportSummary(
      completed: completed,
      skipped: skipped,
      errors: errors,
    );
  }

  /// SELECT used to load one DBC table for export, in the original DBC file
  /// order when [hasRowOrder]: imported rows by their stored file position,
  /// app-created rows (NULL) appended last in ID order. Order-sensitive DBCs
  /// such as Talent.dbc rely on this — the 3.3.5 client derives the
  /// talent-tree layout from the file row order. Legacy tables fall back to
  /// the historical unordered scan (InnoDB primary-key order).
  static String selectSql(String tableName, {required bool hasRowOrder}) {
    final orderBy = hasRowOrder
        ? ' order by (${DbcRowOrder.column} is null) asc, '
              '${DbcRowOrder.column} asc, `ID` asc'
        : '';
    return 'select * from foxy.$tableName$orderBy';
  }

  /// Whether [tableName] carries the hidden row-order column (see
  /// [DbcRowOrder.column]); tables imported before the column existed do not
  /// have it.
  static Future<bool> tableHasRowOrderColumn(
    Laconic laconic,
    String tableName,
  ) async {
    final rows = await laconic.select(
      "select column_name from information_schema.columns "
      "where table_schema = 'foxy' and table_name = '$tableName' "
      "and column_name = '${DbcRowOrder.column}'",
    );
    return rows.isNotEmpty;
  }

  /// Loads one DBC table for export, preserving the original file row order
  /// when the table stores it. Shared by the plain DBC-export worker and the
  /// MPQ-patch worker. The hidden row-order column is stripped from the
  /// returned rows so consumers only ever see schema fields.
  static Future<List<Map<String, dynamic>>> loadRows(
    Laconic laconic,
    String tableName,
  ) async {
    final hasRowOrder = await DbcExportWorker.tableHasRowOrderColumn(
      laconic,
      tableName,
    );
    final rows = await laconic.select(
      DbcExportWorker.selectSql(tableName, hasRowOrder: hasRowOrder),
    );
    return [
      for (final row in rows)
        Map<String, dynamic>.from(row.toMap())..remove(DbcRowOrder.column),
    ];
  }

  /// Whether the rows of [tableName] still carry a NULL row-order column
  /// (i.e. never re-imported after the row-order migration). Shared by the
  /// export workers so the UI can warn before order-sensitive DBCs export
  /// scrambled.
  static Future<bool> hasMissingRowOrder(Laconic laconic, String tableName) async {
    final hasColumn = await DbcExportWorker.tableHasRowOrderColumn(
      laconic,
      tableName,
    );
    if (!hasColumn) return true;
    final rows = await laconic.select(
      'select count(*) as c from foxy.$tableName '
      'where `${DbcRowOrder.column}` is null',
    );
    final count = rows.isNotEmpty
        ? (rows.first.toMap()['c'] as num?)?.toInt() ?? 0
        : 0;
    return count > 0;
  }
}

/// Loads the rows of one DBC table (table name → rows). Kept injectable so
/// the export core can be unit-tested without a database.
typedef DbcExportRowLoader =
    Future<List<Map<String, dynamic>>> Function(String tableName);

/// Aggregated result of [DbcExportWorker.writeFiles]; `errors` uses the worker wire
/// format (map list) so it can travel back through the SendPort as-is.
final class DbcExportSummary {
  final int completed;
  final int skipped;
  final List<Map<String, String?>> errors;

  const DbcExportSummary({
    required this.completed,
    required this.skipped,
    required this.errors,
  });
}

/// Isolate entry point for DBC export: connects to MySQL, reads each table
/// and writes `.dbc` files into [DbcExportWorkerArgs.outputDirectory].
///
/// Message protocol matches the import worker:
/// `('control', SendPort)` / `('status', stage, msg, fileName?)` /
/// `('count', fileName, completed, total, processed, totalRows?)` /
/// `('result', completed, skipped, errors, cancelled)`.
Future<void> runDbcExportWorker(DbcExportWorkerArgs args) async {
  final (
    :sendPort,
    :tableNames,
    :outputDirectory,
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
    _sendStatus(sendPort, workerStage, '正在准备导出...');

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

    final summary = await DbcExportWorker.writeFiles(
      definitions: definitions,
      loadRows: (table) => DbcExportWorker.loadRows(laconic!, table),
      outputDirectory: outputDirectory,
      isCancelled: () => cancelled,
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

typedef DbcExportWorkerArgs = ({
  SendPort sendPort,
  List<String> tableNames,
  String outputDirectory,
  String host,
  int port,
  String database,
  String username,
  String password,
  bool useSsl,
});

/// Isolate entry signature, injectable for tests (a fake entry replaces the
/// real worker without touching MySQL).
typedef DbcExportWorkerEntry = Future<void> Function(DbcExportWorkerArgs args);
