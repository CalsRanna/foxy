class BriefGameObjectLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefGameObjectLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefGameObjectLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefGameObjectLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
