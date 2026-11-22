import 'package:foxy_agent/src/tools/read_only_sql.dart';

/// Read-only data access used by the built-in tools.
///
/// Implementations live in the host app and must only read and never write.
abstract interface class ReadOnlyDataSource {
  /// Executes a SELECT that was validated against the catalog.
  Future<List<Map<String, Object?>>> querySql(ReadOnlySql sql);

  /// Reads the connected database's current time and session time zone.
  Future<Map<String, Object?>> serverTime();
}
