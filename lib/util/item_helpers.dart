import 'package:foxy/constant/item_constants.dart';

String getItemClassName(int classId) {
  if (classId < 0 || classId >= kItemClasses.length) return '未知';
  return kItemClasses[classId];
}

String getItemSubclassName(int classId, int subclass) {
  if (classId < 0 || classId >= kItemSubclasses.length) return '未知';
  final subclasses = kItemSubclasses[classId];
  if (subclass < 0 || subclass >= subclasses.length) return '未知';
  return subclasses[subclass];
}

String getItemInventoryTypeName(int inventoryType) {
  if (inventoryType < 0 || inventoryType >= kItemInventoryTypes.length) {
    return '未知';
  }
  return kItemInventoryTypes[inventoryType];
}
