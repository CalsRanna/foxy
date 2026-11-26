import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Stat types use this table\'s empty slot and the actual ItemModType domain',
    () {
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
    },
  );
}
