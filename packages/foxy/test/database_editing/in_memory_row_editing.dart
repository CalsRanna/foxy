mixin InMemoryRowEditing<E, K> {
  List<E> get rows;

  bool failUpdates = false;
  final updateKeys = <K>[];

  K keyOf(E row);

  E? findRow(K key) {
    for (final row in rows) {
      if (keyOf(row) == key) return row;
    }
    return null;
  }

  void updateRow(K originalKey, E candidate) {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere((row) => keyOf(row) == originalKey);
    if (index < 0) throw StateError('missing');
    rows[index] = candidate;
  }
}
