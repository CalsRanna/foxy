import 'package:foxy/entity/item_purchase_group_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin ItemPurchaseGroupValidationMixin on ViewModelValidationMixin {
  void validateItemPurchaseGroupFields(ItemPurchaseGroupEntity value) {
    final id = value.id;
    final itemID0 = value.itemID0;
    final itemID1 = value.itemID1;
    final itemID2 = value.itemID2;
    final itemID3 = value.itemID3;
    final itemID4 = value.itemID4;
    final itemID5 = value.itemID5;
    final itemID6 = value.itemID6;
    final itemID7 = value.itemID7;
    final nameLangFlags = value.nameLangFlags;

    _requirePositiveInt32('编号', id);
    _requireUnsignedInt32('物品 ID 0', itemID0);
    _requireUnsignedInt32('物品 ID 1', itemID1);
    _requireUnsignedInt32('物品 ID 2', itemID2);
    _requireUnsignedInt32('物品 ID 3', itemID3);
    _requireUnsignedInt32('物品 ID 4', itemID4);
    _requireUnsignedInt32('物品 ID 5', itemID5);
    _requireUnsignedInt32('物品 ID 6', itemID6);
    _requireUnsignedInt32('物品 ID 7', itemID7);
    if (nameLangFlags < -2147483648 || nameLangFlags > 2147483647) {
      throw StateError('名称语言标志超出 signed int32 范围');
    }
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
