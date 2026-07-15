import 'package:foxy/entity/item_visual_effect_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemVisualEffectValidationMixin on ViewModelValidationMixin {
  void validateItemVisualEffectFields(ItemVisualEffectEntity value) {
    final id = value.id;

    if (id <= 0 || id > 0x7fffffff) {
      throw ArgumentError('ItemVisualEffects ID 必须在 1..2147483647 范围内');
    }
  }
}
