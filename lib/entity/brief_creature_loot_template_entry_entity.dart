class BriefCreatureLootTemplateEntryEntity {
  final int entry;
  final int itemCount;

  const BriefCreatureLootTemplateEntryEntity({
    this.entry = 0,
    this.itemCount = 0,
  });

  factory BriefCreatureLootTemplateEntryEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefCreatureLootTemplateEntryEntity(
      entry: json['Entry'] ?? 0,
      itemCount: json['ItemCount'] ?? 0,
    );
  }

  int get key => entry;
}
