import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CurrencyCategoryValidationMixin on ViewModelValidationMixin {
  void validateCurrencyCategoryFields(CurrencyCategoryEntity value) {
    final id = value.id;
    final flags = value.flags;
    final nameLangFlags = value.nameLangFlags;

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    void requireSignedInt32(int value, String name) {
      requireRange(value, -0x80000000, 0x7fffffff, name);
    }

    requireRange(id, 1, 0x7fffffff, 'ID');
    requireSignedInt32(flags, 'Flags');
    requireSignedInt32(nameLangFlags, 'Name_lang_Flags');
  }
}
