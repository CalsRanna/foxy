import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/use_case/locale/apply_database_locale_changes_use_case.dart';
import 'package:test/test.dart';

void main() {
  late List<String> operations;
  late ApplyDatabaseLocaleChangesUseCase useCase;

  setUp(() {
    operations = [];
    useCase = ApplyDatabaseLocaleChangesUseCase(
      transaction: _RecordingTransaction(operations),
    );
  });

  test('The transaction releases deleted keys before updates and inserts, then commits', () async {
    await useCase.execute(
      creations: ['deDE'],
      deletions: ['frFR'],
      updates: {'zhCN': 'frFR'},
      destroy: (key) async => operations.add('delete $key'),
      update: (key, value) async => operations.add('update $key to $value'),
      store: (value) async => operations.add('insert $value'),
    );

    expect(operations, [
      'begin',
      'delete frFR',
      'update zhCN to frFR',
      'insert deDE',
      'commit',
    ]);
  });

  test('A failed update aborts the batch, rolls back, and propagates the original exception', () async {
    const failure = RecordNotFoundException('locale row not found');
    await expectLater(
      useCase.execute(
        creations: ['deDE'],
        deletions: ['frFR'],
        updates: {'zhCN': 'frFR'},
        destroy: (key) async => operations.add('delete $key'),
        update: (key, value) async {
          operations.add('update $key to $value');
          throw failure;
        },
        store: (value) async => operations.add('insert $value'),
      ),
      throwsA(same(failure)),
    );

    expect(operations, [
      'begin',
      'delete frFR',
      'update zhCN to frFR',
      'rollback',
    ]);
  });
}

final class _RecordingTransaction extends DatabaseTransaction {
  final List<String> operations;

  _RecordingTransaction(this.operations);

  @override
  Future<T> runTransaction<T>(Future<T> Function() action) async {
    operations.add('begin');
    try {
      final result = await action();
      operations.add('commit');
      return result;
    } catch (_) {
      operations.add('rollback');
      rethrow;
    }
  }
}
