/// 掉落模板
class LootTemplate {
  int entry = 0;
  int item = 0;
  int reference = 0;
  double chance = 0;
  bool questRequired = false;
  int lootMode = 1;
  int groupId = 0;
  int minCount = 1;
  int maxCount = 1;
  String comment = '';

  // 关联字段（物品信息）
  String itemName = '';
  String itemLocaleName = '';
  int itemQuality = 0;
  String itemIcon = '';

  // 聚合字段
  int itemCount = 0;

  /// 显示名称（优先显示本地化名称）
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  LootTemplate();

  LootTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['Entry'] ?? json['entry'] ?? 0;
    item = json['Item'] ?? json['item'] ?? 0;
    reference = json['Reference'] ?? json['reference'] ?? 0;
    chance = (json['Chance'] ?? json['chance'] ?? 0).toDouble();
    questRequired = (json['QuestRequired'] ?? json['questRequired'] ?? 0) == 1;
    lootMode = json['LootMode'] ?? json['lootMode'] ?? 1;
    groupId = json['GroupId'] ?? json['groupId'] ?? 0;
    minCount = json['MinCount'] ?? json['mincount'] ?? 1;
    maxCount = json['MaxCount'] ?? json['maxcount'] ?? 1;
    comment = json['Comment'] ?? json['comment'] ?? '';
    // 关联字段
    itemName = json['name'] ?? '';
    itemLocaleName = json['localeName'] ?? '';
    itemQuality = json['Quality'] ?? 0;
    itemIcon = json['InventoryIcon_1'] ?? '';
    // 聚合字段
    itemCount = json['ItemCount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'Entry': entry,
      'Item': item,
      'Reference': reference,
      'Chance': chance,
      'QuestRequired': questRequired ? 1 : 0,
      'LootMode': lootMode,
      'GroupId': groupId,
      'MinCount': minCount,
      'MaxCount': maxCount,
      'Comment': comment,
    };
  }
}
