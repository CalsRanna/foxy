import 'package:foxy/entity/item_extended_cost_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemExtendedCostValidationMixin on ViewModelValidationMixin {
  void validateItemExtendedCostFields(ItemExtendedCostEntity value) {
    final id = value.id;
    final honorPoints = value.honorPoints;
    final arenaPoints = value.arenaPoints;
    final arenaBracket = value.arenaBracket;
    final itemID0 = value.itemID0;
    final itemID1 = value.itemID1;
    final itemID2 = value.itemID2;
    final itemID3 = value.itemID3;
    final itemID4 = value.itemID4;
    final itemCount0 = value.itemCount0;
    final itemCount1 = value.itemCount1;
    final itemCount2 = value.itemCount2;
    final itemCount3 = value.itemCount3;
    final itemCount4 = value.itemCount4;
    final requiredArenaRating = value.requiredArenaRating;
    final itemPurchaseGroup = value.itemPurchaseGroup;

    _requirePositiveInt32('编号', id);
    _requireUnsignedInt32('荣誉点数', honorPoints);
    _requireUnsignedInt32('竞技场点数', arenaPoints);
    if (arenaBracket < 0 || arenaBracket > 2) {
      throw StateError('最低竞技场槽位必须是 0、1 或 2');
    }
    _validateItemRequirement('物品 0', itemID0, itemCount0);
    _validateItemRequirement('物品 1', itemID1, itemCount1);
    _validateItemRequirement('物品 2', itemID2, itemCount2);
    _validateItemRequirement('物品 3', itemID3, itemCount3);
    _validateItemRequirement('物品 4', itemID4, itemCount4);
    _requireUnsignedInt32('所需个人竞技场评级', requiredArenaRating);
    _requireUnsignedInt32('物品购买组', itemPurchaseGroup);
  }
}

void _requirePositiveInt32(String label, int value) {
  if (value <= 0 || value > 2147483647) {
    throw StateError('$label必须在 1..2147483647 之间');
  }
}

void _requireUnsignedInt32(String label, int value) {
  if (value < 0 || value > 2147483647) {
    throw StateError('$label必须在 0..2147483647 之间');
  }
}

void _validateItemRequirement(String label, int itemId, int count) {
  _requireUnsignedInt32('$label ID', itemId);
  _requireUnsignedInt32('$label数量', count);
  if (itemId != 0 && count == 0) {
    throw StateError('$label设置了 ID 时数量必须大于 0');
  }
}
