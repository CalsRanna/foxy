import 'package:foxy/database/database.dart';

/// Executes one application use case inside the active database transaction.
///
/// Repositories keep their physical-table boundary and never expose the
/// underlying Laconic connection as a transaction coordinator.
class DatabaseTransaction {
  const DatabaseTransaction();

  Future<void> execute(Future<void> Function() action) {
    return Database.instance.laconic.transaction(action);
  }
}
