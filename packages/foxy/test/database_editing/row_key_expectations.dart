import 'package:flutter_test/flutter_test.dart';

void expectRowKeyEquality<E, K>(
  K key,
  K Function(E) keyOf, {
  required E sameKeyRow,
  required Iterable<E> differentKeyRows,
}) {
  expectKeyEquality(
    key,
    sameKey: keyOf(sameKeyRow),
    differentKeys: differentKeyRows.map(keyOf),
  );
}

void expectKeyEquality<K>(
  K key, {
  required K sameKey,
  required Iterable<K> differentKeys,
}) {
  expect(key, sameKey);
  expect(key.hashCode, sameKey.hashCode);
  for (final differentKey in differentKeys) {
    expect(key, isNot(differentKey));
  }
}
