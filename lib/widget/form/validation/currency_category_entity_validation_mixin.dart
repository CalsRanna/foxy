import 'package:foxy/entity/currency_category_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CurrencyCategoryValidationMixin on ViewModelValidationMixin {
  void validateCurrencyCategoryFields(CurrencyCategoryEntity value) =>
      value._validateFields();
}

extension on CurrencyCategoryEntity {
  void _validateFields() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireSignedInt32(flags, 'Flags');
    _requireSignedInt32(nameLangFlags, 'Name_lang_Flags');
  }

  void _requireSignedInt32(int value, String name) {
    _requireRange(value, -0x80000000, 0x7fffffff, name);
  }

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }
}
