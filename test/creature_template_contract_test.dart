import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/entity/creature_template_entity.dart';

void main() {
  test('CreatureTemplateEntity 覆盖 creature_template 的 55 个字段且类型正确', () {
    final json = const CreatureTemplateEntity().toJson();
    const stringFields = {
      'AIName',
      'IconName',
      'name',
      'ScriptName',
      'subname',
    };
    const doubleFields = {
      'ArmorModifier',
      'BaseVariance',
      'DamageModifier',
      'detection_range',
      'ExperienceModifier',
      'HealthModifier',
      'HoverHeight',
      'ManaModifier',
      'RangeVariance',
      'speed_flight',
      'speed_run',
      'speed_swim',
      'speed_walk',
    };

    expect(json, hasLength(55));
    for (final entry in json.entries) {
      if (stringFields.contains(entry.key)) {
        expect(entry.value, isA<String>(), reason: entry.key);
      } else if (doubleFields.contains(entry.key)) {
        expect(entry.value, isA<double>(), reason: entry.key);
      } else {
        expect(entry.value, isA<int>(), reason: entry.key);
      }
    }
    expect(json['unit_class'], 1);
  });

  test('creature_template 枚举选项与 AzerothCore 服务端取值集一致', () {
    expect(kUnitClassOptions.keys.toSet(), {1, 2, 4, 8});
    expect(kRankOptions.keys.toSet(), {0, 1, 2, 3, 4, 5});
    expect(kCreatureTypeOptions.keys.toSet(), {
      for (var value = 0; value <= 13; value++) value,
    });
    expect(kBooleanOptions.keys.toSet(), {0, 1});
    expect(kExpansionOptions.keys.toSet(), {0, 1, 2});
    expect(kDamageSchoolOptions.keys.toSet(), {
      for (var value = 0; value <= 6; value++) value,
    });
    expect(kMovementTypeOptions.keys.toSet(), {0, 1, 2});
    expect(kCreatureFamilyOptions.keys.toSet(), {
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
    expect(_valuesOf(kNpcFlagOptions), _bits(0, 26));
    expect(_valuesOf(kUnitFlagOptions), _bits(0, 31));
    expect(_valuesOf(kUnitFlag2Options), {
      ..._bits(0, 8),
      ..._bits(10, 18),
      1 << 24,
    });
    expect(_valuesOf(kCreatureTypeFlagOptions), _bits(0, 31));
    expect(_valuesOf(kDynamicFlagOptions), _bits(0, 7));

    final dbAllowedExtraFlags = _bits(0, 31)..remove(1 << 28);
    expect(_valuesOf(kFlagsExtraOptions), dbAllowedExtraFlags);
    expect(_valuesOf(kFlagsExtraOptions), isNot(contains(1 << 28)));
  });
}

Set<int> _valuesOf(List<FlagItem> flags) =>
    flags.map((flag) => flag.value).toSet();

Set<int> _bits(int first, int last) => {
  for (var bit = first; bit <= last; bit++) 1 << bit,
};
