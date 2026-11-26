import 'package:foxy/infrastructure/database/database_transaction.dart';

final class ApplyDatabaseLocaleChangesUseCase {
  final DatabaseTransaction _transaction;

  const ApplyDatabaseLocaleChangesUseCase({required this._transaction});

  Future<void> execute<K, E>({
    required List<E> creations,
    required List<K> deletions,
    required Map<K, E> updates,
    required Future<void> Function(K key) destroy,
    required Future<void> Function(K key, E entity) update,
    required Future<void> Function(E entity) store,
  }) => _transaction.execute(() async {
    // Deletions free keys that updates or creations may reuse.
    for (final key in deletions) {
      await destroy(key);
    }
    for (final change in updates.entries) {
      await update(change.key, change.value);
    }
    for (final entity in creations) {
      await store(entity);
    }
  });
}
