import 'package:flutter_test/flutter_test.dart';
import 'package:signals/signals.dart';

import 'in_memory_row_editing.dart';

Future<void> expectSaveRetry<E, K>({
  required InMemoryRowEditing<E, K> repository,
  required K originalKey,
  required ReadonlySignal<K?> editingKey,
  required Future<void> Function() persist,
}) async {
  repository.failUpdates = true;
  await expectLater(persist(), throwsStateError);
  expect(editingKey.value, originalKey);

  repository.failUpdates = false;
  await persist();
  expect(repository.updateKeys, [originalKey, originalKey]);
}

Future<void> expectParentChangeAndCreateClearIdentity<K>({
  required ReadonlySignal<K?> editingKey,
  required ReadonlySignal<K?> selectedKey,
  required Future<void> Function() changeParent,
  required Future<void> Function() create,
}) async {
  await changeParent();
  expect(editingKey.value, isNull);
  expect(selectedKey.value, isNull);

  await create();
  expect(editingKey.value, isNull);
  expect(selectedKey.value, isNull);
}
