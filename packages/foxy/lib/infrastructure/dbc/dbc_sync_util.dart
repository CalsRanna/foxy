import 'dart:async';
import 'dart:isolate';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_import_worker.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/mpq_export_worker.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:signals/signals.dart';

class DbcSyncUtil {
  /// Isolate entry for DBC export; injectable so tests can script worker
  /// behavior without a database.
  final DbcExportWorkerEntry exportWorkerEntry;

  /// Isolate entry for MPQ-patch export; injectable for tests.
  final MpqExportWorkerEntry mpqWorkerEntry;

  DbcSyncUtil({
    DbcExportWorkerEntry? exportWorkerEntry,
    MpqExportWorkerEntry? mpqWorkerEntry,
  }) : exportWorkerEntry = exportWorkerEntry ?? runDbcExportWorker,
       mpqWorkerEntry = mpqWorkerEntry ?? runMpqExportWorker;

  _ImportJobHandle? _activeImportJob;
  String? _activeJobId;
  _ExportJobHandle? _activeExportJob;

  /// Whether a DBC task (import/export/MPQ) is currently running. A signal
  /// (not a plain bool) so UI watchers can subscribe to task start/end —
  /// busy-state computations that short-circuit on `||` would otherwise lose
  /// the dependency and never rebuild when the task ends.
  final running = signal(false);
  DbcSyncOperation? _operation;

  bool get isRunning => running.value;
  DbcSyncOperation? get operation => _operation;

