import 'package:foxy/entity/quest_sort_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin QuestSortValidationMixin on ViewModelValidationMixin {
  void validateQuestSortFields(QuestSortEntity value) =>
      value._validateFields();
}

extension on QuestSortEntity {
  void _validateFields() {
    if (id <= 0 || id > 32768) {
      throw StateError('编号必须在 1..32768 之间');
    }
    if (sortNameLangFlags < -2147483648 || sortNameLangFlags > 2147483647) {
      throw StateError('名称语言标志超出 signed int32 范围');
    }
  }
}
