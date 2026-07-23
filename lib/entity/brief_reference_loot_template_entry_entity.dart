class BriefReferenceLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefReferenceLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefReferenceLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefReferenceLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
