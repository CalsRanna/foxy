import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

typedef DbcImportWorkerArgs = ({
  SendPort sendPort,
  String directory,
  String host,
  int port,
  String database,
  String username,
  String password,
  String jobId,
});

typedef _FieldDef = ({int index, String name, String type, String sqlType});

typedef _FileDef = ({
  String name,
  String path,
  String tableName,
  String format,
  List<_FieldDef> fields,
});

typedef _WorkerError = Map<String, String?>;

final class _ImportCancelled implements Exception {
  const _ImportCancelled();
}

Future<void> runDbcImportWorker(DbcImportWorkerArgs args) async {
  final (
    :sendPort,
    :directory,
    :host,
    :port,
    :database,
    :username,
    :password,
    :jobId,
  ) = args;
  final cancelPort = ReceivePort();
  var cancelled = false;
  final cancelSubscription = cancelPort.listen((message) {
    if (message == 'cancel') cancelled = true;
  });
  sendPort.send(('control', cancelPort.sendPort));

  Laconic? laconic;
  var completed = 0;
  var skipped = 0;
  final errors = <_WorkerError>[];
  var workerStage = 'preparing';

  try {
    _throwIfCancelled(cancelled);
    workerStage = 'scanning';
    _sendStatus(sendPort, 'scanning', '正在扫描 DBC 目录...');
    final files = await _scanDirectory(directory);
    if (files.isEmpty) {
      errors.add(
        _workerError(
          stage: 'scanning',
          message: '未在目录中找到需要的 DBC 文件。\n目录：$directory',
        ),
      );
      _sendResult(sendPort, completed, skipped, errors, false);
      return;
    }

    _sendCount(sendPort, '扫描完成', 0, files.length, 0, null);
    _throwIfCancelled(cancelled);
    workerStage = 'preparing';

    Laconic createConnection() => Laconic(
      MysqlDriver(
        MysqlConfig(
          host: host,
          port: port,
          database: database,
          username: username,
          password: password,
        ),
      ),
    );

    var connection = createConnection();
    laconic = connection;

    final existingRows = await connection.select(
      "SELECT TABLE_NAME FROM information_schema.TABLES "
      "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE 'dbc_%'",
    );
    final existingTables = {
      for (final row in existingRows) row['TABLE_NAME'] as String,
    };
    for (var index = 0; index < files.length; index++) {
      _throwIfCancelled(cancelled);
      workerStage = 'reading';
      final file = files[index];
      _sendStatus(
        sendPort,
        'reading',
        '正在处理 ${file.name}.dbc...',
        '${file.name}.dbc',
      );

      final tableShort = file.tableName.substring('foxy.'.length);
      final targetExists = existingTables.contains(tableShort);
      // 导入语义：DBC 为权威来源，始终用 DBC 内容替换正式表（含非空表）。
      // 用户若需保留库内数据，应自行备份。
      var compatible = false;
      if (targetExists) {
        try {
          compatible = await _tableMatchesSchema(
            connection,
            tableShort,
            file.fields,
          );
        } catch (_) {
          await connection.close();
          connection = createConnection();
          laconic = connection;
          // 探测失败时按不兼容处理，用 schema 建 staging，避免 LIKE 坏表。
          compatible = false;
        }
      }

      final staging = 'foxy.${tableShort}__staging_$jobId';
      final backup = 'foxy.${tableShort}__backup_$jobId';
      var stagingExists = false;
      var committed = false;
      var finalRowCount = 0;
      var stage = 'writing';

      try {
        _sendStatus(
          sendPort,
          'writing',
          '正在准备 ${file.name}.dbc 导入表...',
          '${file.name}.dbc',
        );
        // 兼容且已存在：LIKE 保留索引/约束/排序规则。
        // 不存在或不兼容：按 DBC schema 推导 DDL。
        if (targetExists && compatible) {
          await connection.statement(
            'CREATE TABLE $staging LIKE ${file.tableName}',
          );
        } else {
          await _createTable(connection, staging, file.fields);
        }
        stagingExists = true;

        final importedRows = await connection.transaction(
          () => _importFile(
            connection,
            file,
            staging,
            sendPort,
            index,
            files.length,
            () => cancelled,
          ),
        );
        _throwIfCancelled(cancelled);
        if (importedRows == 0) {
          skipped++;
          _sendCount(
            sendPort,
            '${file.name}.dbc',
            index + 1,
            files.length,
            0,
            0,
          );
          continue;
        }
        finalRowCount = importedRows;

        stage = 'validating';
        _sendStatus(
          sendPort,
          stage,
          '正在验证 ${file.name}.dbc...',
          '${file.name}.dbc',
        );
        final storedRows = await connection.table(staging).count();
        if (storedRows != importedRows) {
          throw StateError('导入行数不一致：解析 $importedRows 行，写入 $storedRows 行');
        }
        final idRows = await connection.select(
          'SELECT COUNT(*) AS total_rows, '
          'COUNT(DISTINCT `ID`) AS distinct_ids FROM $staging',
        );
        if (idRows.isEmpty ||
            _asInt(idRows.first['total_rows']) !=
                _asInt(idRows.first['distinct_ids'])) {
          throw StateError('导入数据包含重复 ID');
        }

        _throwIfCancelled(cancelled);
        stage = 'committing';
        _sendStatus(
          sendPort,
          'committing',
          '正在提交 ${file.name}.dbc...',
          '${file.name}.dbc',
        );
        if (targetExists) {
          await connection.statement(
            'RENAME TABLE ${file.tableName} TO $backup, $staging TO ${file.tableName}',
          );
          stagingExists = false;
          committed = true;
          try {
            await connection.statement('DROP TABLE IF EXISTS $backup');
          } catch (_) {
            // 正式表已成功替换，backup 清理失败不应反向标记导入失败。
          }
        } else {
          await connection.statement(
            'RENAME TABLE $staging TO ${file.tableName}',
          );
          stagingExists = false;
          committed = true;
        }
        completed++;
        existingTables.add(tableShort);
      } on _ImportCancelled {
        rethrow;
      } catch (error) {
        errors.add(
          _workerError(
            tableName: tableShort,
            fileName: '${file.name}.dbc',
            stage: stage,
            message: error.toString(),
          ),
        );
      } finally {
        if (!committed && stagingExists) {
          try {
            await connection.statement('DROP TABLE IF EXISTS $staging');
          } catch (_) {
            // 保留原始错误；残留 staging 带有任务 ID，不会覆盖正式表。
          }
        }
      }

      _sendCount(
        sendPort,
        '${file.name}.dbc',
        index + 1,
        files.length,
        finalRowCount,
        finalRowCount == 0 ? null : finalRowCount,
      );
    }

    _sendResult(sendPort, completed, skipped, errors, false);
  } on _ImportCancelled {
    _sendResult(sendPort, completed, skipped, errors, true);
  } catch (error) {
    errors.add(_workerError(stage: workerStage, message: 'Worker 错误: $error'));
    _sendResult(sendPort, completed, skipped, errors, false);
  } finally {
    await laconic?.close();
    await cancelSubscription.cancel();
    cancelPort.close();
  }
}

