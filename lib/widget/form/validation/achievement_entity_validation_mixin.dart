import 'package:foxy/constant/achievement_constants.dart';
import 'package:foxy/entity/achievement_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin AchievementValidationMixin on ViewModelValidationMixin {
  void validateAchievementFields(AchievementEntity value) =>
      value._validateFields();
}

extension on AchievementEntity {
  void _validateFields() {
    if (id <= 0 || id > 0xffff) {
      throw ArgumentError.value(id, 'ID', '必须在 1..65535 范围内');
    }
    if (!kAchievementFactionOptions.containsKey(faction)) {
      throw ArgumentError.value(faction, 'Faction', '必须为 -1、0 或 1');
    }
    if (instanceId < -1 || instanceId > 0x7fffffff) {
      throw ArgumentError.value(instanceId, 'Instance_ID', '必须为 -1 或非负 int32');
    }
    _requireNonNegativeInt32(supercedes, 'Supercedes');
    if (supercedes == id) throw ArgumentError('Supercedes 不能引用自身');
    _requireInt32(titleLangFlags, 'Title_lang_Flags');
    _requireInt32(descriptionLangFlags, 'Description_lang_Flags');
    if (category <= 0 || category > 0x7fffffff) {
      throw ArgumentError.value(category, 'Category', '必须引用正 int32 分类 ID');
    }
    _requireNonNegativeInt32(points, 'Points');
    _requireNonNegativeInt32(uiOrder, 'Ui_order');
    if (flags < 0 || (flags & ~kAchievementKnownFlagMask) != 0) {
      throw ArgumentError.value(flags, 'Flags', '包含 3.3.5a 未定义位');
    }
    _requireNonNegativeInt32(iconId, 'IconID');
    _requireInt32(rewardLangFlags, 'Reward_lang_Flags');
    _requireNonNegativeInt32(minimumCriteria, 'Minimum_criteria');
    _requireNonNegativeInt32(sharesCriteria, 'Shares_criteria');
    if (sharesCriteria == id) throw ArgumentError('Shares_criteria 不能引用自身');
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
