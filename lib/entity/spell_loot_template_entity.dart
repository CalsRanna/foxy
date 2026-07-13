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

  const SpellLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100.0,
    this.questRequired = 0,
    this.lootMode = 1,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.comment = '',
  });

  void validate() {
    if (lootMode == 0) throw StateError('掉落模式不能为 0');
    if (groupId < 0 || groupId > 127) {
      throw RangeError.range(groupId, 0, 127, 'GroupId');
    }
    if (minCount < 1 || minCount > 255) {
      throw RangeError.range(minCount, 1, 255, 'MinCount');
    }
    if (maxCount < 1 || maxCount > 255) {
      throw RangeError.range(maxCount, 1, 255, 'MaxCount');
    }
    if (reference == 0 && maxCount < minCount) {
      throw StateError('最大数量不能小于最小数量');
    }
    if (chance == 0 && groupId == 0) {
      throw StateError('掉落几率为 0 时必须指定掉落组');
    }
    if (chance < 0 || chance > 100) {
      throw RangeError.range(chance, 0, 100, 'Chance');
    }
    if (questRequired != 0 && questRequired != 1) {
      throw ArgumentError.value(questRequired, 'QuestRequired', '只能为 0 或 1');
    }
  }

  factory SpellLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return SpellLootTemplateEntity(
      entry: json['Entry'] ?? json['entry'] ?? 0,
      item: json['Item'] ?? json['item'] ?? 0,
      reference: json['Reference'] ?? json['reference'] ?? 0,
      chance: (json['Chance'] ?? json['chance'] ?? 100).toDouble(),
      questRequired: json['QuestRequired'] ?? json['questRequired'] ?? 0,
      lootMode: json['LootMode'] ?? json['lootMode'] ?? 1,
      groupId: json['GroupId'] ?? 0,
      minCount: json['MinCount'] ?? json['minCount'] ?? 1,
      maxCount: json['MaxCount'] ?? json['maxCount'] ?? 1,
      comment: json['Comment'] ?? json['comment'] ?? '',
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

  SpellLootTemplateEntity copyWith({
    int? entry,
    int? item,
    int? reference,
    double? chance,
    int? questRequired,
    int? lootMode,
    int? groupId,
    int? minCount,
    int? maxCount,
    String? comment,
  }) {
    return SpellLootTemplateEntity(
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
}

class BriefSpellLootTemplateEntity {
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
  final String itemName;
  final String localeName;
  final int quality;
  final String icon;

  const BriefSpellLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100.0,
    this.questRequired = 0,
    this.lootMode = 1,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.comment = '',
    this.itemName = '',
    this.localeName = '',
    this.quality = 0,
    this.icon = '',
  });

  factory BriefSpellLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellLootTemplateEntity(
      entry: json['Entry'] ?? 0,
      item: json['Item'] ?? 0,
      reference: json['Reference'] ?? 0,
      chance: (json['Chance'] ?? 100).toDouble(),
      questRequired: json['QuestRequired'] ?? 0,
      lootMode: json['LootMode'] ?? 1,
      groupId: json['GroupId'] ?? 0,
      minCount: json['MinCount'] ?? 1,
      maxCount: json['MaxCount'] ?? 1,
      comment: json['Comment'] ?? '',
      itemName: json['name'] ?? '',
      localeName: json['localeName'] ?? '',
      quality: json['Quality'] ?? 0,
      icon: json['InventoryIcon0'] ?? '',
    );
  }
}
