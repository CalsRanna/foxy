// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_addon_entity.dart';

mixin _CreatureTemplateAddonEntityMixin {
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
    final self = this as CreatureTemplateAddonEntity;
    return CreatureTemplateAddonEntity(
      entry: entry ?? self.entry,
      pathId: pathId ?? self.pathId,
      mount: mount ?? self.mount,
      emote: emote ?? self.emote,
      bytes1: bytes1 ?? self.bytes1,
      bytes2: bytes2 ?? self.bytes2,
      visibilityDistanceType:
          visibilityDistanceType ?? self.visibilityDistanceType,
      auras: auras ?? self.auras,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureTemplateAddonEntity;
    return {
      'entry': self.entry,
      'path_id': self.pathId,
      'mount': self.mount,
      'emote': self.emote,
      'bytes1': self.bytes1,
      'bytes2': self.bytes2,
      'visibilityDistanceType': self.visibilityDistanceType,
      'auras': self.auras,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureTemplateAddonEntity;
    return identical(self, other) ||
        other is CreatureTemplateAddonEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.pathId == other.pathId &&
            self.mount == other.mount &&
            self.emote == other.emote &&
            self.bytes1 == other.bytes1 &&
            self.bytes2 == other.bytes2 &&
            self.visibilityDistanceType == other.visibilityDistanceType &&
            self.auras == other.auras;
  }

  @override
  int get hashCode {
    final self = this as CreatureTemplateAddonEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.pathId,
      self.mount,
      self.emote,
      self.bytes1,
      self.bytes2,
      self.visibilityDistanceType,
      self.auras,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureTemplateAddonEntity;
    return 'CreatureTemplateAddonEntity('
        'entry: ${self.entry}, '
        'pathId: ${self.pathId}, '
        'mount: ${self.mount}, '
        'emote: ${self.emote}, '
        'bytes1: ${self.bytes1}, '
        'bytes2: ${self.bytes2}, '
        'visibilityDistanceType: ${self.visibilityDistanceType}, '
        'auras: ${self.auras}'
        ')';
  }
}

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
