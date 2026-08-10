import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_header_guard.dart';
import 'package:foxy/infrastructure/dbc/dbc_row_order.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

Future<void> runDbcImportWorker(DbcImportWorkerArgs args) async {
  final (
    :sendPort,
    :directory,
    :host,
    :port,
    :database,
    :username,
    :password,
    :useSsl,
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
          useSsl: useSsl,
          // Non-TLS needs RSA public-key retrieval for MySQL 8's
          // caching_sha2_password (laconic_mysql 3.2.0 disables it by
          // default).
          allowPublicKeyRetrieval: !useSsl,
        ),
      ),
    );

    var connection = createConnection();
    laconic = connection;

    final existingRows = await connection.select(
      "select table_name from information_schema.tables "
      "where table_schema = 'foxy' and table_name like 'dbc_%'",
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
      // Import semantics: the DBC is the authoritative source, and its
      // content always replaces the live table (even non-empty ones). Users
      // who need to keep database data should back it up themselves.
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
          // On probe failure treat the table as incompatible and build
          // staging from the schema, avoiding LIKE on a broken table.
          compatible = false;
        }
      }

      final stagingShort = '${tableShort}__staging_$jobId';
      final staging = 'foxy.$stagingShort';
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
        // Compatible and existing: LIKE preserves indexes/constraints/collation.
        // Missing or incompatible: derive DDL from the DBC schema.
        if (targetExists && compatible) {
          await connection.statement(
            'create table $staging like ${file.tableName}',
          );
        } else {
          await _createTable(connection, staging, file.fields);
        }
        stagingExists = true;
        // LIKE from a legacy table (created before the row-order column
        // existed) inherits the missing column; the import still needs it
        // to store the original DBC file position.
        await _ensureRowOrderColumn(connection, stagingShort);

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
          throw ValidationException(
            'row count mismatch: parsed $importedRows rows, wrote $storedRows rows',
          );
        }
        final idRows = await connection.select(
          'select count(*) as total_rows, '
          'count(distinct `ID`) as distinct_ids from $staging',
        );
        if (idRows.isEmpty ||
            _asInt(idRows.first['total_rows']) !=
                _asInt(idRows.first['distinct_ids'])) {
          throw DuplicateKeyException('import data contains duplicate IDs');
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
            'rename table ${file.tableName} to $backup, $staging to ${file.tableName}',
          );
          stagingExists = false;
          committed = true;
          try {
            await connection.statement('drop table if exists $backup');
          } catch (_) {
            // The live table was replaced successfully; a failed backup
            // cleanup must not mark the import as failed.
          }
        } else {
          await connection.statement(
            'rename table $staging to ${file.tableName}',
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
            await connection.statement('drop table if exists $staging');
          } catch (_) {
            // Keep the original error; leftover staging carries the task ID
            // and cannot overwrite the live table.
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

/// DbcImportWorker helper functions.
abstract final class DbcImportWorker {
  /// Column list for the batched import INSERT; the hidden row-order column
  /// is appended last so each value tuple can carry the original DBC file
  /// position (see [DbcRowOrder.column]).
  static String insertColumns(List<String> fieldNames) => [
    for (final name in fieldNames) '`$name`',
    '`${DbcRowOrder.column}`',
  ].join(', ');

  /// One `(v1, ..., vn, rowOrder)` value tuple for the batched import INSERT;
  /// [rowOrder] is the record's position in the DBC file (0-based).
  static String valueTuple(List<String> values, int rowOrder) =>
      '(${values.join(',')},$rowOrder)';
}

int _asInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? -1;
}

Future<void> _createTable(
  Laconic laconic,
  String table,
  List<_FieldDef> fields,
) async {
  final columns = [
    for (final field in fields) '`${field.name}` ${field.sqlType}',
    '`${DbcRowOrder.column}` bigint null',
  ].join(',\n  ');
  if (fields.isEmpty) {
    throw ValidationException('$table has no importable fields');
  }
  await laconic.statement(
    'create table $table (\n  $columns\n) '
    'engine=innodb default charset=utf8mb4',
  );
}

/// Adds the hidden row-order column to [tableShort] if it is missing (a
/// staging table cloned from a legacy source table). Imported rows carry
/// their DBC file position here; see [DbcRowOrder.column].
Future<void> _ensureRowOrderColumn(Laconic laconic, String tableShort) async {
  final rows = await laconic.select(
    "select column_name from information_schema.columns "
    "where table_schema = 'foxy' and table_name = '$tableShort' "
    "and column_name = '${DbcRowOrder.column}'",
  );
  if (rows.isEmpty) {
    await laconic.statement(
      'alter table foxy.`$tableShort` '
      'add column `${DbcRowOrder.column}` bigint null',
    );
  }
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

  // Special strings use UTF-8 hex literals, avoiding any dependency on the
  // MySQL session's NO_BACKSLASH_ESCAPES setting while keeping multi-row
  // batch INSERT throughput.
  final hex = StringBuffer();
  for (final byte in utf8.encode(value)) {
    hex.write(byte.toRadixString(16).padLeft(2, '0'));
  }
  return "convert(X'$hex' using utf8mb4)";
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
  DbcHeaderGuard.assertPayloadSafe(file.path);
  final loader = DbcLoader(file.path, file.format);
  final recordCount = loader.recordCount;
  if (recordCount == 0) return 0;

  const maxBatchBytes = 1 << 20;
  final columns = DbcImportWorker.insertColumns([
    for (final field in file.fields) field.name,
  ]);
  final sqlPrefix = 'insert into $table ($columns) values ';
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
    final row = _recordSql(record, file.fields, record.index);
    final rowBytes = utf8.encode(row).length + (rows.isEmpty ? 0 : 1);
    if (rows.isEmpty && prefixBytes + rowBytes > maxBatchBytes) {
      throw ValidationException(
        '${file.name}.dbc record ${record.index + 1} exceeds the 1 MiB '
        'import batch limit',
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

/// uint64 values ≥2^63 cannot be represented in Dart's signed int64;
/// warcrafty reads them as negative int64, and writing a negative number
/// into a BIGINT UNSIGNED column fails with an opaque MySQL 1264. Surface
/// a field-indexed diagnostic instead of letting the raw driver error
/// through.
String _uint64ToString(dynamic record, int index) {
  final value = record.getInt64(index);
  if (value < 0) {
    throw ValidationException(
      'uint64 field $index has high bit set (value ≥ 2^63), '
      'which exceeds the signed 64-bit storage limit',
    );
  }
  return value.toString();
}

String _readAndEscape(dynamic record, int index, String type) {
  return switch (type) {
    'string' => _escapeString(record.getString(index) as String),
    'float' => record.getFloat(index).toString(),
    'int32' || 'id' => record.getInt(index).toString(),
    // uint32 read as unsigned: getInt turns flags ≥2^31 negative, so they
    // must be restored to positive before storing into an UNSIGNED column.
    'uint32' => record.getUint(index).toString(),
    'int64' => record.getInt64(index).toString(),
    // uint64 high bits (≥2^63) exceed Dart's int range: getInt64 goes
    // negative and BIGINT UNSIGNED rejects it with MySQL 1264 (opaque).
    // Detect it and surface a field-indexed message instead.
    'uint64' => _uint64ToString(record, index),
    'int16' || 'uint16' => record.getInt16(index).toString(),
    'int8' => record.getInt8(index).toString(),
    'uint8' => record.getUint8(index).toString(),
    'boolean' => record.getInt(index) != 0 ? '1' : '0',
    'sort' => 'NULL',
    _ => 'NULL',
  };
}

// warcrafty 1.0.2's public entry point does not actually export DbcRecord;
// keep dynamic here to avoid depending on private paths under
// package:warcrafty/src.
String _recordSql(dynamic record, List<_FieldDef> fields, int rowOrder) {
  final values = <String>[];
  for (final field in fields) {
    values.add(_readAndEscape(record, field.index, field.type));
  }
  return DbcImportWorker.valueTuple(values, rowOrder);
}

Future<List<_FileDef>> _scanDirectory(String directory) async {
  final dir = Directory(directory);
  if (!await dir.exists()) {
    throw FileSystemException('directory does not exist', directory);
  }

  final matched = <String, _FileDef>{};
  await for (final entry in dir.list()) {
    if (entry is! File) continue;
    final fileName = p.basename(entry.path);
    if (!fileName.toLowerCase().endsWith('.dbc')) continue;
    final definition = DbcDefinitions.byFileName[fileName.toLowerCase()];
    if (definition == null) continue;
    if (matched.containsKey(definition.tableName)) {
      throw ValidationException(
        'multiple files match ${definition.fileName} in the directory',
      );
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

void _sendStatus(
  SendPort sendPort,
  String stage,
  String message, [
  String? fileName,
]) {
  sendPort.send(('status', stage, message, fileName));
}

String _sqlType(FieldType type) {
  return switch (type) {
    FieldType.id => 'int not null primary key',
    FieldType.int32 => 'int',
    // Unsigned fields must create UNSIGNED columns: flags-like fields with
    // the high bit set (≥2^31) become negative when stored signed, the UI
    // shows negative values, and editing wowhead-style positive values fails
    // with 1264.
    FieldType.uint32 => 'int unsigned',
    FieldType.int64 => 'bigint',
    FieldType.uint64 => 'bigint unsigned',
    FieldType.int16 || FieldType.uint16 => 'smallint',
    FieldType.int8 || FieldType.uint8 => 'tinyint unsigned',
    FieldType.float => 'float',
    FieldType.string => 'text',
    FieldType.boolean => 'tinyint(1)',
    FieldType.sort => 'int',
    FieldType.unused || FieldType.unusedByte => 'int',
  };
}

/// Checks that the live table has all columns the current DBC schema
/// requires (case-insensitive).
Future<bool> _tableMatchesSchema(
  Laconic connection,
  String tableShort,
  List<_FieldDef> fields,
) async {
  final rows = await connection.select(
    "select column_name from information_schema.columns "
    "where table_schema = 'foxy' and table_name = '$tableShort'",
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

void _throwIfCancelled(bool cancelled) {
  if (cancelled) throw const _ImportCancelled();
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

typedef DbcImportWorkerArgs = ({
  SendPort sendPort,
  String directory,
  String host,
  int port,
  String database,
  String username,
  String password,
  bool useSsl,
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
