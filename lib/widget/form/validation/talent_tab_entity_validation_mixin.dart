import 'package:foxy/entity/talent_tab_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin TalentTabValidationMixin on ViewModelValidationMixin {
  void validateTalentTabFields(TalentTabEntity value) {
    final id = value.id;
    final nameLangFlags = value.nameLangFlags;
    final spellIconId = value.spellIconId;
    final raceMask = value.raceMask;
    final classMask = value.classMask;
    final categoryEnumId = value.categoryEnumId;
    final orderIndex = value.orderIndex;

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    requireRange(id, 1, 0x7fffffff, 'ID');
    requireRange(nameLangFlags, -0x80000000, 0x7fffffff, 'Name_lang_Flags');
    requireRange(spellIconId, 0, 0x7fffffff, 'SpellIconID');
    requireRange(raceMask, -0x80000000, 0x7fffffff, 'RaceMask');
    requireRange(classMask, -0x80000000, 0x7fffffff, 'ClassMask');
    requireRange(categoryEnumId, -0x80000000, 0x7fffffff, 'CategoryEnumID');
    requireRange(orderIndex, 0, 2, 'OrderIndex');
  }
}
