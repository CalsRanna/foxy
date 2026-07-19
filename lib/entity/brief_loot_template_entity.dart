import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_key.dart';

/// 掉落模板行列表展示模型。
class BriefLootTemplateEntity {
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
  final LootTemplateKey key;

  const BriefLootTemplateEntity({
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
    required this.key,
  });

  factory BriefLootTemplateEntity.fromJson(
    Map<String, dynamic> json, {
    required LootTableType tableType,
  }) {
    final entry = json['Entry'] ?? 0;
    final item = json['Item'] ?? 0;
    final reference = json['Reference'] ?? 0;
    final groupId = json['GroupId'] ?? 0;
    return BriefLootTemplateEntity(
      entry: entry,
      item: item,
      reference: reference,
      chance: (json['Chance'] as num?)?.toDouble() ?? 100,
      questRequired: (json['QuestRequired'] ?? 0) == 1,
      groupId: groupId,
      minCount: json['MinCount'] ?? 1,
      maxCount: json['MaxCount'] ?? 1,
      itemName: json['name'] ?? '',
      itemLocaleName: json['localeName'] ?? '',
      itemQuality: json['Quality'] ?? 0,
      itemIcon: json['InventoryIcon0'] ?? '',
      key: LootTemplateKey.fromValues(
        tableType,
        entry: entry,
        item: item,
        reference: reference,
        groupId: groupId,
      ),
    );
  }

  String get displayName =>
      itemLocaleName.isNotEmpty ? itemLocaleName : itemName;
}
