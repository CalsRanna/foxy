import 'package:foxy/entity/loot_table_type.dart';
import 'package:foxy/entity/loot_template_entry_key.dart';

/// 掉落模板 Entry 聚合列表展示模型。
class BriefLootTemplateEntryEntity {
  final int entry;
  final int itemCount;
  final LootTemplateEntryKey key;

  const BriefLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
    required this.key,
  });

  factory BriefLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json, {
    required LootTableType tableType,
  }) {
    final entry = json['Entry'] ?? 0;
    return BriefLootTemplateEntryEntity(
      entry: entry,
      itemCount: json['ItemCount'] ?? 0,
      key: LootTemplateEntryKey(tableType: tableType, entry: entry),
    );
  }
}
