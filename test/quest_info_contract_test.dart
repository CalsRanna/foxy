import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/quest_info_entity.dart';

void main() {
  test('QuestInfo Entity 精确覆盖 18 个物理列且全部为标量', () {
    final json = const QuestInfoEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'InfoName_lang_enUS',
      'InfoName_lang_koKR',
      'InfoName_lang_frFR',
      'InfoName_lang_deDE',
      'InfoName_lang_zhCN',
      'InfoName_lang_zhTW',
      'InfoName_lang_esES',
      'InfoName_lang_esMX',
      'InfoName_lang_ruRU',
      'InfoName_lang_jaJP',
      'InfoName_lang_ptPT',
      'InfoName_lang_ptBR',
      'InfoName_lang_itIT',
      'InfoName_lang_unk1',
      'InfoName_lang_unk2',
      'InfoName_lang_unk3',
      'InfoName_lang_Flags',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

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
