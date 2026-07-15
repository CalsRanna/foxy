import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ScalingStatDistributionValidationMixin on ViewModelValidationMixin {
  void validateScalingStatDistributionFields(
    ScalingStatDistributionEntity value,
  ) {
    final id = value.id;
    final statId0 = value.statId0;
    final statId1 = value.statId1;
    final statId2 = value.statId2;
    final statId3 = value.statId3;
    final statId4 = value.statId4;
    final statId5 = value.statId5;
    final statId6 = value.statId6;
    final statId7 = value.statId7;
    final statId8 = value.statId8;
    final statId9 = value.statId9;
    final bonus0 = value.bonus0;
    final bonus1 = value.bonus1;
    final bonus2 = value.bonus2;
    final bonus3 = value.bonus3;
    final bonus4 = value.bonus4;
    final bonus5 = value.bonus5;
    final bonus6 = value.bonus6;
    final bonus7 = value.bonus7;
    final bonus8 = value.bonus8;
    final bonus9 = value.bonus9;
    final maxlevel = value.maxlevel;

    void validateStat(int value, String column) {
      if (!kScalingStatDistributionStatOptions.containsKey(value)) {
        throw StateError('$column 不是有效的缩放属性类型');
      }
    }

    void validateBonus(int value, String column) {
      if (value < 0 || value > 0x7fffffff) {
        throw StateError('$column 必须在 0 到 2147483647 之间');
      }
    }

    if (id < 1 || id > 32767) {
      throw StateError('ID 必须在 1 到 32767 之间');
    }
    validateStat(statId0, 'StatID0');
    validateStat(statId1, 'StatID1');
    validateStat(statId2, 'StatID2');
    validateStat(statId3, 'StatID3');
    validateStat(statId4, 'StatID4');
    validateStat(statId5, 'StatID5');
    validateStat(statId6, 'StatID6');
    validateStat(statId7, 'StatID7');
    validateStat(statId8, 'StatID8');
    validateStat(statId9, 'StatID9');
    validateBonus(bonus0, 'Bonus0');
    validateBonus(bonus1, 'Bonus1');
    validateBonus(bonus2, 'Bonus2');
    validateBonus(bonus3, 'Bonus3');
    validateBonus(bonus4, 'Bonus4');
    validateBonus(bonus5, 'Bonus5');
    validateBonus(bonus6, 'Bonus6');
    validateBonus(bonus7, 'Bonus7');
    validateBonus(bonus8, 'Bonus8');
    validateBonus(bonus9, 'Bonus9');
    if (maxlevel < 0 || maxlevel > 0x7fffffff) {
      throw StateError('Maxlevel 必须在 0 到 2147483647 之间');
    }
  }
}
