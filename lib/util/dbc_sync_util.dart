import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/database/database.dart';
import 'package:foxy/util/dbc_export_util.dart';
import 'package:foxy/util/dbc_import_worker.dart';
import 'package:foxy/util/dbc_sync_progress.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

typedef DbcExportRowLoader =
    Future<List<Map<String, dynamic>>> Function(String tableName);

/// 单次导入任务句柄：cancel 持有同一引用，可在 isolate spawn 完成后仍能 kill。
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

class DbcSyncUtil {
  final _exportUtil = DbcExportUtil();

  _ImportJobHandle? _activeImportJob;
  String? _activeJobId;
  bool _running = false;
  DbcSyncOperation? _operation;

  bool get isRunning => _running;
  DbcSyncOperation? get operation => _operation;

  Future<List<DbcTableCheckResult>> checkTables() async {
    final laconic = Database.instance.laconic;
    final existing = <String>{};

    try {
      final rows = await laconic.select(
        "SELECT TABLE_NAME FROM information_schema.TABLES "
        "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE 'dbc_%'",
      );
      existing.addAll(rows.map((row) => row['TABLE_NAME'] as String));
    } catch (error) {
      return [
        for (final definition in dbcDefinitions)
          DbcTableCheckResult(
            tableName: definition.tableName,
            state: DbcTableState.error,
            message: error.toString(),
          ),
      ];
    }

    final results = <DbcTableCheckResult>[];
    final present = <String>[];
    for (final definition in dbcDefinitions) {
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
        "SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS "
        "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE 'dbc_%'",
      );
      final columnsByTable = <String, Set<String>>{};
      for (final row in columnRows) {
        final table = row['TABLE_NAME'] as String;
        final column = (row['COLUMN_NAME'] as String).toLowerCase();
        columnsByTable.putIfAbsent(table, () => <String>{}).add(column);
      }
      for (final table in present) {
        final definition = dbcDefinitionByTable[table]!;
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
                "SELECT '$table' AS t, "
                "EXISTS(SELECT 1 FROM foxy.$table) AS has_rows",
          )
          .join(' UNION ALL ');
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

  Future<List<String>> checkRequiredTablesExist() async {
    final results = await checkTables();
    final errors = results.where(
      (result) =>
          result.state == DbcTableState.error ||
          result.state == DbcTableState.incompatible,
    );
    if (errors.isNotEmpty) {
      throw StateError('检查 DBC 表失败: ${errors.first.message}');
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

  Stream<DbcSyncProgress> import({
    required String directory,
    required MysqlConfig mysqlConfig,
  }) {
    final controller = StreamController<DbcSyncProgress>();

    if (_running) {
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

    _running = true;
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

  Stream<DbcSyncProgress> export({
    required List<DbcDefinition> definitions,
    required String outputDirectory,
    required DbcExportRowLoader loadRows,
  }) {
    final controller = StreamController<DbcSyncProgress>();

    if (_running) {
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

    if (definitions.isEmpty) {
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

    _running = true;
    _operation = DbcSyncOperation.export;
    unawaited(
      _runExport(
        controller: controller,
        definitions: List.unmodifiable(definitions),
        outputDirectory: outputDirectory,
        loadRows: loadRows,
      ),
    );
    return controller.stream;
  }

  Future<void> _runExport({
    required StreamController<DbcSyncProgress> controller,
    required List<DbcDefinition> definitions,
    required String outputDirectory,
    required DbcExportRowLoader loadRows,
  }) async {
    var completed = 0;
    var skipped = 0;
    final errors = <DbcSyncError>[];

    try {
      if (!await Directory(outputDirectory).exists()) {
        throw FileSystemException('输出目录不存在', outputDirectory);
      }

      for (var index = 0; index < definitions.length; index++) {
        final definition = definitions[index];
        var stage = DbcSyncStage.reading;
        var rowCount = 0;

        controller.add(
          DbcSyncStatus(
            operation: DbcSyncOperation.export,
            stage: stage,
            message: '正在读取 ${definition.fileName}...',
            fileName: definition.fileName,
          ),
        );

        try {
          final rows = await loadRows(definition.tableName);
          rowCount = rows.length;
          if (rows.isEmpty) {
            skipped++;
          } else {
            stage = DbcSyncStage.writing;
            await _exportUtil.write(
              definition: definition,
              rows: rows,
              outputDirectory: outputDirectory,
              onPhase: (phase) {
                stage = switch (phase) {
                  DbcExportPhase.writing => DbcSyncStage.writing,
                  DbcExportPhase.validating => DbcSyncStage.validating,
                  DbcExportPhase.committing => DbcSyncStage.committing,
                };
                final action = switch (phase) {
                  DbcExportPhase.writing => '写入',
                  DbcExportPhase.validating => '验证',
                  DbcExportPhase.committing => '提交',
                };
                controller.add(
                  DbcSyncStatus(
                    operation: DbcSyncOperation.export,
                    stage: stage,
                    message: '正在$action ${definition.fileName}...',
                    fileName: definition.fileName,
                  ),
                );
              },
            );
            completed++;
          }
        } catch (error) {
          LoggerUtil.instance.e('${definition.fileName} 导出异常: $error');
          errors.add(
            DbcSyncError(
              tableName: definition.tableName,
              fileName: definition.fileName,
              stage: stage,
              message: error.toString(),
            ),
          );
        }

        controller.add(
          DbcSyncCount(
            operation: DbcSyncOperation.export,
            fileName: definition.fileName,
            completedFiles: index + 1,
            totalFiles: definitions.length,
            processedRows: rowCount,
            totalRows: rowCount,
          ),
        );
      }
    } catch (error) {
      LoggerUtil.instance.e('DBC 导出异常: $error');
      errors.add(
        DbcSyncError(stage: DbcSyncStage.preparing, message: error.toString()),
      );
    } finally {
      if (!controller.isClosed) {
        controller.add(
          DbcSyncResult(
            operation: DbcSyncOperation.export,
            completed: completed,
            skipped: skipped,
            errors: errors,
          ),
        );
      }
      _clearActiveTask();
      if (!controller.isClosed) await controller.close();
    }
  }

  Future<void> cancel() async {
    if (!_running) return;
    if (_operation != DbcSyncOperation.import) return;

    // 持有 job 引用（非瞬时 isolate 快照），spawn 完成后仍可 kill。
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
      // spawn 可能刚完成：再读一次 job.isolate
      job.isolate?.kill(priority: Isolate.immediate);
      // 短暂轮询，覆盖「cancel 时 isolate 尚未赋值」的窗口
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
          jobId: job.jobId,
        ),
        onError: errorPort.sendPort,
        onExit: exitPort.sendPort,
        errorsAreFatal: true,
      );
      job.isolate = isolate;
      // 若在 spawn 完成前已请求强制取消，立即 kill。
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

  void _clearActiveTask() {
    _activeImportJob = null;
    _activeJobId = null;
    _operation = null;
    _running = false;
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

  Future<void> _cleanupStaging(String jobId) async {
    try {
      final tables = dbcDefinitions
          .map(
            (definition) => '${definition.qualifiedTableName}__staging_$jobId',
          )
          .join(', ');
      await Database.instance.laconic.statement('DROP TABLE IF EXISTS $tables');
    } catch (error) {
      LoggerUtil.instance.w('DBC 取消后清理 staging 表失败: $error');
    }
  }
}
