class BriefMillingLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefMillingLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefMillingLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefMillingLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
