/// NPC商人物品
class NpcVendor {
  int entry = 0;
  int slot = 0;
  int item = 0;
  int maxcount = 0;
  int incrtime = 0;
  int extendedCost = 0;
  int verifiedBuild = 0;

  // 关联字段（物品信息）
  String itemName = '';
  String itemLocaleName = '';
  int itemQuality = 0;
  String itemIcon = '';

  /// 显示名称（优先显示本地化名称）
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  NpcVendor();

  NpcVendor.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    slot = json['slot'] ?? 0;
    item = json['item'] ?? 0;
    maxcount = json['maxcount'] ?? 0;
    incrtime = json['incrtime'] ?? 0;
    extendedCost = json['ExtendedCost'] ?? json['extendedCost'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;
    // 关联字段
    itemName = json['name'] ?? '';
    itemLocaleName = json['localeName'] ?? '';
    itemQuality = json['Quality'] ?? 0;
    itemIcon = json['InventoryIcon_1'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'slot': slot,
      'item': item,
      'maxcount': maxcount,
      'incrtime': incrtime,
      'ExtendedCost': extendedCost,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
