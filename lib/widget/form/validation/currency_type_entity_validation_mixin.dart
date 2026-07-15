import 'package:foxy/constant/currency_type_constants.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin CurrencyTypeValidationMixin on ViewModelValidationMixin {
  void validateCurrencyTypeFields(CurrencyTypeEntity value) {
    final id = value.id;
    final itemId = value.itemId;
    final categoryId = value.categoryId;
    final bitIndex = value.bitIndex;

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    requireRange(id, 1, 0x7fffffff, 'ID');
    requireRange(itemId, 1, 0x7fffffff, 'ItemID');
    requireRange(categoryId, 1, 0x7fffffff, 'CategoryID');
    requireRange(
      bitIndex,
      kCurrencyBitIndexMinimum,
      kCurrencyBitIndexMaximum,
      'BitIndex',
    );
  }
}
