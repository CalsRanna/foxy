import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin NpcTrainerValidationMixin on ViewModelValidationMixin {
  void validateNpcTrainerFields(NpcTrainerEntity value) {
    requirePositive(value.trainerId, '训练师 ID');
    requirePositive(value.spellId, '技能 ID');
    requireNonNegative(value.moneyCost, '金币花费');
    requireNonNegative(value.reqSkillLine, '需要技能线');
    requireNonNegative(value.reqSkillRank, '需要技能等级');
    requireNonNegative(value.reqAbility1, '前置技能 1');
    requireNonNegative(value.reqAbility2, '前置技能 2');
    requireNonNegative(value.reqAbility3, '前置技能 3');
    requireIntRange(value.reqLevel, 0, 255, '需要等级');
  }
}
