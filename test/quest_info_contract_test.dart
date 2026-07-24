import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/quest_info_entity.dart';
import 'support/local_dart_library_source.dart';

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

  test('编号符合 unsigned smallint 引用且 Flags 为 signed int32', () {
    expect(const QuestInfoEntity(id: 1).validate, returnsNormally);
    expect(const QuestInfoEntity(id: 65535).validate, returnsNormally);
    expect(
      const QuestInfoEntity(id: 1, infoNameLangFlags: -2147483648).validate,
      returnsNormally,
    );
    expect(() => const QuestInfoEntity(id: 0).validate(), throwsStateError);
    expect(() => const QuestInfoEntity(id: 65536).validate(), throwsStateError);
    expect(
      () => const QuestInfoEntity(
        id: 1,
        infoNameLangFlags: 2147483648,
      ).validate(),
      throwsStateError,
    );
  });

  test('Repository 使用原始键、完整 candidate 和单表边界', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/quest_info_repository.dart',
    );
    expect(source, isNot(contains('.validate()')));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains("table('quest_template')")));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('id > 65535'));
  });

  test('任务模板使用 QuestInfo Picker 而不复用 QuestType Method 枚举', () {
    final view = File(
      'lib/page/quest/quest_template_view.dart',
    ).readAsStringSync();
    expect(view, contains('FoxyEntityPickerDelegates.questInfo'));
    expect(view, contains("placeholder: 'QuestInfoID'"));
    expect(view, contains('kQuestMethodOptions'));
  });

  test('详情页显式编辑名称 Flags 并保持每行四列等宽', () {
    final view = File(
      'lib/page/quest_info/quest_info_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/quest_info/quest_info_detail_view_model.dart',
    ).readAsStringSync();
    expect(view, contains("label: '名称语言标志'"));
    expect(view, contains("placeholder: 'InfoName_lang_Flags'"));
    expect(view, isNot(contains('flex:')));
    expect('Expanded(child:'.allMatches(view), hasLength(4));
    expect(viewModel, contains('infoNameLangFlagsController.collect()'));
    expect(viewModel, contains('infoNameLangFlagsController.init('));
    expect(viewModel, contains('validateQuestInfoFields(candidate)'));
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateQuestInfo(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = candidate.id'));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('viewModel.persistedKey.value'));
  });

  test('Entity 源码没有数组或 Map 字段', () {
    final source = File('lib/entity/quest_info_entity.dart').readAsStringSync();
    expect(source, isNot(contains('final List<')));
    expect(source, isNot(contains('final Map<')));
  });
}
