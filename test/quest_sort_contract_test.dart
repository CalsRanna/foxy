import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';

void main() {

  test('QuestSort DBC 与本地化定义对应 3.3.5.12340', () {
    final definition = dbcDefinitionByTable['dbc_quest_sort']!;
    expect(definition.fileName, 'QuestSort.dbc');
    expect(definition.schema.format, 'nssssssssssssssssi');
    expect(definition.schema.fields, hasLength(18));
    expect(DbcLocaleFields.questSortSortName.tableName, 'dbc_quest_sort');
    expect(DbcLocaleFields.questSortSortName.columnPrefix, 'SortName_lang');
    expect(
      DbcLocaleFields.questSortSortName.flagsColumn,
      'SortName_lang_Flags',
    );
  });

}