  Future<void> cancel() async {
    if (!running.value) return;
    if (_operation == DbcSyncOperation.export) {
      final job = _activeExportJob;
      if (job == null) return;

      job.cancelRequested = true;
      job.controlPort?.send('cancel');
      if (job.done.isCompleted) return;

      try {
        await job.done.future.timeout(const Duration(seconds: 3));
        return;
      } on TimeoutException {
        job.forceCancelTerminal = true;
        // spawn may have just completed: re-read job.isolate
        job.isolate?.kill(priority: Isolate.immediate);
        // Brief polling covers the window where the isolate is not yet
        // assigned at cancel time
        for (var i = 0; i < 10 && job.isolate == null; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 50));
        }
        job.isolate?.kill(priority: Isolate.immediate);
        final finish = job.finish;
        if (finish != null) {
          await finish(
            const DbcSyncResult(
              operation: DbcSyncOperation.export,
              completed: 0,
              skipped: 0,
              errors: [],
              cancelled: true,
            ),
          );
        }
      }
      return;
    }
    if (_operation != DbcSyncOperation.import) return;

    // Hold the job reference (not a transient isolate snapshot) so it can
    // still be killed after spawn completes.
    final job = _activeImportJob;
    if (job == null) return;

    job.cancelRequested = true;
    job.controlPort?.send('cancel');
    if (job.done.isCompleted) return;

    try {
      await job.done.future.timeout(const Duration(seconds: 3));
      return;
    } on TimeoutException {
      job.forceCancelTerminal = true;
      // spawn may have just completed: re-read job.isolate
      job.isolate?.kill(priority: Isolate.immediate);
      // Brief polling covers the window where the isolate is not yet
      // assigned at cancel time
      for (var i = 0; i < 10 && job.isolate == null; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
      job.isolate?.kill(priority: Isolate.immediate);
      try {
        await _cleanupStaging(job.jobId).timeout(const Duration(seconds: 5));
      } on TimeoutException {
        LoggerUtil.instance.w('DBC 取消后清理 staging 表超时: ${job.jobId}');
      }
      final finish = job.finish;
      if (finish != null) {
        await finish(
          const DbcSyncResult(
            operation: DbcSyncOperation.import,
            completed: 0,
            skipped: 0,
            errors: [],
            cancelled: true,
          ),
        );
      }
    }
  }

  Future<List<String>> checkRequiredTablesExist() async {
    final results = await checkTables();
    final errors = results.where(
      (result) =>
          result.state == DbcTableState.error ||
          result.state == DbcTableState.incompatible,
    );
    if (errors.isNotEmpty) {
      throw ValidationException(
        'DBC table check failed: ${errors.first.message}',
      );
    }
    return results
        .where(
          (result) =>
              result.state == DbcTableState.missing ||
              result.state == DbcTableState.empty,
        )
        .map((result) => result.tableName)
        .toList();
  }

  Future<List<DbcTableCheckResult>> checkTables() async {
    final laconic = Database.instance.laconic;
    final existing = <String>{};

    try {
      final rows = await laconic.select(
        "select table_name from information_schema.tables "
        "where table_schema = 'foxy' and table_name like 'dbc_%'",
      );
      existing.addAll(rows.map((row) => row['TABLE_NAME'] as String));
    } catch (error) {
      return [
        for (final definition in DbcDefinitions.all)
          DbcTableCheckResult(
            tableName: definition.tableName,
            state: DbcTableState.error,
            message: error.toString(),
          ),
      ];
    }

    final results = <DbcTableCheckResult>[];
    final present = <String>[];
    for (final definition in DbcDefinitions.all) {
      if (existing.contains(definition.tableName)) {
        present.add(definition.tableName);
      } else {
        results.add(
          DbcTableCheckResult(
            tableName: definition.tableName,
            state: DbcTableState.missing,
          ),
        );
      }
    }

    if (present.isEmpty) return results;

    final compatible = <String>[];
    try {
      final columnRows = await laconic.select(
        "select table_name, column_name from information_schema.columns "
        "where table_schema = 'foxy' and table_name like 'dbc_%'",
      );
      final columnsByTable = <String, Set<String>>{};
      for (final row in columnRows) {
        final table = row['TABLE_NAME'] as String;
        final column = (row['COLUMN_NAME'] as String).toLowerCase();
        columnsByTable.putIfAbsent(table, () => <String>{}).add(column);
      }
      for (final table in present) {
        final definition = DbcDefinitions.byTable[table]!;
        final expected = {
          for (final field in definition.schema.fields)
            if (!field.type.isSkip) field.name.toLowerCase(),
        };
        final actual = columnsByTable[table] ?? const <String>{};
        final missingColumns = expected.difference(actual);
        if (missingColumns.isNotEmpty) {
          results.add(
            DbcTableCheckResult(
              tableName: table,
              state: DbcTableState.incompatible,
              message: '缺少字段: ${missingColumns.join(', ')}',
            ),
          );
        } else {
          compatible.add(table);
        }
      }
    } catch (error) {
      for (final table in present) {
        results.add(
          DbcTableCheckResult(
            tableName: table,
            state: DbcTableState.error,
            message: error.toString(),
          ),
        );
      }
      results.sort((left, right) => left.tableName.compareTo(right.tableName));
      return results;
    }

    if (compatible.isEmpty) {
      results.sort((left, right) => left.tableName.compareTo(right.tableName));
      return results;
    }

    try {
      final union = compatible
          .map(
            (table) =>
                "select '$table' as t, "
                "exists(select 1 from foxy.$table) as has_rows",
          )
          .join(' union all ');
      final rows = await laconic.select(union);
      final rowState = {
        for (final row in rows) row['t'] as String: _truthy(row['has_rows']),
      };
      for (final table in compatible) {
        results.add(
          DbcTableCheckResult(
            tableName: table,
            state: rowState[table] == true
                ? DbcTableState.ready
                : DbcTableState.empty,
          ),
        );
      }
    } catch (error) {
      for (final table in compatible) {
        results.add(
          DbcTableCheckResult(
            tableName: table,
            state: DbcTableState.error,
            message: error.toString(),
          ),
        );
      }
    }

    results.sort((left, right) => left.tableName.compareTo(right.tableName));
    return results;
  }

  Stream<DbcSyncProgress> export({
    required List<DbcDefinition> definitions,
    required String outputDirectory,
    required MysqlConfig mysqlConfig,
  }) {
    final controller = StreamController<DbcSyncProgress>();
    final immutable = List<DbcDefinition>.unmodifiable(definitions);

    if (running.value) {
      controller
        ..add(
          const DbcSyncResult(
            operation: DbcSyncOperation.export,
            completed: 0,
            skipped: 0,
            errors: [
              DbcSyncError(
                stage: DbcSyncStage.preparing,
                message: '已有 DBC 任务正在运行',
              ),
            ],
          ),
        )
        ..close();
      return controller.stream;
    }

    if (immutable.isEmpty) {
      controller
        ..add(
          const DbcSyncResult(
            operation: DbcSyncOperation.export,
            completed: 0,
            skipped: 0,
            errors: [],
          ),
        )
        ..close();
      return controller.stream;
    }

    running.value = true;
    _operation = DbcSyncOperation.export;
    final job = _ExportJobHandle();
    _activeExportJob = job;
    unawaited(
      _startExport(
        controller: controller,
        workerEntry: exportWorkerEntry,
        buildArgs: (sendPort) => (
          sendPort: sendPort,
          tableNames: [
            for (final definition in immutable) definition.tableName,
          ],
          outputDirectory: outputDirectory,
          host: mysqlConfig.host,
          port: mysqlConfig.port,
          database: mysqlConfig.database,
          username: mysqlConfig.username,
          password: mysqlConfig.password,
          useSsl: mysqlConfig.useSsl,
        ),
        job: job,
      ),
    );
    return controller.stream;
  }

  /// Exports the selected DBC tables as a WoW patch MPQ (see
  /// `mpq_export_worker.dart` for the in-archive layout).
  Stream<DbcSyncProgress> exportMpq({
    required List<DbcDefinition> definitions,
    required String mpqFilePath,
    required MysqlConfig mysqlConfig,
  }) {
    final controller = StreamController<DbcSyncProgress>();
    final immutable = List<DbcDefinition>.unmodifiable(definitions);

    if (running.value) {
      controller
        ..add(
          const DbcSyncResult(
            operation: DbcSyncOperation.export,
            completed: 0,
            skipped: 0,
            errors: [
              DbcSyncError(
                stage: DbcSyncStage.preparing,
                message: '已有 DBC 任务正在运行',
              ),
            ],
          ),
        )
        ..close();
      return controller.stream;
    }

    if (immutable.isEmpty) {
      controller
        ..add(
          const DbcSyncResult(
            operation: DbcSyncOperation.export,
            completed: 0,
            skipped: 0,
            errors: [],
          ),
        )
        ..close();
      return controller.stream;
    }

    running.value = true;
    _operation = DbcSyncOperation.export;
    final job = _ExportJobHandle();
    _activeExportJob = job;
    unawaited(
      _startExport(
        controller: controller,
        workerEntry: mpqWorkerEntry,
        buildArgs: (sendPort) => (
          sendPort: sendPort,
          tableNames: [
            for (final definition in immutable) definition.tableName,
          ],
          mpqFilePath: mpqFilePath,
          host: mysqlConfig.host,
          port: mysqlConfig.port,
          database: mysqlConfig.database,
          username: mysqlConfig.username,
          password: mysqlConfig.password,
          useSsl: mysqlConfig.useSsl,
        ),
        job: job,
      ),
    );
    return controller.stream;
  }

  Stream<DbcSyncProgress> import({
    required String directory,
    required MysqlConfig mysqlConfig,
  }) {
    final controller = StreamController<DbcSyncProgress>();

    if (running.value) {
      controller
        ..add(
          DbcSyncResult(
            operation: DbcSyncOperation.import,
            completed: 0,
            skipped: 0,
            errors: const [
              DbcSyncError(
                stage: DbcSyncStage.preparing,
                message: '已有 DBC 任务正在运行',
              ),
            ],
          ),
        )
        ..close();
      return controller.stream;
    }

    running.value = true;
    _operation = DbcSyncOperation.import;
    final jobId = DateTime.now().microsecondsSinceEpoch.toString();
    final job = _ImportJobHandle(jobId);
    _activeImportJob = job;
    _activeJobId = jobId;
    unawaited(
      _startImport(
        controller: controller,
        directory: directory,
        mysqlConfig: mysqlConfig,
        job: job,
      ),
    );
    return controller.stream;
  }

  Future<void> _cleanupStaging(String jobId) async {
    try {
      // Clean up both __staging_ and __backup_ tables: a hard-kill window
      // (after rename, before drop) can leave backup tables behind, which
      // checkTables' LIKE 'dbc_%' would otherwise match.
      final tables = DbcDefinitions.all
          .map(
            (definition) => [
              '${definition.qualifiedTableName}__staging_$jobId',
              '${definition.qualifiedTableName}__backup_$jobId',
            ],
          )
          .expand((t) => t)
          .join(', ');
      await Database.instance.laconic.statement('drop table if exists $tables');
    } catch (error) {
      LoggerUtil.instance.w('DBC 取消后清理 staging/backup 表失败: $error');
    }
  }

  void _clearActiveTask() {
    _activeImportJob = null;
    _activeJobId = null;
    _activeExportJob = null;
    _operation = null;
    running.value = false;
  }

  /// Runs an export-style isolate task (DBC export or MPQ patch export) and
  /// relays the worker's `status`/`count`/`result` messages onto the stream.
  /// The worker entry is injected so tests can fake the whole worker.
  Future<void> _startExport<T>({
    required StreamController<DbcSyncProgress> controller,
    required Future<void> Function(T args) workerEntry,
    required T Function(SendPort sendPort) buildArgs,
    required _ExportJobHandle job,
  }) async {
    final receivePort = ReceivePort();
    final errorPort = ReceivePort();
    final exitPort = ReceivePort();
    var terminal = false;
    StreamSubscription<dynamic>? messageSubscription;
    StreamSubscription<dynamic>? errorSubscription;
    StreamSubscription<dynamic>? exitSubscription;

    Future<void> finish(DbcSyncResult result) async {
      if (terminal) return;
      terminal = true;
      if (!controller.isClosed) controller.add(result);
      await messageSubscription?.cancel();
      await errorSubscription?.cancel();
      await exitSubscription?.cancel();
      receivePort.close();
      errorPort.close();
      exitPort.close();
      _clearActiveTask();
      if (!job.done.isCompleted) {
        job.done.complete();
      }
      if (!controller.isClosed) await controller.close();
    }

    job.finish = finish;

    try {
      messageSubscription = receivePort.listen((message) {
        switch (message) {
          case ('control', SendPort controlPort):
            job.controlPort = controlPort;
            if (job.cancelRequested) controlPort.send('cancel');
          case ('status', String stage, String text, String? fileName):
            if (!controller.isClosed) {
              controller.add(
                DbcSyncStatus(
                  operation: DbcSyncOperation.export,
                  stage: _parseStage(stage),
                  message: text,
                  fileName: fileName,
                ),
              );
            }
          case (
            'count',
            String fileName,
            int completedFiles,
            int totalFiles,
            int processedRows,
            int? totalRows,
          ):
            if (!controller.isClosed) {
              controller.add(
                DbcSyncCount(
                  operation: DbcSyncOperation.export,
                  fileName: fileName,
                  completedFiles: completedFiles,
                  totalFiles: totalFiles,
                  processedRows: processedRows,
                  totalRows: totalRows,
                ),
              );
            }
          case (
            'result',
            int completed,
            int skipped,
            List errors,
            bool cancelled,
          ):
            unawaited(
              finish(
                DbcSyncResult(
                  operation: DbcSyncOperation.export,
                  completed: completed,
                  skipped: skipped,
                  errors: [
                    for (final error in errors) _parseWorkerError(error),
                  ],
                  cancelled: cancelled,
                ),
              ),
            );
        }
      });

      errorSubscription = errorPort.listen((message) {
        if (job.forceCancelTerminal || job.cancelRequested) {
          unawaited(
            finish(
              const DbcSyncResult(
                operation: DbcSyncOperation.export,
                completed: 0,
                skipped: 0,
                errors: [],
                cancelled: true,
              ),
            ),
          );
          return;
        }
        final text = message is List && message.isNotEmpty
            ? message.first.toString()
            : message.toString();
        unawaited(
          finish(
            DbcSyncResult(
              operation: DbcSyncOperation.export,
              completed: 0,
              skipped: 0,
              errors: [
                DbcSyncError(
                  stage: DbcSyncStage.writing,
                  message: 'Worker 异常退出: $text',
                ),
              ],
            ),
          ),
        );
      });

      exitSubscription = exitPort.listen((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        if (!terminal) {
          if (job.forceCancelTerminal || job.cancelRequested) {
            await finish(
              const DbcSyncResult(
                operation: DbcSyncOperation.export,
                completed: 0,
                skipped: 0,
                errors: [],
                cancelled: true,
              ),
            );
            return;
          }
          await finish(
            const DbcSyncResult(
              operation: DbcSyncOperation.export,
              completed: 0,
              skipped: 0,
              errors: [
                DbcSyncError(
                  stage: DbcSyncStage.writing,
                  message: 'Worker 未返回结果就已退出',
                ),
              ],
            ),
          );
        }
      });

      final isolate = await Isolate.spawn(
        workerEntry,
        buildArgs(receivePort.sendPort),
        onError: errorPort.sendPort,
        onExit: exitPort.sendPort,
        errorsAreFatal: true,
      );
      job.isolate = isolate;
      // If a forced cancel was requested before spawn completed, kill
      // immediately.
      if (job.forceCancelTerminal || job.cancelRequested) {
        isolate.kill(priority: Isolate.immediate);
      }
    } catch (error) {
      LoggerUtil.instance.e('DBC 导出异常: $error');
      await finish(
        DbcSyncResult(
          operation: DbcSyncOperation.export,
          completed: 0,
          skipped: 0,
          errors: [
            DbcSyncError(
              stage: DbcSyncStage.preparing,
              message: error.toString(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _startImport({
    required StreamController<DbcSyncProgress> controller,
    required String directory,
    required MysqlConfig mysqlConfig,
    required _ImportJobHandle job,
  }) async {
    final receivePort = ReceivePort();
    final errorPort = ReceivePort();
    final exitPort = ReceivePort();
    var terminal = false;
    StreamSubscription<dynamic>? messageSubscription;
    StreamSubscription<dynamic>? errorSubscription;
    StreamSubscription<dynamic>? exitSubscription;

    Future<void> finish(DbcSyncResult result) async {
      if (terminal) return;
      terminal = true;
      if (!controller.isClosed) controller.add(result);
      await messageSubscription?.cancel();
      await errorSubscription?.cancel();
      await exitSubscription?.cancel();
      receivePort.close();
      errorPort.close();
      exitPort.close();
      if (_activeJobId == job.jobId) {
        _clearActiveTask();
      }
      if (!job.done.isCompleted) {
        job.done.complete();
      }
      if (!controller.isClosed) await controller.close();
    }

    job.finish = finish;

    try {
      messageSubscription = receivePort.listen((message) {
        switch (message) {
          case ('control', SendPort controlPort):
            job.controlPort = controlPort;
            if (job.cancelRequested) controlPort.send('cancel');
          case ('status', String stage, String text, String? fileName):
            if (!controller.isClosed) {
              controller.add(
                DbcSyncStatus(
                  operation: DbcSyncOperation.import,
                  stage: _parseStage(stage),
                  message: text,
                  fileName: fileName,
                ),
              );
            }
          case (
            'count',
            String fileName,
            int completedFiles,
            int totalFiles,
            int processedRows,
            int? totalRows,
          ):
            if (!controller.isClosed) {
              controller.add(
                DbcSyncCount(
                  operation: DbcSyncOperation.import,
                  fileName: fileName,
                  completedFiles: completedFiles,
                  totalFiles: totalFiles,
                  processedRows: processedRows,
                  totalRows: totalRows,
                ),
              );
            }
          case (
            'result',
            int completed,
            int skipped,
            List errors,
            bool cancelled,
          ):
            unawaited(
              finish(
                DbcSyncResult(
                  operation: DbcSyncOperation.import,
                  completed: completed,
                  skipped: skipped,
                  errors: [
                    for (final error in errors) _parseWorkerError(error),
                  ],
                  cancelled: cancelled,
                ),
              ),
            );
        }
      });

      errorSubscription = errorPort.listen((message) {
        if (job.forceCancelTerminal || job.cancelRequested) {
          unawaited(
            finish(
              const DbcSyncResult(
                operation: DbcSyncOperation.import,
                completed: 0,
                skipped: 0,
                errors: [],
                cancelled: true,
              ),
            ),
          );
          return;
        }
        final text = message is List && message.isNotEmpty
            ? message.first.toString()
            : message.toString();
        unawaited(
          finish(
            DbcSyncResult(
              operation: DbcSyncOperation.import,
              completed: 0,
              skipped: 0,
              errors: [
                DbcSyncError(
                  stage: DbcSyncStage.writing,
                  message: 'Worker 异常退出: $text',
                ),
              ],
            ),
          ),
        );
      });

      exitSubscription = exitPort.listen((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        if (!terminal) {
          if (job.forceCancelTerminal || job.cancelRequested) {
            await finish(
              const DbcSyncResult(
                operation: DbcSyncOperation.import,
                completed: 0,
                skipped: 0,
                errors: [],
                cancelled: true,
              ),
            );
            return;
          }
          await finish(
            const DbcSyncResult(
              operation: DbcSyncOperation.import,
              completed: 0,
              skipped: 0,
              errors: [
                DbcSyncError(
                  stage: DbcSyncStage.writing,
                  message: 'Worker 未返回结果就已退出',
                ),
              ],
            ),
          );
        }
      });

      final isolate = await Isolate.spawn(
        runDbcImportWorker,
        (
          sendPort: receivePort.sendPort,
          directory: directory,
          host: mysqlConfig.host,
          port: mysqlConfig.port,
          database: mysqlConfig.database,
          username: mysqlConfig.username,
          password: mysqlConfig.password,
          useSsl: mysqlConfig.useSsl,
          jobId: job.jobId,
        ),
        onError: errorPort.sendPort,
        onExit: exitPort.sendPort,
        errorsAreFatal: true,
      );
      job.isolate = isolate;
      // If a forced cancel was requested before spawn completed, kill
      // immediately.
      if (job.forceCancelTerminal || job.cancelRequested) {
        isolate.kill(priority: Isolate.immediate);
      }
    } catch (error) {
      LoggerUtil.instance.e('DBC 导入异常: $error');
      await finish(
        DbcSyncResult(
          operation: DbcSyncOperation.import,
          completed: 0,
          skipped: 0,
          errors: [
            DbcSyncError(
              stage: DbcSyncStage.preparing,
              message: error.toString(),
            ),
          ],
        ),
      );
    }
  }

  static DbcSyncStage _parseStage(String value) {
    return DbcSyncStage.values.firstWhere(
      (stage) => stage.name == value,
      orElse: () => DbcSyncStage.preparing,
    );
  }

  static DbcSyncError _parseWorkerError(Object? value) {
    if (value is Map) {
      return DbcSyncError(
        tableName: value['tableName']?.toString(),
        fileName: value['fileName']?.toString(),
        stage: _parseStage(value['stage']?.toString() ?? ''),
        message: value['message']?.toString() ?? '未知 Worker 错误',
      );
    }
    return DbcSyncError(
      stage: DbcSyncStage.writing,
      message: value?.toString() ?? '未知 Worker 错误',
    );
  }

  static bool _truthy(Object? value) {
    return value == 1 || value == true || value == '1';
  }
}

/// Handle for a single import task: cancel holds the same reference, so it
/// can still kill the isolate after spawn completes.
class _ImportJobHandle {
  final String jobId;
  final Completer<void> done = Completer<void>();
  Isolate? isolate;
  SendPort? controlPort;
  Future<void> Function(DbcSyncResult result)? finish;
  bool cancelRequested = false;
  bool forceCancelTerminal = false;

  _ImportJobHandle(this.jobId);
}

/// Handle for a single export-style task (DBC export / MPQ patch export),
/// mirroring [_ImportJobHandle] minus the staging-table job id.
class _ExportJobHandle {
  final Completer<void> done = Completer<void>();
  Isolate? isolate;
  SendPort? controlPort;
  Future<void> Function(DbcSyncResult result)? finish;
  bool cancelRequested = false;
  bool forceCancelTerminal = false;
}
