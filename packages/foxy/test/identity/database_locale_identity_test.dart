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
}
