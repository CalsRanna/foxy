enum DbcSyncOperation { import, export }

enum DbcSyncStage {
  preparing,
  scanning,
  reading,
  writing,
  validating,
  committing,
}

sealed class DbcSyncProgress {
  const DbcSyncProgress();
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

class DbcSyncResult extends DbcSyncProgress {
  final DbcSyncOperation operation;
  final int completed;
  final int skipped;
  final List<DbcSyncError> errors;
  final bool cancelled;

  const DbcSyncResult({
    required this.operation,
    required this.completed,
    required this.skipped,
    required this.errors,
    this.cancelled = false,
  });

  bool get success => !cancelled && errors.isEmpty;
}

enum DbcTableState { missing, empty, ready, incompatible, error }

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
