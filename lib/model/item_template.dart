/// 物品模板
class ItemTemplate {
  int entry = 0;
  String name = '';
  String localeName = '';
  int quality = 0;
  int className = 0;
  int subclass = 0;
  int inventoryType = 0;
  int itemLevel = 0;
  int requiredLevel = 0;
  String inventoryIcon = '';
  int displayId = 0;

  /// 显示名称（优先显示本地化名称）
  String get displayName => localeName.isNotEmpty ? localeName : name;

  ItemTemplate();

  ItemTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    name = json['name'] ?? '';
    localeName = json['localeName'] ?? json['Name'] ?? '';
    quality = json['Quality'] ?? json['quality'] ?? 0;
    className = json['class'] ?? json['className'] ?? 0;
    subclass = json['subclass'] ?? 0;
    inventoryType = json['InventoryType'] ?? json['inventoryType'] ?? 0;
    itemLevel = json['ItemLevel'] ?? json['itemLevel'] ?? 0;
    requiredLevel = json['RequiredLevel'] ?? json['requiredLevel'] ?? 0;
    inventoryIcon = json['InventoryIcon_1'] ?? json['inventoryIcon'] ?? '';
    displayId = json['displayid'] ?? json['displayId'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'name': name,
      'Quality': quality,
      'class': className,
      'subclass': subclass,
      'InventoryType': inventoryType,
      'ItemLevel': itemLevel,
      'RequiredLevel': requiredLevel,
      'displayid': displayId,
    };
  }
}
