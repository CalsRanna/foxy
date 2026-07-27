import 'package:flutter_test/flutter_test.dart';
import 'support/entity_validation_test_extensions.dart';
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
