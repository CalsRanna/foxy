import 'dart:async';

import 'package:foxy/infrastructure/database/database.dart';
import 'package:laconic/laconic.dart';

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
  /// Callbacks owned by the outer transaction.
  static const _txKey = #foxyTransactionActive;
  final Laconic? _connection;

  const DatabaseTransaction([this._connection]);

  Future<T> execute<T>(Future<T> Function() action) async {
    if (Zone.current[_txKey] != null) {
      // Run inside the existing transaction.
      return action();
    }

    Object? failure;
    StackTrace? failureStack;
    final callbacks = <void Function()>[];
    final T result;
    try {
      result = await runZoned(
        () => runTransaction(() async {
          try {
            return await action();
          } catch (error, stackTrace) {
            // laconic_mysql's transaction() turns any non-LaconicException into
            // a LaconicException, which would erase the FoxyException type (and
            // with it the central Chinese message mapping). Remember the
            // original error so it can be rethrown once the driver finished
            // rolling back.
            failure = error;
            failureStack = stackTrace;
            rethrow;
          }
        }),
        zoneValues: {_txKey: callbacks},
      );
    } catch (_) {
      if (failure != null) {
        Error.throwWithStackTrace(failure!, failureStack ?? StackTrace.current);
      }
      rethrow;
    }
    for (final callback in callbacks) {
      callback();
    }
    return result;
  }

  /// Opens the underlying database transaction. Override point for tests
  /// that script transactions without a live MySQL.
  Future<T> runTransaction<T>(Future<T> Function() action) {
    return (_connection ?? Database.instance.laconic).transaction(action);
  }

  static void afterCommit(void Function() callback) {
    final callbacks = Zone.current[_txKey] as List<void Function()>?;
    if (callbacks == null) {
      callback();
    } else {
      callbacks.add(callback);
    }
  }
}
