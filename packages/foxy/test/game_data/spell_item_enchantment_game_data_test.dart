import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/spell_item_enchantment_constants.dart';
import 'package:foxy/entity/spell_item_enchantment_entity.dart';

void main() {

  test('效果类型、抗性和属性使用本表实际消费的独立值域', () {
    expect(SpellItemEnchantmentConstants.spellItemEnchantmentEffectTypeOptions.keys, orderedEquals([0, 1, 2, 3, 4, 5, 6, 7, 8]));
    expect(SpellItemEnchantmentConstants.spellItemEnchantmentSchoolOptions.keys, orderedEquals([0, 1, 2, 3, 4, 5, 6]));
    expect(SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions, containsPair(29, '近战急速等级'));
    expect(SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions, containsPair(48, '格挡值'));
    expect(SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions, isNot(contains(2)));
    expect(SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions, isNot(contains(40)));
  });

  test('三张关联 DBC definition 与 3.3.5a 物理格式一致', () {
    final visuals = DbcDefinitions.byTable['dbc_item_visuals']!;
    expect(visuals.fileName, 'ItemVisuals.dbc');
    expect(visuals.schema.format, 'niiiii');
    expect(visuals.schema.fields, hasLength(6));

    final effects = DbcDefinitions.byTable['dbc_item_visual_effects']!;
    expect(effects.fileName, 'ItemVisualEffects.dbc');
    expect(effects.schema.format, 'ns');
    expect(effects.schema.fields, hasLength(2));

    final conditions = DbcDefinitions.byTable['dbc_spell_item_enchantment_condition']!;
    expect(conditions.fileName, 'SpellItemEnchantmentCondition.dbc');
    expect(conditions.schema.format, 'nbbbbbiiiiibbbbbbbbbbiiiiibbbbb');
    expect(conditions.schema.fields, hasLength(31));
  });

  test('效果类型映射为标签，未知值回退', () {
    const item = BriefSpellItemEnchantmentEntity(effect0: 1);
    expect(item.effect0Label, '战斗触发法术');
    expect(
      const BriefSpellItemEnchantmentEntity(effect0: 99).effect0Label,
      '99',
    );
  });
}
