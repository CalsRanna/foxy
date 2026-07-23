class BriefPickpocketingLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefPickpocketingLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefPickpocketingLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefPickpocketingLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
