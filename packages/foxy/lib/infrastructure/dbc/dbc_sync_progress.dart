class DbcSyncCount extends DbcSyncProgress {
  final DbcSyncOperation operation;
  final String fileName;
  final int completedFiles;
  final int totalFiles;
  final int processedRows;
  final int? totalRows;

  const DbcSyncCount({
    required this.operation,
    required this.fileName,
    required this.completedFiles,
    required this.totalFiles,
    this.processedRows = 0,
    this.totalRows,
  });
}

class DbcSyncError {
  final String? tableName;
  final String? fileName;
  final DbcSyncStage stage;
  final String message;

  const DbcSyncError({
    this.tableName,
    this.fileName,
    required this.stage,
    required this.message,
  });

  @override
  String toString() {
    final source = fileName ?? tableName;
    return source == null ? message : '$source: $message';
  }
}

enum DbcSyncOperation { import, export }

sealed class DbcSyncProgress {
  const DbcSyncProgress();
}

class DbcSyncResult extends DbcSyncProgress {
  final DbcSyncOperation operation;
  final int completed;
  final int skipped;
  final List<DbcSyncError> errors;
  final List<DbcSyncWarning> warnings;
  final bool cancelled;

  const DbcSyncResult({
    required this.operation,
    required this.completed,
    required this.skipped,
    required this.errors,
    this.warnings = const [],
    this.cancelled = false,
  });

  bool get success => !cancelled && errors.isEmpty;
}

/// Non-fatal DBC sync note (e.g. exported tables missing row-order data).
///
/// Unlike [DbcSyncError], a warning does not make [DbcSyncResult.success]
/// false — the export itself completed, but the user may want to re-import
/// the DBC to restore original row order.
class DbcSyncWarning {
  final String? tableName;
  final String? fileName;
  final String message;

  const DbcSyncWarning({this.tableName, this.fileName, required this.message});

  @override
  String toString() => message;
}

enum DbcSyncStage {
  preparing,
  scanning,
  reading,
  writing,
  validating,
  committing,
}

class DbcSyncStatus extends DbcSyncProgress {
  final DbcSyncOperation operation;
  final DbcSyncStage stage;
  final String message;
  final String? fileName;

  const DbcSyncStatus({
    required this.operation,
    required this.stage,
    required this.message,
    this.fileName,
  });
}

class DbcTableCheckResult {
  final String tableName;
  final DbcTableState state;
  final String? message;

  const DbcTableCheckResult({
    required this.tableName,
    required this.state,
    this.message,
  });
}

enum DbcTableState { missing, empty, ready, incompatible, error }
