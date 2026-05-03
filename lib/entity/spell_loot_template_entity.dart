/// 法术掉落模板
class SpellLootTemplateEntity {
  final int entry;
  final int item;
  final int reference;
  final double chance;
  final int questRequired;
  final int lootMode;
  final int groupId;
  final int minCount;
  final int maxCount;
  final String comment;

  // 关联字段
  final String itemName;
  final String localeName;
  final int quality;
  final String icon;

  const SpellLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 0.0,
    this.questRequired = 0,
    this.lootMode = 0,
    this.groupId = 0,
    this.minCount = 0,
    this.maxCount = 0,
    this.comment = '',
    this.itemName = '',
    this.localeName = '',
    this.quality = 0,
    this.icon = '',
  });

  factory SpellLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return SpellLootTemplateEntity(
      entry: json['Entry'] ?? json['entry'] ?? 0,
      item: json['Item'] ?? json['item'] ?? 0,
      reference: json['Reference'] ?? json['reference'] ?? 0,
      chance: (json['Chance'] ?? json['chance'] ?? 0.0),
      questRequired: json['QuestRequired'] ?? json['questRequired'] ?? 0,
      lootMode: json['LootMode'] ?? json['lootMode'] ?? 0,
      groupId: json['GroupId'] ?? json['GroudId'] ?? json['groupId'] ?? 0,
      minCount: json['MinCount'] ?? json['minCount'] ?? 0,
      maxCount: json['MaxCount'] ?? json['maxCount'] ?? 0,
      comment: json['Comment'] ?? json['comment'] ?? '',
      itemName: json['name'] ?? '',
      localeName: json['localeName'] ?? '',
      quality: json['Quality'] ?? 0,
      icon: json['InventoryIcon0'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Entry': entry,
      'Item': item,
      'Reference': reference,
      'Chance': chance,
      'QuestRequired': questRequired,
      'LootMode': lootMode,
      'GroupId': groupId,
      'MinCount': minCount,
      'MaxCount': maxCount,
      'Comment': comment,
    };
  }
}
