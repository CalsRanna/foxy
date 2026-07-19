class BriefCreatureTemplateAddonEntity {
  final int entry;
  final int pathId;
  final int mount;
  final int emote;
  final String auras;

  const BriefCreatureTemplateAddonEntity({
    this.entry = 0,
    this.pathId = 0,
    this.mount = 0,
    this.emote = 0,
    this.auras = '',
  });

  factory BriefCreatureTemplateAddonEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureTemplateAddonEntity(
      entry: json['entry'] ?? 0,
      pathId: json['path_id'] ?? 0,
      mount: json['mount'] ?? 0,
      emote: json['emote'] ?? 0,
      auras: json['auras'] ?? '',
    );
  }

  int get key => entry;
}
