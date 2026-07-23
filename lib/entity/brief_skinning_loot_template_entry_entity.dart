class BriefSkinningLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefSkinningLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefSkinningLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefSkinningLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
