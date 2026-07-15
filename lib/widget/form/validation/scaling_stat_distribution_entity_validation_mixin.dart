import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ScalingStatDistributionValidationMixin on ViewModelValidationMixin {
  void validateScalingStatDistributionFields(
    ScalingStatDistributionEntity value,
  ) => value._validateFields();
}

extension on ScalingStatDistributionEntity {
  void _validateFields() {
    if (id < 1 || id > 32767) {
      throw StateError('ID 必须在 1 到 32767 之间');
    }
    _validateStat(statId0, 'StatID0');
    _validateStat(statId1, 'StatID1');
    _validateStat(statId2, 'StatID2');
    _validateStat(statId3, 'StatID3');
    _validateStat(statId4, 'StatID4');
    _validateStat(statId5, 'StatID5');
    _validateStat(statId6, 'StatID6');
    _validateStat(statId7, 'StatID7');
    _validateStat(statId8, 'StatID8');
    _validateStat(statId9, 'StatID9');
    _validateBonus(bonus0, 'Bonus0');
    _validateBonus(bonus1, 'Bonus1');
    _validateBonus(bonus2, 'Bonus2');
    _validateBonus(bonus3, 'Bonus3');
    _validateBonus(bonus4, 'Bonus4');
    _validateBonus(bonus5, 'Bonus5');
    _validateBonus(bonus6, 'Bonus6');
    _validateBonus(bonus7, 'Bonus7');
    _validateBonus(bonus8, 'Bonus8');
    _validateBonus(bonus9, 'Bonus9');
    if (maxlevel < 0 || maxlevel > 0x7fffffff) {
      throw StateError('Maxlevel 必须在 0 到 2147483647 之间');
    }
  }

  void _validateStat(int value, String column) {
    if (!kScalingStatDistributionStatOptions.containsKey(value)) {
      throw StateError('$column 不是有效的缩放属性类型');
    }
  }

  void _validateBonus(int value, String column) {
    if (value < 0 || value > 0x7fffffff) {
      throw StateError('$column 必须在 0 到 2147483647 之间');
    }
  }
}
