import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

enum DbcExportPhase { writing, validating, committing }

class DbcExportUtil {
  /// 供单元测试校验类型规范化规则（uint8 / bool / 字符串等）。
  @visibleForTesting
  dynamic normalizeValueForTest(
    Object? value, {
    required String format,
    String schemaName = 'Test',
    String fieldName = 'Field',
    int recordIndex = 0,
  }) {
    return _normalizeValue(
      value,
      format: format,
      schemaName: schemaName,
      fieldName: fieldName,
      recordIndex: recordIndex,
    );
  }

  Future<void> write({
    required DbcDefinition definition,
    required List<Map<String, dynamic>> rows,
    required String outputDirectory,
    void Function(DbcExportPhase phase)? onPhase,
  }) async {
    final directory = Directory(outputDirectory);
    if (!await directory.exists()) {
      throw FileSystemException('输出目录不存在', outputDirectory);
    }

    final records = <List<dynamic>>[];
    for (var index = 0; index < rows.length; index++) {
      records.add(_rowToRecord(rows[index], definition.schema, index));
    }

    final targetPath = p.join(outputDirectory, definition.fileName);
    final suffix = DateTime.now().microsecondsSinceEpoch;
    final temporaryPath = '$targetPath.foxy.$suffix.tmp';
    final backupPath = '$targetPath.foxy.$suffix.bak';
    final temporaryFile = File(temporaryPath);
    final backupFile = File(backupPath);
    final targetFile = File(targetPath);

    try {
      onPhase?.call(DbcExportPhase.writing);
      final writer = DbcWriter(temporaryPath, definition.schema.format);
      await writer.writeAsync(records);
      onPhase?.call(DbcExportPhase.validating);
      _validateWrittenFile(
        temporaryPath,
        definition.schema,
        expectedRecords: records.length,
      );
      onPhase?.call(DbcExportPhase.committing);
      await _replaceFile(
        temporaryFile: temporaryFile,
        targetFile: targetFile,
        backupFile: backupFile,
      );
    } finally {
      if (await temporaryFile.exists()) await temporaryFile.delete();
    }
  }

  List<dynamic> _rowToRecord(
    Map<String, dynamic> row,
    DbcSchema schema,
    int recordIndex,
  ) {
    final fieldByIndex = <int, Field>{
      for (final field in schema.fields) field.index: field,
    };

    return List<dynamic>.generate(schema.format.length, (index) {
      final format = schema.format[index];
      final field = fieldByIndex[index];
      if (field == null || field.type.isSkip || field.type == FieldType.sort) {
        return 0;
      }
      if (!row.containsKey(field.name)) {
        throw FormatException(
          '${schema.name} 第 ${recordIndex + 1} 条记录缺少字段 ${field.name}',
        );
      }
      final value = row[field.name];
      return _normalizeValue(
        value,
        format: format,
        schemaName: schema.name,
        fieldName: field.name,
        recordIndex: recordIndex,
      );
    });
  }

  dynamic _normalizeValue(
    Object? value, {
    required String format,
    required String schemaName,
    required String fieldName,
    required int recordIndex,
  }) {
    Never invalid(String expected) {
      throw FormatException(
        '$schemaName 第 ${recordIndex + 1} 条记录字段 $fieldName '
        '期望 $expected，实际为 ${value.runtimeType}: $value',
      );
    }

    int integer(String expected) {
      if (value is int) return value;
      if (value is num && value.isFinite && value == value.truncateToDouble()) {
        return value.toInt();
      }
      return invalid(expected);
    }

    int int32() {
      final number = integer('32 位有符号整数');
      if (number < -2147483648 || number > 2147483647) {
        return invalid('32 位有符号整数');
      }
      return number;
    }

    double float32() {
      if (value is! num || !value.isFinite) return invalid('有限浮点数');
      final number = value.toDouble();
      if (!number.isFinite || number.abs() > 3.4028234663852886e38) {
        return invalid('32 位浮点数');
      }
      return number;
    }

    String string() {
      if (value is! String || value.contains('\x00')) {
        return invalid('不包含 NUL 的字符串');
      }
      return value;
    }

    return switch (format) {
      's' => string(),
      'i' || 'n' => int32(),
      'b' => switch (integer('0—255 的整数')) {
        final number when number >= 0 && number <= 255 => number,
        _ => invalid('0—255 的整数'),
      },
      'f' => float32(),
      'l' => switch (value) {
        bool boolean => boolean,
        num number when number == 0 || number == 1 => number == 1,
        _ => invalid('布尔值或 0/1'),
      },
      'x' || 'X' || 'd' => 0,
      _ => throw FormatException('$schemaName 包含未知 DBC format: $format'),
    };
  }

  void _validateWrittenFile(
    String path,
    DbcSchema schema, {
    required int expectedRecords,
  }) {
    final loader = DbcLoader(path, schema.format);
    if (loader.recordCount != expectedRecords) {
      throw FormatException(
        '${schema.name} 回读行数不一致：'
        '期望 $expectedRecords，实际 ${loader.recordCount}',
      );
    }
    if (loader.fieldCount != schema.format.length) {
      throw FormatException(
        '${schema.name} 回读字段数不一致：'
        '期望 ${schema.format.length}，实际 ${loader.fieldCount}',
      );
    }
  }

  Future<void> _replaceFile({
    required File temporaryFile,
    required File targetFile,
    required File backupFile,
  }) async {
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
        // 目标文件已安全替换，残留 backup 不影响导出结果。
      }
    }
  }
}
