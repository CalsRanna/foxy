class BriefItemLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefItemLootTemplateEntryEntity({this.entry = 0, this.itemCount = 0});

  factory BriefItemLootTemplateEntryEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
