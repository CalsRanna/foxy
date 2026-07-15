import 'package:foxy/constant/gem_property_constants.dart';
import 'package:foxy/entity/gem_property_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin GemPropertyValidationMixin on ViewModelValidationMixin {
  void validateGemPropertyFields(GemPropertyEntity value) {
    final id = value.id;
    final enchantId = value.enchantId;
    final maxCountInv = value.maxCountInv;
    final maxCountItem = value.maxCountItem;
    final type = value.type;

    void requireRange(int value, int minimum, int maximum, String name) {
      if (value < minimum || value > maximum) {
        throw ArgumentError('$name 必须在 $minimum..$maximum 范围内');
      }
    }

    requireRange(id, 1, 0x7fffffff, 'ID');
    requireRange(enchantId, 0, 0x7fffffff, 'Enchant_ID');
    requireRange(maxCountInv, 0, 0x7fffffff, 'Maxcount_inv');
    requireRange(maxCountItem, 0, 0x7fffffff, 'Maxcount_item');
    if (!kGemPropertyColorOptions.containsKey(type)) {
      throw ArgumentError('Type 必须是有效的 GemProperties SocketColor 组合');
    }
  }
}
