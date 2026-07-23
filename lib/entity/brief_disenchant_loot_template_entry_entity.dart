class BriefDisenchantLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefDisenchantLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefDisenchantLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefDisenchantLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
