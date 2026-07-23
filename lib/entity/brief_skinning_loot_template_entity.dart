import 'package:foxy/entity/skinning_loot_template_key.dart';

class BriefSkinningLootTemplateEntity {
  final int entry;
  final int item;
  final int reference;
  final double chance;
  final bool questRequired;
  final int groupId;
  final int minCount;
  final int maxCount;
  final String itemName;
  final String itemLocaleName;
  final int itemQuality;
  final String itemIcon;

  const BriefSkinningLootTemplateEntity({
    this.entry = 0,
    this.item = 0,
    this.reference = 0,
    this.chance = 100,
    this.questRequired = false,
    this.groupId = 0,
    this.minCount = 1,
    this.maxCount = 1,
    this.itemName = '',
    this.itemLocaleName = '',
    this.itemQuality = 0,
    this.itemIcon = '',
  });

  factory BriefSkinningLootTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefSkinningLootTemplateEntity(
      entry: json['Entry'] ?? 0,
      item: json['Item'] ?? 0,
      reference: json['Reference'] ?? 0,
      chance: (json['Chance'] as num?)?.toDouble() ?? 100,
      questRequired: (json['QuestRequired'] ?? 0) == 1,
      groupId: json['GroupId'] ?? 0,
      minCount: json['MinCount'] ?? 1,
      maxCount: json['MaxCount'] ?? 1,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
    );
  }

  SkinningLootTemplateKey get key =>
      SkinningLootTemplateKey(entry: entry, item: item);

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;
}
