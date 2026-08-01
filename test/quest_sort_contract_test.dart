import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/quest_sort_entity.dart';

void main() {
  test('QuestSort Entity 精确覆盖 18 个物理列且全部为标量', () {
    final json = const QuestSortEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'SortName_lang_enUS',
      'SortName_lang_koKR',
      'SortName_lang_frFR',
      'SortName_lang_deDE',
      'SortName_lang_zhCN',
      'SortName_lang_zhTW',
      'SortName_lang_esES',
      'SortName_lang_esMX',
      'SortName_lang_ruRU',
      'SortName_lang_jaJP',
      'SortName_lang_ptPT',
      'SortName_lang_ptBR',
      'SortName_lang_itIT',
      'SortName_lang_unk1',
      'SortName_lang_unk2',
      'SortName_lang_unk3',
      'SortName_lang_Flags',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

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
