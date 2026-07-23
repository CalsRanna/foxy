/// 掉落模板 — 对应 *_loot_template 表
class ItemLootTemplateEntity {
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

  const ItemLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100,
    this.questRequired = false,
    this.lootMode = 1,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.comment = '',
  });

  factory ItemLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return ItemLootTemplateEntity(
      entry: json['Entry'] ?? 0,
      item: json['Item'] ?? 0,
      reference: json['Reference'] ?? 0,
      chance: (json['Chance'] as num?)?.toDouble() ?? 100,
      questRequired: (json['QuestRequired'] ?? 0) == 1,
      lootMode: json['LootMode'] ?? 1,
      groupId: json['GroupId'] ?? 0,
      minCount: json['MinCount'] ?? 1,
      maxCount: json['MaxCount'] ?? 1,
      comment: json['Comment'] ?? '',
    );
  }

  ItemLootTemplateEntity copyWith({
    int? entry,
    int? item,
    int? reference,
    double? chance,
    bool? questRequired,
    int? lootMode,
    int? groupId,
    int? minCount,
    int? maxCount,
    String? comment,
  }) {
    return ItemLootTemplateEntity(
      entry: entry ?? this.entry,
      item: item ?? this.item,
      reference: reference ?? this.reference,
      chance: chance ?? this.chance,
      questRequired: questRequired ?? this.questRequired,
      lootMode: lootMode ?? this.lootMode,
      groupId: groupId ?? this.groupId,
      minCount: minCount ?? this.minCount,
      maxCount: maxCount ?? this.maxCount,
      comment: comment ?? this.comment,
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
