import 'dart:async';

import 'package:foxy/database/database.dart';

/// Executes one application use case inside the active database transaction.
///
/// Repositories keep their physical-table boundary and never expose the
/// underlying Laconic connection as a transaction coordinator.
///
/// Nested execution is merged: laconic_mysql pins the transaction connection
/// via a zone value and starts a *new* pooled connection for every
/// `transaction` call, so a nested transaction would commit independently of
/// the outer one — an outer rollback could never undo inner writes. When
/// this zone marker is present, [execute] runs the action on the outer
/// transaction instead of opening a second one.
class DatabaseTransaction {
  const DatabaseTransaction();

  /// Zone marker for the active outer transaction.
  static const _txKey = #foxyTransactionActive;

  Future<T> execute<T>(Future<T> Function() action) async {
    if (Zone.current[_txKey] == true) {
      // 已在外层事务中:合并执行,不新开事务。
      return action();
    }
    return runZoned(
      () => runTransaction(action),
      zoneValues: {_txKey: true},
    );
  }

  /// Opens the underlying database transaction. Override point for tests
  /// that script transactions without a live MySQL.
  Future<T> runTransaction<T>(Future<T> Function() action) {
    return Database.instance.laconic.transaction(action);
  }
}
