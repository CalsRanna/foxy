// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_addon_entity.dart';

mixin _CreatureTemplateAddonEntityMixin {
  int get entry;
  int get pathId;
  int get mount;
  int get emote;
  int get bytes1;
  int get bytes2;
  int get visibilityDistanceType;
  String get auras;

  static CreatureTemplateAddonEntity fromJson(Map<String, dynamic> json) {
    return CreatureTemplateAddonEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      pathId: (json['path_id'] as num?)?.toInt() ?? 0,
      mount: (json['mount'] as num?)?.toInt() ?? 0,
      emote: (json['emote'] as num?)?.toInt() ?? 0,
      bytes1: (json['bytes1'] as num?)?.toInt() ?? 0,
      bytes2: (json['bytes2'] as num?)?.toInt() ?? 0,
      visibilityDistanceType:
          (json['visibilityDistanceType'] as num?)?.toInt() ?? 0,
      auras: json['auras']?.toString() ?? '',
    );
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureTemplateAddonEntity &&
            runtimeType == other.runtimeType &&
            entry == other.entry &&
            pathId == other.pathId &&
            mount == other.mount &&
            emote == other.emote &&
            bytes1 == other.bytes1 &&
            bytes2 == other.bytes2 &&
            visibilityDistanceType == other.visibilityDistanceType &&
            auras == other.auras;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      entry,
      pathId,
      mount,
      emote,
      bytes1,
      bytes2,
      visibilityDistanceType,
      auras,
    ]);
  }

  @override
  String toString() {
    return 'CreatureTemplateAddonEntity('
        'entry: $entry, '
        'pathId: $pathId, '
        'mount: $mount, '
        'emote: $emote, '
        'bytes1: $bytes1, '
        'bytes2: $bytes2, '
        'visibilityDistanceType: $visibilityDistanceType, '
        'auras: $auras'
        ')';
  }
}
