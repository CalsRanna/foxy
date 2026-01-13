/// 物品模板筛选实体
class ItemTemplateFilterEntity {
  String entry = '';
  String name = '';
  String description = '';
  int classId = -1;  // -1 表示未选择类别
  int subclass = -1; // -1 表示未选择子类别

  ItemTemplateFilterEntity();

  /// 检查是否有筛选条件
  bool get hasFilter {
    return entry.isNotEmpty ||
        name.isNotEmpty ||
        description.isNotEmpty ||
        classId >= 0 ||
        subclass >= 0;
  }

  /// 重置筛选条件
  void reset() {
    entry = '';
    name = '';
    description = '';
    classId = -1;
    subclass = -1;
  }

  ItemTemplateFilterEntity copy() {
    return ItemTemplateFilterEntity()
      ..entry = entry
      ..name = name
      ..description = description
      ..classId = classId
      ..subclass = subclass;
  }
}
