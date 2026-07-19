import 'package:foxy/constant/creature_enums.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CreatureOnKillReputationValidationMixin on ViewModelValidationMixin {
  void validateCreatureOnKillReputationFields(
    CreatureOnKillReputationEntity value,
  ) {
    requirePositive(value.creatureID, '生物 ID');
    requireNonNegative(value.rewOnKillRepFaction1, '阵营 1');
    requireNonNegative(value.rewOnKillRepFaction2, '阵营 2');
    requireAllowedValue(
      value.maxStanding1,
      kMaxStandingOptions.keys,
      '最高声望等级 1 不是支持的值',
    );
    requireAllowedValue(
      value.maxStanding2,
      kMaxStandingOptions.keys,
      '最高声望等级 2 不是支持的值',
    );
    requireFinite(value.rewOnKillRepValue1, '声望值 1');
    requireFinite(value.rewOnKillRepValue2, '声望值 2');
    requireIntRange(value.teamDependent, 0, 1, '区分阵营');
  }
}
