import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:path/path.dart' as p;
import 'package:warcrafty/warcrafty.dart';

enum DbcExportPhase { writing, validating, committing }

class DbcExportUtil {
  /// Probes whether files can be created in [path] (e.g. macOS sandbox or
  /// permission failures surface here as an explicit Chinese error instead
  /// of a cryptic "Cannot open file" from inside the worker).
  static Future<void> ensureWritableDirectory(String path) async {
    final probe = File(
      p.join(path, '.foxy_write_test_${DateTime.now().microsecondsSinceEpoch}'),
    );
    try {
      await probe.writeAsString('');
    } catch (error) {
      // FileSystemException has a dedicated foxyErrorMessage mapping;
      // English message (Chinese copy comes from the mapping by type).
      throw FileSystemException(
        'output directory is not writable: $path ($error)',
        path,
      );
    } finally {
      try {
        await probe.delete();
      } catch (_) {
        // A failed cleanup of the probe file does not affect the result.
      }
    }
  }

  /// Copies every `.dbc` file from [sourceDirectory] into [targetDirectory].
  ///
  /// Each file is copied to a `.tmp` sibling first and atomically renamed
  /// over the target (mirroring [write]'s commit), so a crash never leaves a
  /// truncated DBC in place. Used after exporting into a temp directory (the
  /// DBC export and the combined DBC+MPQ export both land files in the
  /// target this way). Copying continues across individual failures, which
  /// are returned as committing-stage [DbcSyncError]s.
  static Future<List<DbcSyncError>> copyDbcFiles({
    required String sourceDirectory,
    required String targetDirectory,
    bool Function()? isCancelled,
  }) async {
    final files = <File>[
      await for (final entity in Directory(
        sourceDirectory,
      ).list(followLinks: false))
        if (entity is File && entity.path.toLowerCase().endsWith('.dbc'))
          entity,
    ]..sort((left, right) => left.path.compareTo(right.path));

    final errors = <DbcSyncError>[];
    for (final file in files) {
      if (isCancelled?.call() ?? false) break;
      final targetPath = p.join(targetDirectory, p.basename(file.path));
      final suffix = DateTime.now().microsecondsSinceEpoch;
      final temporaryFile = File('$targetPath.foxy.$suffix.tmp');
      final backupFile = File('$targetPath.foxy.$suffix.bak');
      try {
        await file.copy(temporaryFile.path);
        await _replaceFile(
          temporaryFile: temporaryFile,
          targetFile: File(targetPath),
          backupFile: backupFile,
        );
      } catch (error) {
        errors.add(
          DbcSyncError(
            fileName: p.basename(file.path),
            stage: DbcSyncStage.committing,
            message: error.toString(),
          ),
        );
      } finally {
        if (await temporaryFile.exists()) await temporaryFile.delete();
      }
    }
    return errors;
  }

  /// For unit tests validating the type-normalization rules (uint8 / bool /
  /// strings, etc.).
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
      throw FileSystemException(
        'output directory does not exist',
        outputDirectory,
      );
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

  dynamic _normalizeValue(
    Object? value, {
    required String format,
    required String schemaName,
    required String fieldName,
    required int recordIndex,
  }) {
    Never invalid(String expected) {
      // Exception messages stay English diagnostics (no_chinese_throw);
      // user-facing text is mapped through foxyErrorMessage.
      throw FormatException(
        '$schemaName record ${recordIndex + 1} field $fieldName '
        'expected $expected, got ${value.runtimeType}: $value',
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
      final number = integer('32-bit signed integer');
      if (number < -2147483648 || number > 2147483647) {
        return invalid('32-bit signed integer');
      }
      return number;
    }

    double float32() {
      if (value is! num || !value.isFinite) {
        return invalid('finite float');
      }
      final number = value.toDouble();
      if (!number.isFinite || number.abs() > 3.4028234663852886e38) {
        return invalid('32-bit float');
      }
      return number;
    }

    String string() {
      if (value is! String || value.contains('\x00')) {
        return invalid('string without NUL');
      }
      return value;
    }

    return switch (format) {
      's' => string(),
      'i' || 'n' => int32(),
      'b' => switch (integer('integer in 0-255')) {
        final number when number >= 0 && number <= 255 => number,
        _ => invalid('integer in 0-255'),
      },
      'f' => float32(),
      'l' => switch (value) {
        bool boolean => boolean,
        num number when number == 0 || number == 1 => number == 1,
        _ => invalid('boolean or 0/1'),
      },
      'x' || 'X' || 'd' => 0,
      _ => throw FormatException('$schemaName unknown DBC format: $format'),
    };
  }

  static Future<void> _replaceFile({
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
        // The target file has been safely replaced; a leftover backup does
        // not affect the export result.
      }
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
          '${schema.name} record ${recordIndex + 1} missing field '
          '${field.name}',
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

  void _validateWrittenFile(
    String path,
    DbcSchema schema, {
    required int expectedRecords,
  }) {
    final loader = DbcLoader(path, schema.format);
    if (loader.recordCount != expectedRecords) {
      throw FormatException(
        '${schema.name} record count mismatch on re-read: '
        'expected $expectedRecords, got ${loader.recordCount}',
      );
    }
    if (loader.fieldCount != schema.format.length) {
      throw FormatException(
        '${schema.name} field count mismatch on re-read: '
        'expected ${schema.format.length}, got ${loader.fieldCount}',
      );
    }
  }
}
