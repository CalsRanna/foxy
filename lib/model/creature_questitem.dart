/// 生物任务物品
class CreatureQuestItem {
  int creatureEntry = 0;
  int idx = 0;
  int itemId = 0;
  int verifiedBuild = 0;

  // 关联字段（物品信息）
  String itemName = '';
  String itemLocaleName = '';
  int itemQuality = 0;
  String itemIcon = '';

  /// 显示名称（优先显示本地化名称）
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  CreatureQuestItem();

  CreatureQuestItem.fromJson(Map<String, dynamic> json) {
    creatureEntry = json['CreatureEntry'] ?? json['creatureEntry'] ?? 0;
    idx = json['Idx'] ?? json['idx'] ?? 0;
    itemId = json['ItemId'] ?? json['itemId'] ?? 0;
    verifiedBuild = json['VerifiedBuild'] ?? json['verifiedBuild'] ?? 0;
    // 关联字段
    itemName = json['name'] ?? '';
    itemLocaleName = json['localeName'] ?? '';
    itemQuality = json['Quality'] ?? 0;
    itemIcon = json['InventoryIcon_1'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatureEntry': creatureEntry,
      'Idx': idx,
      'ItemId': itemId,
      'VerifiedBuild': verifiedBuild,
    };
  }
}
