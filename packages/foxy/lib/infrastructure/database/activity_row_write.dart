import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/model/activity_log_details.dart';
import 'package:laconic/laconic.dart';

final class ActivityRowWrite {
  static Future<T> capture<T>(
    Laconic laconic,
    String table, {
    Map<String, Object?>? beforeKey,
    Map<String, Object?>? afterKey,
    Iterable<String> columns = const [],
    Set<String> binaryKeyColumns = const {},
    required Future<T> Function() write,
  }) {
    final capture = ActivityLogCapture.current;
    if (capture == null) return write();

    if (beforeKey == null || afterKey == null) {
      return write().then((result) {
        if (result != 0) {
          DatabaseTransaction.afterCommit(() {
            capture.record(
              table: table,
              beforeKey: beforeKey,
              afterKey: afterKey,
            );
          });
        }
        return result;
      });
    }

    return DatabaseTransaction(laconic).execute(() async {
      final before = await _readRow(
        laconic,
        table,
        beforeKey,
        binaryKeyColumns,
      );
      final result = await write();
      if (result == 0) return result;
      final after = await _readRow(laconic, table, afterKey, binaryKeyColumns);
      DatabaseTransaction.afterCommit(() {
        capture.record(
          table: table,
          beforeKey: beforeKey,
          afterKey: afterKey,
          before: before,
          after: after,
          columns: columns,
        );
      });
      return result;
    });
  }

  static Future<Map<String, Object?>?> _readRow(
    Laconic laconic,
    String table,
    Map<String, Object?> key,
    Set<String> binaryKeyColumns,
  ) async {
    final tableName = table.split('.').map((part) => '`$part`').join('.');
    final where = key.keys
        .map(
          (column) => binaryKeyColumns.contains(column)
              ? 'binary `$column` <=> binary ?'
              : '`$column` <=> ?',
        )
        .join(' and ');
    try {
      final rows = await laconic.select(
        'select * from $tableName where $where limit 1 for update',
        key.values.toList(),
      );
      return rows.firstOrNull?.toMap();
    } on LaconicException catch (error) {
      if (error.code == '1213' || error.code == '1205') rethrow;
      LoggerUtil.instance.e('读取活动日志差异失败', error: error);
      return null;
    }
  }
}
