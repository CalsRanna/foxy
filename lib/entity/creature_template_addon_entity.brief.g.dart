// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefCreatureTemplateAddonEntity {
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
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      pathId: (json['path_id'] as num?)?.toInt() ?? 0,
      mount: (json['mount'] as num?)?.toInt() ?? 0,
      emote: (json['emote'] as num?)?.toInt() ?? 0,
      auras: json['auras']?.toString() ?? '',
    );
  }

  int get key => entry;
}
