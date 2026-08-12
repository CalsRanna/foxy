import 'package:foxy/constant/item_constants.dart';

/// Item class / inventory type / subclass display-name helpers.
abstract final class ItemHelpers {
  static String getItemClassName(int classId) {
    if (classId < 0 || classId >= ItemConstants.itemClasses.length) return '未知';
    return ItemConstants.itemClasses[classId];
  }

  static String getItemInventoryTypeName(int inventoryType) {
    if (inventoryType < 0 ||
        inventoryType >= ItemConstants.itemInventoryTypes.length) {
      return '未知';
    }
    return ItemConstants.itemInventoryTypes[inventoryType];
  }

  static String getItemSubclassName(int classId, int subclass) {
    if (classId < 0 || classId >= ItemConstants.itemSubclasses.length) {
      return '未知';
    }
    final subclasses = ItemConstants.itemSubclasses[classId];
    if (subclass < 0 || subclass >= subclasses.length) return '未知';
    return subclasses[subclass];
  }
}
