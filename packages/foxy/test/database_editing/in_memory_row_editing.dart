mixin InMemoryRowEditing<E, K> {
  bool failUpdates = false;

  final updateKeys = <K>[];
  List<E> get rows;

  E? findRow(K key) {
    for (final row in rows) {
      if (keyOf(row) == key) return row;
    }
    return null;
  }

  K keyOf(E row);

  void updateRow(K originalKey, E candidate) {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere((row) => keyOf(row) == originalKey);
    if (index < 0) throw StateError('missing');
    rows[index] = candidate;
  }
}
