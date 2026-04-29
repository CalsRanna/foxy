/// 掉落模板
class LootTemplate {
  final int entry;
  final int item;
  final int reference;
  final double chance;
  final bool questRequired;
  final int lootMode;
  final int groupId;
  final int minCount;
  final int maxCount;
  final String comment;

  // 关联字段（物品信息）
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  // 聚合字段
  final int itemCount;

  /// 显示名称（优先显示本地化名称）
  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  const LootTemplate({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 0,
    this.questRequired = false,
    this.lootMode = 1,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.comment = '',
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
    this.itemCount = 0,
  });

  factory LootTemplate.fromJson(Map<String, dynamic> json) {
    return LootTemplate(
      entry: json['Entry'] ?? json['entry'] ?? 0,
      item: json['Item'] ?? json['item'] ?? 0,
      reference: json['Reference'] ?? json['reference'] ?? 0,
      chance: (json['Chance'] ?? json['chance'] ?? 0).toDouble(),
      questRequired:
          (json['QuestRequired'] ?? json['questRequired'] ?? 0) == 1,
      lootMode: json['LootMode'] ?? json['lootMode'] ?? 1,
      groupId: json['GroupId'] ?? json['groupId'] ?? 0,
      minCount: json['MinCount'] ?? json['mincount'] ?? 1,
      maxCount: json['MaxCount'] ?? json['maxcount'] ?? 1,
      comment: json['Comment'] ?? json['comment'] ?? '',
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
      itemCount: json['ItemCount'] ?? 0,
    );
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
