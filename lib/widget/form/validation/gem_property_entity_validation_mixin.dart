import 'package:foxy/constant/gem_property_constants.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GemPropertyValidationMixin on ViewModelValidationMixin {
  void validateGemPropertyFields(GemPropertyEntity value) =>
      value._validateFields();
}

extension on GemPropertyEntity {
  void _validateFields() {
    _requireRange(id, 1, 0x7fffffff, 'ID');
    _requireRange(enchantId, 0, 0x7fffffff, 'Enchant_ID');
    _requireRange(maxCountInv, 0, 0x7fffffff, 'Maxcount_inv');
    _requireRange(maxCountItem, 0, 0x7fffffff, 'Maxcount_item');
    if (!kGemPropertyColorOptions.containsKey(type)) {
      throw ArgumentError('Type 必须是有效的 GemProperties SocketColor 组合');
    }
  }

  void _requireRange(int value, int minimum, int maximum, String name) {
    if (value < minimum || value > maximum) {
      throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
    }
  }
}
