class BriefProspectingLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefProspectingLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefProspectingLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefProspectingLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
