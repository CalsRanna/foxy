import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/item_set_entity.dart';
import 'package:foxy/entity/skill_line_entity.dart';

void main() {
  test('ItemSet Entity 精确覆盖 53 个标量物理列', () {
    final json = const ItemSetEntity().toJson();
    expect(json.keys, hasLength(53));
    expect(json.keys.first, 'ID');
    expect(json.keys.elementAt(17), 'Name_lang_Flags');
    expect(json.keys.elementAt(18), 'ItemID0');
    expect(json.keys.elementAt(34), 'ItemID16');
    expect(json.keys.elementAt(35), 'SetSpellID0');
    expect(json.keys.elementAt(42), 'SetSpellID7');
    expect(json.keys.elementAt(43), 'SetThreshold0');
    expect(json.keys.elementAt(50), 'SetThreshold7');
    expect(json.keys.elementAt(51), 'RequiredSkill');
    expect(json.keys.last, 'RequiredSkillRank');
    expect(json.values.whereType<List<Object?>>(), isEmpty);
  });

  test('ItemSet 校验 int32、法术门槛和技能等级配对', () {
    expect(const ItemSetEntity(id: 1).validate, returnsNormally);
    expect(
      const ItemSetEntity(
        id: 1,
        setSpellId0: 123,
        setThreshold0: 2,
        requiredSkill: 197,
        requiredSkillRank: 375,
      ).validate,
      returnsNormally,
    );
    expect(() => const ItemSetEntity(id: 0).validate(), throwsArgumentError);
    expect(
      () => const ItemSetEntity(id: 1, itemId16: -1).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ItemSetEntity(id: 1, setSpellId0: 123).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ItemSetEntity(id: 1, setThreshold0: 2).validate(),
      throwsArgumentError,
    );
    expect(
      () => const ItemSetEntity(id: 1, requiredSkill: 197).validate(),
      throwsArgumentError,
    );
  });

  test('SkillLine Entity 精确覆盖 56 个标量物理列', () {
    final json = const SkillLineEntity().toJson();
    expect(json.keys, hasLength(56));
    expect(json.keys.first, 'ID');
    expect(json.keys.elementAt(1), 'CategoryID');
    expect(json.keys.elementAt(2), 'SkillCostsID');
    expect(json.keys.elementAt(19), 'DisplayName_lang_Flags');
    expect(json.keys.elementAt(36), 'Description_lang_Flags');
    expect(json.keys.elementAt(37), 'SpellIconID');
    expect(json.keys.elementAt(54), 'AlternateVerb_lang_Flags');
    expect(json.keys.last, 'CanLink');
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('Entity、ViewModel 和 UI 未用循环或索引分派管理重复槽位', () {
    final entity = File('lib/entity/item_set_entity.dart').readAsStringSync();
    final viewModel = File(
      'lib/page/item_set/item_set_detail_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/item_set/item_set_view.dart',
    ).readAsStringSync();
    for (final source in [entity, viewModel, view]) {
      expect(source, isNot(contains('List.generate')));
      expect(source, isNot(contains('for (')));
    }
    expect(viewModel, isNot(contains('itemIdController(int')));
    expect(viewModel, isNot(contains('setSpellIdController(int')));
  });

  test('详情页显式展示所有字段、每行四列等宽且使用准确 Picker', () {
    final view = File(
      'lib/page/item_set/item_set_view.dart',
    ).readAsStringSync();
    expect(view, isNot(contains('flex:')));
    expect(view, isNot(contains('description:')));
    expect(view, contains('FoxyEntityPickerDelegates.skillLine'));
    expect(view, contains('FoxyEntityPickerDelegates.itemTemplate'));
    expect(view, contains('FoxyEntityPickerDelegates.spell'));
    for (var index = 0; index < 17; index++) {
      expect(view, contains("'ItemID$index'"));
    }
    for (var index = 0; index < 8; index++) {
      expect(view, contains("'SetSpellID$index'"));
      expect(view, contains("'SetThreshold$index'"));
    }
    expect('Row('.allMatches(view), hasLength(12));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('viewModel.persistedKey.value?.id'));
  });

  test('Repository 使用原始键、完整 candidate 和单表边界', () {
    final repository = File(
      'lib/repository/item_set_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/item_set/item_set_detail_view_model.dart',
    ).readAsStringSync();
    expect(repository, isNot(contains('.validate()')));
    expect(viewModel, contains('validateItemSetFields(candidate);'));
    expect(repository, contains('ItemSetKey originalKey'));
    expect(repository, contains('.update(itemSet.toJson())'));
    expect(repository, contains('matchedRows == 0'));
    expect(repository, contains('deletedRows == 0'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, isNot(contains("table('item_template')")));
    expect(repository, isNot(contains("table('foxy.dbc_spell')")));
    expect(repository, isNot(contains("table('foxy.dbc_skill_line')")));
    expect(repository, isNot(contains("remove('ID')")));
    expect(repository, contains(".orderBy('ID')"));
    expect(viewModel, contains('signal<ItemSetKey?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(viewModel, contains('updateItemSet(originalKey, candidate)'));
    expect(viewModel, contains('persistedKey.value = ItemSetKey'));
  });

  test('DBC definitions 使用 3.3.5.12340 的精确物理格式', () {
    final itemSet = dbcDefinitionByTable['dbc_item_set']!;
    expect(itemSet.fileName, 'ItemSet.dbc');
    expect(
      itemSet.schema.format,
      'nssssssssssssssssiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
    );
    expect(itemSet.schema.fields, hasLength(53));

    final skillLine = dbcDefinitionByTable['dbc_skill_line']!;
    expect(skillLine.fileName, 'SkillLine.dbc');
    expect(skillLine.schema.fields, hasLength(56));
  });
}
