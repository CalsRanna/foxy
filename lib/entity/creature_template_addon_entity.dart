/// 生物模板附加数据
class CreatureTemplateAddonEntity {
  final int entry;
  final int pathId;
  final int mount;
  final int emote;
  final int bytes1;
  final int bytes2;
  final int visibilityDistanceType;
  final String auras;

  const CreatureTemplateAddonEntity({
    this.entry = 0,
    this.pathId = 0,
    this.mount = 0,
    this.emote = 0,
    this.bytes1 = 0,
    this.bytes2 = 0,
    this.visibilityDistanceType = 0,
    this.auras = '',
  });

  factory CreatureTemplateAddonEntity.fromJson(Map<String, dynamic> json) {
    return CreatureTemplateAddonEntity(
      entry: json['entry'] ?? 0,
      pathId: json['path_id'] ?? 0,
      mount: json['mount'] ?? 0,
      emote: json['emote'] ?? 0,
      bytes1: json['bytes1'] ?? 0,
      bytes2: json['bytes2'] ?? 0,
      visibilityDistanceType: json['visibilityDistanceType'] ?? 0,
      auras: json['auras'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'path_id': pathId,
      'mount': mount,
      'emote': emote,
      'bytes1': bytes1,
      'bytes2': bytes2,
      'visibilityDistanceType': visibilityDistanceType,
      'auras': auras,
    };
  }

  CreatureTemplateAddonEntity copyWith({
    int? entry,
    int? pathId,
    int? mount,
    int? emote,
    int? bytes1,
    int? bytes2,
    int? visibilityDistanceType,
    String? auras,
  }) {
    return CreatureTemplateAddonEntity(
      entry: entry ?? this.entry,
      pathId: pathId ?? this.pathId,
      mount: mount ?? this.mount,
      emote: emote ?? this.emote,
      bytes1: bytes1 ?? this.bytes1,
      bytes2: bytes2 ?? this.bytes2,
      visibilityDistanceType:
          visibilityDistanceType ?? this.visibilityDistanceType,
      auras: auras ?? this.auras,
    );
  }
}
