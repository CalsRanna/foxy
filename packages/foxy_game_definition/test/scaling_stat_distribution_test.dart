import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('属性类型使用本表的空槽和实际 ItemModType 域', () {
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      containsPair(-1, '空槽'),
    );
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      containsPair(0, '法力值'),
    );
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      containsPair(40, '野性攻击强度（客户端兼容）'),
    );
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      containsPair(48, '格挡值'),
    );
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      isNot(contains(2)),
    );
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      isNot(contains(8)),
    );
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      isNot(contains(11)),
    );
  });
}
