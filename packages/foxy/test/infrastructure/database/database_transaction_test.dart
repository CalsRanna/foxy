import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:laconic/laconic.dart';

/// Verifies the nested-transaction merge semantics: laconic_mysql opens a
/// fresh pooled connection per `transaction` call, so a naive nested
/// transaction would commit independently of the outer one. The zone marker
/// in [DatabaseTransaction] must collapse nested [execute] calls onto the
/// outer transaction.
void main() {
  test('Nested execute calls share one underlying transaction', () async {
    final tx = _CountingTransaction();

    final executionOrder = <String>[];
    await tx.execute(() async {
      await tx.execute(() async => executionOrder.add('inner'));
      executionOrder.add('outer');
    });

    expect(tx.opens, 1, reason: '嵌套调用不得再次打开底层事务');
    expect(executionOrder, ['inner', 'outer']);
  });

  test(
    'An inner exception reaches the outer transaction so it can roll back',
    () async {
      final tx = _CountingTransaction();

      var innerRan = false;
      await expectLater(
        tx.execute(() async {
          await tx.execute(() async {
            innerRan = true;
            throw StateError('inner failure');
          });
        }),
        throwsStateError,
      );
      expect(tx.opens, 1);
      expect(innerRan, isTrue);
    },
  );

  test('Independent calls each open a separate transaction', () async {
    final tx = _CountingTransaction();

    await tx.execute(() async {});
    await tx.execute(() async {});

    expect(tx.opens, 2);
  });

  test('execute returns the result of the action', () async {
    final tx = _CountingTransaction();

    final value = await tx.execute(() async => 42);
    expect(value, 42);
  });

  test('The original exception type survives wrapping by the underlying transaction', () async {
    final tx = _WrappingTransaction();

    await expectLater(
      tx.execute(() async => throw const RecordNotFoundException('missing')),
      throwsA(isA<RecordNotFoundException>()),
    );
  });

  test('Nested execution also propagates the original exception', () async {
    final tx = _WrappingTransaction();

    await expectLater(
      tx.execute(() async {
        await tx.execute(() async => throw const BusyException('busy'));
      }),
      throwsA(isA<BusyException>()),
    );
  });

  test('Non-domain exceptions keep their original type', () async {
    final tx = _WrappingTransaction();

    await expectLater(
      tx.execute(() async => throw StateError('boom')),
      throwsStateError,
    );
  });
}

final class _CountingTransaction extends DatabaseTransaction {
  int opens = 0;

  @override
  Future<T> runTransaction<T>(Future<T> Function() action) async {
    opens++;
    try {
      return await action();
    } catch (_) {
      rethrow; // Production rolls back. The test propagates the error.
    }
  }
}

/// Mirrors laconic_mysql's `transaction()`: it rewraps every non-Laconic error
/// as a `LaconicException`, which is what used to erase `FoxyException` types
/// on the way out of a transaction.
final class _WrappingTransaction extends DatabaseTransaction {
  @override
  Future<T> runTransaction<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (error) {
      throw LaconicException(
        error.toString(),
        driver: 'mysql',
        code: error is LaconicException ? error.code : null,
      );
    }
  }
}
