import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';

void main() {
  test('Talent 与 TalentTab definition 使用 3.3.5.12340 物理格式', () {
    final talent = DbcDefinitions.byTable['dbc_talent']!;
    expect(talent.fileName, 'Talent.dbc');
    expect(talent.schema.format, 'niiiiiiiiiiiiiiiiiiiiii');
    expect(talent.schema.fields, hasLength(23));

    final tab = DbcDefinitions.byTable['dbc_talent_tab']!;
    expect(tab.fileName, 'TalentTab.dbc');
    expect(tab.schema.format, 'nssssssssssssssssiiiiiis');
    expect(tab.schema.fields, hasLength(24));
    expect(DbcLocaleFields.talentTabName.tableName, 'dbc_talent_tab');
    expect(DbcLocaleFields.talentTabName.columnPrefix, 'Name_lang');
  });
}
