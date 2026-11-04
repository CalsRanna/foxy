import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('creature_template 枚举选项与 AzerothCore 服务端取值集一致', () {
    expect(CreatureEnums.unitClassOptions.keys.toSet(), {1, 2, 4, 8});
    expect(CreatureEnums.rankOptions.keys.toSet(), {0, 1, 2, 3, 4, 5});
    expect(CreatureEnums.creatureTypeOptions.keys.toSet(), {
      for (var value = 0; value <= 13; value++) value,
    });
    expect(CreatureEnums.booleanOptions.keys.toSet(), {0, 1});
    expect(CreatureEnums.expansionOptions.keys.toSet(), {0, 1, 2});
    expect(CreatureEnums.damageSchoolOptions.keys.toSet(), {
      for (var value = 0; value <= 6; value++) value,
    });
    expect(CreatureEnums.movementTypeOptions.keys.toSet(), {0, 1, 2});
    expect(CreatureEnums.visibilityDistanceTypeOptions.keys.toSet(), {
      0,
      1,
      2,
      3,
      4,
      5,
    });
    expect(CreatureEnums.creatureFamilyOptions.keys.toSet(), {
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      15,
      16,
      17,
      19,
      20,
      21,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      46,
    });
  });

  test('creature_template 位标志选项覆盖服务端定义的全部可编辑位', () {
    expect(_valuesOf(CreatureFlags.npcFlagOptions), _bits(0, 26));
    expect(_valuesOf(CreatureFlags.unitFlagOptions), _bits(0, 31));
    expect(_valuesOf(CreatureFlags.unitFlag2Options), {
      ..._bits(0, 8),
      ..._bits(10, 18),
      1 << 24,
    });
    expect(_valuesOf(CreatureFlags.creatureTypeFlagOptions), _bits(0, 31));
    expect(_valuesOf(CreatureFlags.dynamicFlagOptions), _bits(0, 7));
    expect(_valuesOf(CreatureFlags.lootModeFlagOptions), {
      1,
      2,
      4,
      8,
      16,
      32,
      0x8000,
    });

    final dbAllowedExtraFlags = _bits(0, 31)..remove(1 << 28);
    expect(_valuesOf(CreatureFlags.flagsExtraOptions), dbAllowedExtraFlags);
    expect(
      _valuesOf(CreatureFlags.flagsExtraOptions),
      isNot(contains(1 << 28)),
    );
  });
}

Set<int> _bits(int first, int last) => {
  for (var bit = first; bit <= last; bit++) 1 << bit,
};

Set<int> _valuesOf(List<FlagItem> flags) =>
    flags.map((flag) => flag.value).toSet();
