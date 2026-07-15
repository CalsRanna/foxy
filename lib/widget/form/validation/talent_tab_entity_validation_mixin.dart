import 'package:foxy/entity/talent_tab_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin TalentTabValidationMixin on ViewModelValidationMixin {
  void validateTalentTabFields(TalentTabEntity value) =>
      value._validateFields();
}

extension on TalentTabEntity {
  void _validateFields() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireRange(nameLangFlags, -0x80000000, 0x7fffffff, 'Name_lang_Flags');
    _requireRange(spellIconId, 0, 0x7fffffff, 'SpellIconID');
    _requireRange(raceMask, -0x80000000, 0x7fffffff, 'RaceMask');
    _requireRange(classMask, -0x80000000, 0x7fffffff, 'ClassMask');
    _requireRange(categoryEnumId, -0x80000000, 0x7fffffff, 'CategoryEnumID');
    _requireRange(orderIndex, 0, 2, 'OrderIndex');
  }

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }
}
