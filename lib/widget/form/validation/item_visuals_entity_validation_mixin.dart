import 'package:foxy/entity/item_visuals_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemVisualsValidationMixin on ViewModelValidationMixin {
  void validateItemVisualsFields(ItemVisualsEntity value) {
    final id = value.id;
    final slot0 = value.slot0;
    final slot1 = value.slot1;
    final slot2 = value.slot2;
    final slot3 = value.slot3;
    final slot4 = value.slot4;

    void validateSlot(int value, String name) {
      if (value < 0 || value > 0x7fffffff) {
        throw ArgumentError('$name 必须是有效的 ItemVisualEffects ID');
      }
    }

    if (id <= 0 || id > 0x7fffffff) {
      throw ArgumentError('ItemVisuals ID 必须在 1..2147483647 范围内');
    }
    validateSlot(slot0, 'Slot0');
    validateSlot(slot1, 'Slot1');
    validateSlot(slot2, 'Slot2');
    validateSlot(slot3, 'Slot3');
    validateSlot(slot4, 'Slot4');
  }
}
