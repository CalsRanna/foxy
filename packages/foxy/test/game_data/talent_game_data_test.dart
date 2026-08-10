import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/constant/talent_constants.dart';

void main() {

  test('Flags 使用 Talent addToSpellBook 专属 0/1 值', () {
    expect(TalentConstants.talentAddToSpellBookOptions, {0: '不直接加入法术书', 1: '直接加入法术书'});
    expect(TalentConstants.talentAddToSpellBookOptions, isNot(contains(2)));
  });

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
