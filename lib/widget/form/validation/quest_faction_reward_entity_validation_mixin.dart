import 'package:foxy/entity/quest_faction_reward_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin QuestFactionRewardValidationMixin on ViewModelValidationMixin {
  void validateQuestFactionRewardFields(QuestFactionRewardEntity value) =>
      value._validateFields();
}

extension on QuestFactionRewardEntity {
  void _validateFields() {
    if (id != 1 && id != 2) {
      throw StateError('编号只能是 1（正向）或 2（负向）');
    }
    final positive = id == 1;
    _validateRewardValue('索引 0 声望值', difficulty0, positive: positive);
    _validateRewardValue('索引 1 声望值', difficulty1, positive: positive);
    _validateRewardValue('索引 2 声望值', difficulty2, positive: positive);
    _validateRewardValue('索引 3 声望值', difficulty3, positive: positive);
    _validateRewardValue('索引 4 声望值', difficulty4, positive: positive);
    _validateRewardValue('索引 5 声望值', difficulty5, positive: positive);
    _validateRewardValue('索引 6 声望值', difficulty6, positive: positive);
    _validateRewardValue('索引 7 声望值', difficulty7, positive: positive);
    _validateRewardValue('索引 8 声望值', difficulty8, positive: positive);
    _validateRewardValue('索引 9 声望值', difficulty9, positive: positive);
  }
}

void _validateRewardValue(String label, int value, {required bool positive}) {
  if (value < -2147483648 || value > 2147483647) {
    throw StateError('$label 超出 signed int32 范围');
  }
  if (positive && value < 0) {
    throw StateError('正向记录的 $label 不能小于 0');
  }
  if (!positive && value > 0) {
    throw StateError('负向记录的 $label 不能大于 0');
  }
}