Future<List<_FileDef>> _scanDirectory(String directory) async {
  final dir = Directory(directory);
  if (!await dir.exists()) {
    throw FileSystemException('目录不存在', directory);
  }

  final matched = <String, _FileDef>{};
  await for (final entry in dir.list()) {
    if (entry is! File) continue;
    final fileName = p.basename(entry.path);
    if (!fileName.toLowerCase().endsWith('.dbc')) continue;
    final definition = dbcDefinitionByFileName[fileName.toLowerCase()];
    if (definition == null) continue;
    if (matched.containsKey(definition.tableName)) {
      throw StateError('目录中存在多个 ${definition.fileName} 匹配文件');
    }
    matched[definition.tableName] = (
      name: definition.schema.name,
      path: entry.path,
      tableName: definition.qualifiedTableName,
      format: definition.schema.format,
      fields: [
        for (final field in definition.schema.fields)
          if (!field.type.isSkip)
            (
              index: field.index,
              name: field.name,
              type: field.type.name,
              sqlType: _sqlType(field.type),
            ),
      ],
    );
  }

  return matched.values.toList()
    ..sort((left, right) => left.name.compareTo(right.name));
}

/// 检查正式表是否包含当前 DBC schema 所需的全部列（大小写不敏感）。
Future<bool> _tableMatchesSchema(
  Laconic connection,
  String tableShort,
  List<_FieldDef> fields,
) async {
  final rows = await connection.select(
    "SELECT COLUMN_NAME FROM information_schema.COLUMNS "
    "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME = '$tableShort'",
  );
  final actual = {
    for (final row in rows) (row['COLUMN_NAME'] as String).toLowerCase(),
  };
  for (final field in fields) {
    if (!actual.contains(field.name.toLowerCase())) {
      return false;
    }
  }
  return true;
}

