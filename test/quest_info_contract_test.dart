import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';

void main() {

  test('QuestInfo DBC 与本地化定义对应 3.3.5.12340', () {
    final definition = dbcDefinitionByTable['dbc_quest_info']!;
    expect(definition.fileName, 'QuestInfo.dbc');
    expect(definition.schema.format, 'nssssssssssssssssi');
    expect(definition.schema.fields, hasLength(18));
    expect(DbcLocaleFields.questInfoInfoName.tableName, 'dbc_quest_info');
    expect(DbcLocaleFields.questInfoInfoName.columnPrefix, 'InfoName_lang');
    expect(
      DbcLocaleFields.questInfoInfoName.flagsColumn,
      'InfoName_lang_Flags',
    );
  });

}
