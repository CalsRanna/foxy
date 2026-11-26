import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('Effect types, resistances, and stats use the separate domains consumed by this table', () {
    expect(
      SpellItemEnchantmentConstants.spellItemEnchantmentEffectTypeOptions.keys,
      orderedEquals([0, 1, 2, 3, 4, 5, 6, 7, 8]),
    );
    expect(
      SpellItemEnchantmentConstants.spellItemEnchantmentSchoolOptions.keys,
      orderedEquals([0, 1, 2, 3, 4, 5, 6]),
    );
    expect(
      SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions,
      containsPair(29, '近战急速等级'),
    );
    expect(
      SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions,
      containsPair(48, '格挡值'),
    );
    expect(
      SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions,
      isNot(contains(2)),
    );
    expect(
      SpellItemEnchantmentConstants.spellItemEnchantmentStatOptions,
      isNot(contains(40)),
    );
  });
}
