import 'package:foxy/entity/spell_loot_template_key.dart';

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
      chance: (json['Chance'] as num?)?.toDouble() ?? 100,
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

  String get displayName => localeName.isNotEmpty ? localeName : itemName;

  SpellLootTemplateKey get key =>
      SpellLootTemplateKey(entry: entry, item: item);
}
