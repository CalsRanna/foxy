/// 掉落模板 — 对应 *_loot_template 表
class LootTemplateEntity {
  static const validLootModeMask = 0x803f;

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

  const LootTemplateEntity({
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

  void validate() {
    if (entry < 0 || entry > 0xffffffff) {
      throw RangeError.range(entry, 0, 0xffffffff, 'Entry');
    }
    if (item < 0 || item > 0xffffffff) {
      throw RangeError.range(item, 0, 0xffffffff, 'Item');
    }
    if (reference < -0x7fffffff || reference > 0x7fffffff) {
      throw RangeError.range(reference, -0x7fffffff, 0x7fffffff, 'Reference');
    }
    if (!chance.isFinite || chance < 0 || chance > 100) {
      throw RangeError.range(chance, 0, 100, 'Chance');
    }
    if (lootMode == 0) throw StateError('掉落模式不能为 0');
    if (lootMode < 0 || lootMode > 0xffff) {
      throw RangeError.range(lootMode, 1, 0xffff, 'LootMode');
    }
    if ((lootMode & ~validLootModeMask) != 0) {
      throw StateError('掉落模式包含 AzerothCore 未定义的标志位');
    }
    if (groupId < 0 || groupId >= 128) {
      throw RangeError.range(groupId, 0, 127, 'GroupId');
    }
    if (minCount < 1 || minCount > 255) {
      throw RangeError.range(minCount, 1, 255, 'MinCount');
    }
    if (maxCount < 1 || maxCount > 255) {
      throw RangeError.range(maxCount, 1, 255, 'MaxCount');
    }
    if (reference == 0) {
      if (item == 0) throw StateError('物品掉落行必须指定物品 ID');
      if (maxCount < minCount) {
        throw StateError('最大数量不能小于最小数量');
      }
    } else {
      if (questRequired) throw StateError('引用掉落行不能设置任务需求');
      if (minCount != maxCount) {
        throw StateError('引用掉落行的最小数量和最大数量必须相等');
      }
    }
    if (chance == 0 && groupId == 0) {
      throw StateError('掉落几率为 0 时必须指定掉落组');
    }
    if (chance != 0 && chance < 0.000001) {
      throw StateError('非零掉落几率不能小于 0.000001');
    }
  }

  factory LootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return LootTemplateEntity(
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

  LootTemplateEntity copyWith({
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
    return LootTemplateEntity(
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

/// 掉落模板列表展示模型（含 LEFT JOIN item_template + item_display_info 的物品信息及聚合字段）
class BriefLootTemplateEntity {
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
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;
  final int itemCount;

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;

  const BriefLootTemplateEntity({
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
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
    this.itemCount = 0,
  });

  factory BriefLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefLootTemplateEntity(
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
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
      itemCount: json['ItemCount'] ?? 0,
    );
  }
}
