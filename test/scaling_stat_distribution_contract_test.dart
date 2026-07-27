import 'package:flutter_test/flutter_test.dart';
import 'support/entity_validation_test_extensions.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';

void main() {
  test('Entity 精确覆盖 22 个物理列且全部为标量', () {
    final json = const ScalingStatDistributionEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'StatID0',
      'StatID1',
      'StatID2',
      'StatID3',
      'StatID4',
      'StatID5',
      'StatID6',
      'StatID7',
      'StatID8',
      'StatID9',
      'Bonus0',
      'Bonus1',
      'Bonus2',
      'Bonus3',
      'Bonus4',
      'Bonus5',
      'Bonus6',
      'Bonus7',
      'Bonus8',
      'Bonus9',
      'Maxlevel',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('属性类型使用本表的空槽和实际 ItemModType 域', () {
    expect(kScalingStatDistributionStatOptions, containsPair(-1, '空槽'));
    expect(kScalingStatDistributionStatOptions, containsPair(0, '法力值'));
    expect(
      kScalingStatDistributionStatOptions,
      containsPair(40, '野性攻击强度（客户端兼容）'),
    );
    expect(kScalingStatDistributionStatOptions, containsPair(48, '格挡值'));
    expect(kScalingStatDistributionStatOptions, isNot(contains(2)));
    expect(kScalingStatDistributionStatOptions, isNot(contains(8)));
    expect(kScalingStatDistributionStatOptions, isNot(contains(11)));
  });

  test('校验保留实际 DBC 的零值语义并拒绝无效类型和值域', () {
    expect(
      const ScalingStatDistributionEntity(
        id: 1,
        statId0: 40,
        bonus0: 0,
        maxlevel: 0,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const ScalingStatDistributionEntity(id: 1, statId0: 2).validate(),
      throwsStateError,
    );
    expect(
      () => const ScalingStatDistributionEntity(id: 1, bonus0: -1).validate(),
      throwsStateError,
    );
    expect(
      () => const ScalingStatDistributionEntity(id: 32768).validate(),
      throwsStateError,
    );
  });

  test('空槽为 -1 且属性类型 0 能正常显示', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: 0,
      bonus0: 10000,
    );
    expect(entity.displayStats, '0+10000');
    expect(const ScalingStatDistributionEntity().statId9, -1);
    expect(const ScalingStatDistributionEntity().maxlevel, 80);
  });

  test('DBC definition 与 AzerothCore 3.3.5a 的 22 列格式一致', () {
    final definition = dbcDefinitionByTable['dbc_scaling_stat_distribution']!;
    expect(definition.fileName, 'ScalingStatDistribution.dbc');
    expect(definition.schema.format, 'niiiiiiiiiiiiiiiiiiiii');
    expect(definition.schema.fields, hasLength(22));
  });
}
