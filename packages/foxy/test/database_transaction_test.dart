import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:laconic/laconic.dart';

/// Verifies the nested-transaction merge semantics: laconic_mysql opens a
/// fresh pooled connection per `transaction` call, so a naive nested
/// transaction would commit independently of the outer one. The zone marker
/// in [DatabaseTransaction] must collapse nested [execute] calls onto the
/// outer transaction.
void main() {
  test('嵌套 execute 合并进外层事务,底层只开一次事务', () async {
    final tx = _CountingTransaction();

    final executionOrder = <String>[];
    await tx.execute(() async {
      await tx.execute(() async => executionOrder.add('inner'));
      executionOrder.add('outer');
    });

    expect(tx.opens, 1, reason: '嵌套调用不得再次打开底层事务');
    expect(executionOrder, ['inner', 'outer']);
  });

  test('内层异常冒泡到外层,外层可回滚', () async {
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
  });

  test('独立(非嵌套)调用每次各开一次事务', () async {
    final tx = _CountingTransaction();

    await tx.execute(() async {});
    await tx.execute(() async {});

    expect(tx.opens, 2);
  });

  test('action 返回值透传', () async {
    final tx = _CountingTransaction();

    final value = await tx.execute(() async => 42);
    expect(value, 42);
  });

  test('底层事务包装异常时,原始异常类型仍向外抛出', () async {
    final tx = _WrappingTransaction();

    await expectLater(
      tx.execute(() async => throw const RecordNotFoundException('missing')),
      throwsA(isA<RecordNotFoundException>()),
    );
  });

  test('嵌套执行时原始异常同样不被包装吞掉', () async {
    final tx = _WrappingTransaction();

    await expectLater(
      tx.execute(() async {
        await tx.execute(() async => throw const BusyException('busy'));
      }),
      throwsA(isA<BusyException>()),
    );
  });

  test('非业务异常也按原类型抛出', () async {
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
      rethrow; // 真实实现会 ROLLBACK;此处原样冒泡。
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
