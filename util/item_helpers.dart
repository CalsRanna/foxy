import 'package:foxy/constant/item_constants.dart';

extension ItemClassNameLookup on List<String> {
  String className(int classId) {
    if (classId < 0 || classId >= length) return '未知';
    return this[classId];
  }

  String subclassName(int classId, int subclass) {
    if (classId < 0 || classId >= length) return '未知';
    final sublist = this[classId] as dynamic;
    if (subclass < 0 || subclass >= sublist.length) return '未知';
    return sublist[subclass];
  }
}

String getItemClassName(int classId) => kItemClasses.className(classId);

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
