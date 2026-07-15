import 'package:foxy/constant/currency_type_constants.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CurrencyTypeValidationMixin on ViewModelValidationMixin {
  void validateCurrencyTypeFields(CurrencyTypeEntity value) =>
      value._validateFields();
}

extension on CurrencyTypeEntity {
  void _validateFields() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireRange(itemId, 1, 0x7fffffff, 'ItemID');
    _requireRange(categoryId, 1, 0x7fffffff, 'CategoryID');
    _requireRange(
      bitIndex,
      kCurrencyBitIndexMinimum,
      kCurrencyBitIndexMaximum,
      'BitIndex',
    );
  }

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }
}
