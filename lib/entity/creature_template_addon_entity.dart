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

  static String normalizeAuras(String value) {
    final tokens = value.trim().isEmpty
        ? const <String>[]
        : value.trim().split(RegExp(r'\s+'));
    final spellIds = <int>[];
    final seen = <int>{};
    for (final token in tokens) {
      final spellId = int.tryParse(token);
      if (spellId == null || spellId <= 0) {
        throw FormatException('光环列表只能包含以空格分隔的正整数法术 ID');
      }
      if (!seen.add(spellId)) {
        throw FormatException('光环列表不能包含重复法术 ID: $spellId');
      }
      spellIds.add(spellId);
    }
    return spellIds.join(' ');
  }

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

/// 生物模板附加数据列表/Picker 展示模型
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

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'path_id': pathId,
      'mount': mount,
      'emote': emote,
      'auras': auras,
    };
  }
}
