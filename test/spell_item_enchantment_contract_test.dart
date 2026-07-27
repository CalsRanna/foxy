import 'support/entity_validation_test_extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/spell_item_enchantment_constants.dart';
import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';

void main() {
  test('主 Entity 精确覆盖 38 个物理列且全部为标量', () {
    final json = const SpellItemEnchantmentEntity().toJson();
    expect(json.keys.toList(), [
      'ID', 'Charges', 'Effect0', 'Effect1', 'Effect2',
      'EffectPointsMin0', 'EffectPointsMin1', 'EffectPointsMin2',
      'EffectPointsMax0', 'EffectPointsMax1', 'EffectPointsMax2',
      'EffectArg0', 'EffectArg1', 'EffectArg2',
      'Name_lang_enUS', 'Name_lang_koKR', 'Name_lang_frFR', 'Name_lang_deDE',
      'Name_lang_zhCN', 'Name_lang_zhTW', 'Name_lang_esES', 'Name_lang_esMX',
      'Name_lang_ruRU', 'Name_lang_jaJP', 'Name_lang_ptPT', 'Name_lang_ptBR',
      'Name_lang_itIT', 'Name_lang_unk1', 'Name_lang_unk2', 'Name_lang_unk3',
      'Name_lang_Flags', 'ItemVisual', 'Flags', 'Src_itemID', 'Condition_ID',
      'RequiredSkillID', 'RequiredSkillRank', 'MinLevel',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('效果类型、抗性和属性使用本表实际消费的独立值域', () {
    expect(kSpellItemEnchantmentEffectTypeOptions.keys, orderedEquals([0, 1, 2, 3, 4, 5, 6, 7, 8]));
    expect(kSpellItemEnchantmentSchoolOptions.keys, orderedEquals([0, 1, 2, 3, 4, 5, 6]));
    expect(kSpellItemEnchantmentStatOptions, containsPair(29, '近战急速等级'));
    expect(kSpellItemEnchantmentStatOptions, containsPair(48, '格挡值'));
    expect(kSpellItemEnchantmentStatOptions, isNot(contains(2)));
    expect(kSpellItemEnchantmentStatOptions, isNot(contains(40)));
  });

  test('校验保留客户端原始列并约束联合参数', () {
    expect(
      const SpellItemEnchantmentEntity(id: 1, effect0: 0, effectPointsMin0: 20,
          effectPointsMax0: 10, effectArg0: 9394, effect1: 2,
          effectPointsMin1: -10, itemVisual: -1, flags: 9).validate,
      returnsNormally,
    );
    expect(
      () => const SpellItemEnchantmentEntity(id: 1, effect0: 1).validate(),
      throwsArgumentError,
    );
    expect(
      () => const SpellItemEnchantmentEntity(id: 1, effect0: 4, effectArg0: 7).validate(),
      throwsArgumentError,
    );
    expect(
      () => const SpellItemEnchantmentEntity(id: 1, effect0: 5, effectArg0: 40).validate(),
      throwsArgumentError,
    );
    expect(
      () => const SpellItemEnchantmentEntity(id: 1, flags: 16).validate(),
      throwsArgumentError,
    );
  });

  test('条件 Entity 精确覆盖 31 个独立标量列', () {
    final json = const SpellItemEnchantmentConditionEntity().toJson();
    expect(json, hasLength(31));
    expect(json.keys.first, 'ID');
    expect(json.keys, containsAll([
      'Lt_operandType4', 'Lt_operand4', 'Operator4', 'Rt_operandType4', 'Rt_operand4', 'Logic4',
    ]));
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('三张关联 DBC definition 与 3.3.5a 物理格式一致', () {
    final visuals = dbcDefinitionByTable['dbc_item_visuals']!;
    expect(visuals.fileName, 'ItemVisuals.dbc');
    expect(visuals.schema.format, 'niiiii');
    expect(visuals.schema.fields, hasLength(6));

    final effects = dbcDefinitionByTable['dbc_item_visual_effects']!;
    expect(effects.fileName, 'ItemVisualEffects.dbc');
    expect(effects.schema.format, 'ns');
    expect(effects.schema.fields, hasLength(2));

    final conditions = dbcDefinitionByTable['dbc_spell_item_enchantment_condition']!;
    expect(conditions.fileName, 'SpellItemEnchantmentCondition.dbc');
    expect(conditions.schema.format, 'nbbbbbiiiiibbbbbbbbbbiiiiibbbbb');
    expect(conditions.schema.fields, hasLength(31));
  });
}
