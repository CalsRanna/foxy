/// 物品模板简要信息（用于列表显示）
class BriefItemTemplate {
  int entry = 0;
  String name = '';
  String localeName = '';
  int quality = 0;
  int classId = 0;
  int subclass = 0;
  int inventoryType = 0;
  int itemLevel = 0;
  int requiredLevel = 0;

  BriefItemTemplate();

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

  BriefItemTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    name = json['name'] ?? '';
    localeName = json['localeName'] ?? json['Name'] ?? '';
    quality = json['Quality'] ?? json['quality'] ?? 0;
    classId = json['class'] ?? json['classId'] ?? 0;
    subclass = json['subclass'] ?? 0;
    inventoryType = json['InventoryType'] ?? json['inventoryType'] ?? 0;
    itemLevel = json['ItemLevel'] ?? json['itemLevel'] ?? 0;
    requiredLevel = json['RequiredLevel'] ?? json['requiredLevel'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'quality': quality,
      'class': classId,
      'subclass': subclass,
      'InventoryType': inventoryType,
      'ItemLevel': itemLevel,
      'RequiredLevel': requiredLevel,
    };
  }
}
