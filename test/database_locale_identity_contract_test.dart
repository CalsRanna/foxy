import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/database_locale_changes.dart';

void main() {
  test('persisted locale row keeps original identity separate from draft', () {
    final values = {'locale': 'zhCN', 'name': '名称'};
    final row = DatabaseLocaleRow.persisted(values);
    values['locale'] = 'deDE';

    expect(row.originalLocale, 'zhCN');
    expect(row.values['locale'], 'zhCN');
    expect(() => row.values['locale'] = 'frFR', throwsUnsupportedError);
  });

  test('dynamic editor reports removed original locales explicitly', () {
    final source = File(
      'lib/widget/foxy_locale_crud_dialog.dart',
    ).readAsStringSync();
    expect(source, contains('final String? originalLocale;'));
    expect(source, contains('_initialLocales.difference(retainedLocales)'));
    expect(source, contains('deletedLocales: List.unmodifiable('));
    expect(source, contains('originalLocale: row.originalLocale'));
  });

  test('field-specific delegates preserve hidden physical locale columns', () {
    final source = File(
      'lib/widget/foxy_locale_picker_delegates.dart',
    ).readAsStringSync();
    expect(source, contains('row.originalLocale'));
    expect(source, contains('castBarCaption: preserved?.castBarCaption ??'));
    expect(source, contains('name: preserved?.name ??'));
    expect(
      'updates[originalKey] = existing.copyWith('.allMatches(source).length,
      greaterThanOrEqualTo(2),
    );
    expect(source, isNot(contains('row.locale == locale')));
  });
}
