import 'package:foxy/entity/item_visuals_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemVisualsValidationMixin on ViewModelValidationMixin {
  void validateItemVisualsFields(ItemVisualsEntity value) =>
      value._validateFields();
}

extension on ItemVisualsEntity {
  void _validateFields() {
    if (id <= 0 || id > 0x7fffffff) {
      throw ArgumentError('ItemVisuals ID 必须在 1..2147483647 范围内');
    }
    _validateSlot(slot0, 'Slot0');
    _validateSlot(slot1, 'Slot1');
    _validateSlot(slot2, 'Slot2');
    _validateSlot(slot3, 'Slot3');
    _validateSlot(slot4, 'Slot4');
  }

  void _validateSlot(int value, String name) {
    if (value < 0 || value > 0x7fffffff) {
      throw ArgumentError('$name 必须是有效的 ItemVisualEffects ID');
    }
  }
}
