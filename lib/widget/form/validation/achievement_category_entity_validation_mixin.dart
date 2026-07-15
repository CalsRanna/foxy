import 'package:foxy/entity/achievement_category_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin AchievementCategoryValidationMixin on ViewModelValidationMixin {
  void validateAchievementCategoryFields(AchievementCategoryEntity value) =>
      value._validateFields();
}

extension on AchievementCategoryEntity {
  void _validateFields() {
    if (id <= 0 || id > 0x7fffffff) {
      throw ArgumentError.value(id, 'ID', '必须在 1..2147483647 范围内');
    }
    if (parent < -1 || parent > 0x7fffffff) {
      throw ArgumentError.value(parent, 'Parent', '必须为 -1 或正 int32');
    }
    if (parent == id) throw ArgumentError('Parent 不能引用自身');
    _requireInt32(nameLangFlags, 'Name_lang_Flags');
    _requireNonNegativeInt32(uiOrder, 'Ui_order');
  }

  void _requireNonNegativeInt32(int value, String field) {
    if (value < 0 || value > 0x7fffffff) {
      throw ArgumentError.value(value, field, '必须为非负 int32');
    }
  }

  void _requireInt32(int value, String field) {
    if (value < -0x80000000 || value > 0x7fffffff) {
      throw ArgumentError.value(value, field, '必须在 signed int32 范围内');
    }
  }
}
