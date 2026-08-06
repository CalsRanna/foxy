import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';

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