Future<void> _createTable(
  Laconic laconic,
  String table,
  List<_FieldDef> fields,
) async {
  final columns = fields
      .map((field) => '`${field.name}` ${field.sqlType}')
      .join(',\n  ');
  if (columns.isEmpty) {
    throw StateError('$table 没有可导入字段');
  }
  await laconic.statement(
    'CREATE TABLE $table (\n  $columns\n) '
    'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4',
  );
}

Future<int> _importFile(
  Laconic laconic,
  _FileDef file,
  String table,
  SendPort sendPort,
  int completedFiles,
  int totalFiles,
  bool Function() isCancelled,
) async {
  final loader = DbcLoader(file.path, file.format);
  final recordCount = loader.recordCount;
  if (recordCount == 0) return 0;

  const maxBatchBytes = 1 << 20;
  final columns = file.fields.map((field) => '`${field.name}`').join(', ');
  final sqlPrefix = 'INSERT INTO $table ($columns) VALUES ';
  final prefixBytes = utf8.encode(sqlPrefix).length;
  final rows = <String>[];
  var batchBytes = prefixBytes;
  var imported = 0;

  Future<void> flush() async {
    if (rows.isEmpty) return;
    await laconic.statement('$sqlPrefix${rows.join(',')}');
    imported += rows.length;
    rows.clear();
    batchBytes = prefixBytes;
    _sendCount(
      sendPort,
      '${file.name}.dbc',
      completedFiles,
      totalFiles,
      imported,
      recordCount,
    );
  }

  for (final record in loader.records) {
    _throwIfCancelled(isCancelled());
    final row = _recordSql(record, file.fields);
    final rowBytes = utf8.encode(row).length + (rows.isEmpty ? 0 : 1);
    if (rows.isEmpty && prefixBytes + rowBytes > maxBatchBytes) {
      throw StateError(
        '${file.name}.dbc 第 ${record.index + 1} 条记录超过 1 MiB 导入批次上限',
      );
    }
    if (rows.isNotEmpty && batchBytes + rowBytes > maxBatchBytes) {
      await flush();
      _throwIfCancelled(isCancelled());
    }
    rows.add(row);
    batchBytes += rowBytes;
  }
  await flush();
  return imported;
}

// warcrafty 1.0.2 的公共入口未实际导出 DbcRecord；这里保留 dynamic，
// 避免依赖 package:warcrafty/src 下的私有实现路径。
String _recordSql(dynamic record, List<_FieldDef> fields) {
  final values = <String>[];
  for (final field in fields) {
    values.add(_readAndEscape(record, field.index, field.type));
  }
  return '(${values.join(',')})';
}

String _readAndEscape(dynamic record, int index, String type) {
  return switch (type) {
    'string' => _escapeString(record.getString(index) as String),
    'float' => record.getFloat(index).toString(),
    'int32' || 'id' => record.getInt(index).toString(),
    'uint8' => record.getUint8(index).toString(),
    'boolean' => record.getInt(index) != 0 ? '1' : '0',
    'sort' => 'NULL',
    _ => 'NULL',
  };
}

String _escapeString(String value) {
  if (!value.contains('\\') &&
      !value.contains("'") &&
      !value.contains('\x00') &&
      !value.contains('\n') &&
      !value.contains('\r') &&
      !value.contains('\x1a')) {
    return "'$value'";
  }

  // 特殊字符串使用 UTF-8 十六进制字面量，避免依赖 MySQL session 的
  // NO_BACKSLASH_ESCAPES 设置，同时保持多行批量 INSERT 的吞吐。
  final hex = StringBuffer();
  for (final byte in utf8.encode(value)) {
    hex.write(byte.toRadixString(16).padLeft(2, '0'));
  }
  return "CONVERT(X'$hex' USING utf8mb4)";
}

String _sqlType(FieldType type) {
  return switch (type) {
    FieldType.id => 'INT NOT NULL PRIMARY KEY',
    FieldType.int32 => 'INT',
    FieldType.uint8 => 'TINYINT UNSIGNED',
    FieldType.float => 'FLOAT',
    FieldType.string => 'TEXT',
    FieldType.boolean => 'TINYINT(1)',
    FieldType.sort => 'INT',
    FieldType.unused || FieldType.unusedByte => 'INT',
  };
}

void _throwIfCancelled(bool cancelled) {
  if (cancelled) throw const _ImportCancelled();
}

int _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? -1;
}

void _sendStatus(
  SendPort sendPort,
  String stage,
  String message, [
  String? fileName,
]) {
  sendPort.send(('status', stage, message, fileName));
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
  List<_WorkerError> errors,
  bool cancelled,
) {
  sendPort.send(('result', completed, skipped, errors, cancelled));
}

_WorkerError _workerError({
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
