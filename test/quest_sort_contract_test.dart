import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/quest_sort_entity.dart';
import 'support/local_dart_library_source.dart';

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

  test('编号可被 signed smallint 负值引用且 Flags 为 signed int32', () {
    expect(const QuestSortEntity(id: 1).validate, returnsNormally);
    expect(const QuestSortEntity(id: 32768).validate, returnsNormally);
    expect(
      const QuestSortEntity(id: 1, sortNameLangFlags: -2147483648).validate,
      returnsNormally,
    );
    expect(() => const QuestSortEntity(id: 0).validate(), throwsStateError);
    expect(() => const QuestSortEntity(id: 32769).validate(), throwsStateError);
    expect(
      () => const QuestSortEntity(
        id: 1,
        sortNameLangFlags: 2147483648,
      ).validate(),
      throwsStateError,
    );
  });

  test('Repository 使用原始键、完整 candidate 和单表边界', () {
    final source = readLocalDartLibrarySource(
      'lib/repository/quest_sort_repository.dart',
    );
    expect(source, isNot(contains('.validate()')));
    expect(source, contains('int originalKey'));
    expect(source, contains('.update(json)'));
    expect(source, contains('matchedRows == 0'));
    expect(source, contains('deletedRows == 0'));
    expect(source, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(source, isNot(contains("table('quest_template')")));
    expect(source, isNot(contains("remove('ID')")));
    expect(source, contains('id > 32768'));
  });

  test('任务模板选择器按 Area 正值和 QuestSort 负值保存', () {
    final source = File(
      'lib/page/quest/area_table_or_quest_sort_selector.dart',
    ).readAsStringSync();
    expect(source, contains("_selectedId = -_questItems[row].id"));
    expect(source, contains("pop(-_questItems[row].id)"));
    expect(source, contains("_selectedId = _areaItems[row].id"));
  });

  test('详情页显式编辑名称 Flags 并保持每行四列等宽', () {
    final view = File(
      'lib/page/quest_sort/quest_sort_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/quest_sort/quest_sort_detail_view_model.dart',
    ).readAsStringSync();
    expect(view, contains("label: '名称语言标志'"));
    expect(view, contains("placeholder: 'SortName_lang_Flags'"));
    expect(view, isNot(contains('flex:')));
    expect('Expanded(child:'.allMatches(view), hasLength(4));
    expect(viewModel, contains('sortNameLangFlagsController.collect()'));
    expect(viewModel, contains('sortNameLangFlagsController.init('));
    expect(viewModel, contains('validateQuestSortFields(candidate)'));
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateQuestSort(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = candidate.id'));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('viewModel.persistedKey.value'));
  });

  test('Entity 源码没有数组或 Map 字段', () {
    final source = File('lib/entity/quest_sort_entity.dart').readAsStringSync();
    expect(source, isNot(contains('final List<')));
    expect(source, isNot(contains('final Map<')));
  });
}
