/// 掉落模板 Entry 聚合列表展示模型。
class BriefLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefLootTemplateEntryEntity({this.entry = 0, this.itemCount = 0});

  factory BriefLootTemplateEntryEntity.fromJson(Map<String, dynamic> json) {
    return BriefLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }
}
