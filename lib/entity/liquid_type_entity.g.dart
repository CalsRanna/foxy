// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquid_type_entity.dart';

mixin _LiquidTypeEntityMixin {
  static LiquidTypeEntity fromJson(Map<String, dynamic> json) {
    return LiquidTypeEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      soundBank: (json['SoundBank'] as num?)?.toInt() ?? 0,
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellID'] as num?)?.toInt() ?? 0,
      maxDarkenDepth: (json['MaxDarkenDepth'] as num?)?.toDouble() ?? 0.0,
      fogDarkenIntensity:
          (json['FogDarkenIntensity'] as num?)?.toDouble() ?? 0.0,
      ambDarkenIntensity:
          (json['AmbDarkenIntensity'] as num?)?.toDouble() ?? 0.0,
      dirDarkenIntensity:
          (json['DirDarkenIntensity'] as num?)?.toDouble() ?? 0.0,
      lightId: (json['LightID'] as num?)?.toInt() ?? 0,
      particleScale: (json['ParticleScale'] as num?)?.toDouble() ?? 0.0,
      particleMovement: (json['ParticleMovement'] as num?)?.toInt() ?? 0,
      particleTexSlots: (json['ParticleTexSlots'] as num?)?.toInt() ?? 0,
      materialId: (json['MaterialID'] as num?)?.toInt() ?? 0,
      texture0: json['Texture0']?.toString() ?? '',
      texture1: json['Texture1']?.toString() ?? '',
      texture2: json['Texture2']?.toString() ?? '',
      texture3: json['Texture3']?.toString() ?? '',
      texture4: json['Texture4']?.toString() ?? '',
      texture5: json['Texture5']?.toString() ?? '',
      color0: (json['Color0'] as num?)?.toInt() ?? 0,
      color1: (json['Color1'] as num?)?.toInt() ?? 0,
      float0: (json['Float0'] as num?)?.toDouble() ?? 0.0,
      float1: (json['Float1'] as num?)?.toDouble() ?? 0.0,
      float2: (json['Float2'] as num?)?.toDouble() ?? 0.0,
      float3: (json['Float3'] as num?)?.toDouble() ?? 0.0,
      float4: (json['Float4'] as num?)?.toDouble() ?? 0.0,
      float5: (json['Float5'] as num?)?.toDouble() ?? 0.0,
      float6: (json['Float6'] as num?)?.toDouble() ?? 0.0,
      float7: (json['Float7'] as num?)?.toDouble() ?? 0.0,
      float8: (json['Float8'] as num?)?.toDouble() ?? 0.0,
      float9: (json['Float9'] as num?)?.toDouble() ?? 0.0,
      float10: (json['Float10'] as num?)?.toDouble() ?? 0.0,
      float11: (json['Float11'] as num?)?.toDouble() ?? 0.0,
      float12: (json['Float12'] as num?)?.toDouble() ?? 0.0,
      float13: (json['Float13'] as num?)?.toDouble() ?? 0.0,
      float14: (json['Float14'] as num?)?.toDouble() ?? 0.0,
      float15: (json['Float15'] as num?)?.toDouble() ?? 0.0,
      float16: (json['Float16'] as num?)?.toDouble() ?? 0.0,
      float17: (json['Float17'] as num?)?.toDouble() ?? 0.0,
      int0: (json['Int0'] as num?)?.toInt() ?? 0,
      int1: (json['Int1'] as num?)?.toInt() ?? 0,
      int2: (json['Int2'] as num?)?.toInt() ?? 0,
      int3: (json['Int3'] as num?)?.toInt() ?? 0,
    );
  }

  LiquidTypeEntity copyWith({
    int? id,
    String? name,
    int? flags,
    int? soundBank,
    int? soundId,
    int? spellId,
    double? maxDarkenDepth,
    double? fogDarkenIntensity,
    double? ambDarkenIntensity,
    double? dirDarkenIntensity,
    int? lightId,
    double? particleScale,
    int? particleMovement,
    int? particleTexSlots,
    int? materialId,
    String? texture0,
    String? texture1,
    String? texture2,
    String? texture3,
    String? texture4,
    String? texture5,
    int? color0,
    int? color1,
    double? float0,
    double? float1,
    double? float2,
    double? float3,
    double? float4,
    double? float5,
    double? float6,
    double? float7,
    double? float8,
    double? float9,
    double? float10,
    double? float11,
    double? float12,
    double? float13,
    double? float14,
    double? float15,
    double? float16,
    double? float17,
    int? int0,
    int? int1,
    int? int2,
    int? int3,
  }) {
    final self = this as LiquidTypeEntity;
    return LiquidTypeEntity(
      id: id ?? self.id,
      name: name ?? self.name,
      flags: flags ?? self.flags,
      soundBank: soundBank ?? self.soundBank,
      soundId: soundId ?? self.soundId,
      spellId: spellId ?? self.spellId,
      maxDarkenDepth: maxDarkenDepth ?? self.maxDarkenDepth,
      fogDarkenIntensity: fogDarkenIntensity ?? self.fogDarkenIntensity,
      ambDarkenIntensity: ambDarkenIntensity ?? self.ambDarkenIntensity,
      dirDarkenIntensity: dirDarkenIntensity ?? self.dirDarkenIntensity,
      lightId: lightId ?? self.lightId,
      particleScale: particleScale ?? self.particleScale,
      particleMovement: particleMovement ?? self.particleMovement,
      particleTexSlots: particleTexSlots ?? self.particleTexSlots,
      materialId: materialId ?? self.materialId,
      texture0: texture0 ?? self.texture0,
      texture1: texture1 ?? self.texture1,
      texture2: texture2 ?? self.texture2,
      texture3: texture3 ?? self.texture3,
      texture4: texture4 ?? self.texture4,
      texture5: texture5 ?? self.texture5,
      color0: color0 ?? self.color0,
      color1: color1 ?? self.color1,
      float0: float0 ?? self.float0,
      float1: float1 ?? self.float1,
      float2: float2 ?? self.float2,
      float3: float3 ?? self.float3,
      float4: float4 ?? self.float4,
      float5: float5 ?? self.float5,
      float6: float6 ?? self.float6,
      float7: float7 ?? self.float7,
      float8: float8 ?? self.float8,
      float9: float9 ?? self.float9,
      float10: float10 ?? self.float10,
      float11: float11 ?? self.float11,
      float12: float12 ?? self.float12,
      float13: float13 ?? self.float13,
      float14: float14 ?? self.float14,
      float15: float15 ?? self.float15,
      float16: float16 ?? self.float16,
      float17: float17 ?? self.float17,
      int0: int0 ?? self.int0,
      int1: int1 ?? self.int1,
      int2: int2 ?? self.int2,
      int3: int3 ?? self.int3,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as LiquidTypeEntity;
    return {
      'ID': self.id,
      'Name': self.name,
      'Flags': self.flags,
      'SoundBank': self.soundBank,
      'SoundID': self.soundId,
      'SpellID': self.spellId,
      'MaxDarkenDepth': self.maxDarkenDepth,
      'FogDarkenIntensity': self.fogDarkenIntensity,
      'AmbDarkenIntensity': self.ambDarkenIntensity,
      'DirDarkenIntensity': self.dirDarkenIntensity,
      'LightID': self.lightId,
      'ParticleScale': self.particleScale,
      'ParticleMovement': self.particleMovement,
      'ParticleTexSlots': self.particleTexSlots,
      'MaterialID': self.materialId,
      'Texture0': self.texture0,
      'Texture1': self.texture1,
      'Texture2': self.texture2,
      'Texture3': self.texture3,
      'Texture4': self.texture4,
      'Texture5': self.texture5,
      'Color0': self.color0,
      'Color1': self.color1,
      'Float0': self.float0,
      'Float1': self.float1,
      'Float2': self.float2,
      'Float3': self.float3,
      'Float4': self.float4,
      'Float5': self.float5,
      'Float6': self.float6,
      'Float7': self.float7,
      'Float8': self.float8,
      'Float9': self.float9,
      'Float10': self.float10,
      'Float11': self.float11,
      'Float12': self.float12,
      'Float13': self.float13,
      'Float14': self.float14,
      'Float15': self.float15,
      'Float16': self.float16,
      'Float17': self.float17,
      'Int0': self.int0,
      'Int1': self.int1,
      'Int2': self.int2,
      'Int3': self.int3,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as LiquidTypeEntity;
    return identical(self, other) ||
        other is LiquidTypeEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.name == other.name &&
            self.flags == other.flags &&
            self.soundBank == other.soundBank &&
            self.soundId == other.soundId &&
            self.spellId == other.spellId &&
            self.maxDarkenDepth == other.maxDarkenDepth &&
            self.fogDarkenIntensity == other.fogDarkenIntensity &&
            self.ambDarkenIntensity == other.ambDarkenIntensity &&
            self.dirDarkenIntensity == other.dirDarkenIntensity &&
            self.lightId == other.lightId &&
            self.particleScale == other.particleScale &&
            self.particleMovement == other.particleMovement &&
            self.particleTexSlots == other.particleTexSlots &&
            self.materialId == other.materialId &&
            self.texture0 == other.texture0 &&
            self.texture1 == other.texture1 &&
            self.texture2 == other.texture2 &&
            self.texture3 == other.texture3 &&
            self.texture4 == other.texture4 &&
            self.texture5 == other.texture5 &&
            self.color0 == other.color0 &&
            self.color1 == other.color1 &&
            self.float0 == other.float0 &&
            self.float1 == other.float1 &&
            self.float2 == other.float2 &&
            self.float3 == other.float3 &&
            self.float4 == other.float4 &&
            self.float5 == other.float5 &&
            self.float6 == other.float6 &&
            self.float7 == other.float7 &&
            self.float8 == other.float8 &&
            self.float9 == other.float9 &&
            self.float10 == other.float10 &&
            self.float11 == other.float11 &&
            self.float12 == other.float12 &&
            self.float13 == other.float13 &&
            self.float14 == other.float14 &&
            self.float15 == other.float15 &&
            self.float16 == other.float16 &&
            self.float17 == other.float17 &&
            self.int0 == other.int0 &&
            self.int1 == other.int1 &&
            self.int2 == other.int2 &&
            self.int3 == other.int3;
  }

  @override
  int get hashCode {
    final self = this as LiquidTypeEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.name,
      self.flags,
      self.soundBank,
      self.soundId,
      self.spellId,
      self.maxDarkenDepth,
      self.fogDarkenIntensity,
      self.ambDarkenIntensity,
      self.dirDarkenIntensity,
      self.lightId,
      self.particleScale,
      self.particleMovement,
      self.particleTexSlots,
      self.materialId,
      self.texture0,
      self.texture1,
      self.texture2,
      self.texture3,
      self.texture4,
      self.texture5,
      self.color0,
      self.color1,
      self.float0,
      self.float1,
      self.float2,
      self.float3,
      self.float4,
      self.float5,
      self.float6,
      self.float7,
      self.float8,
      self.float9,
      self.float10,
      self.float11,
      self.float12,
      self.float13,
      self.float14,
      self.float15,
      self.float16,
      self.float17,
      self.int0,
      self.int1,
      self.int2,
      self.int3,
    ]);
  }

  @override
  String toString() {
    final self = this as LiquidTypeEntity;
    return 'LiquidTypeEntity('
        'id: ${self.id}, '
        'name: ${self.name}, '
        'flags: ${self.flags}, '
        'soundBank: ${self.soundBank}, '
        'soundId: ${self.soundId}, '
        'spellId: ${self.spellId}, '
        'maxDarkenDepth: ${self.maxDarkenDepth}, '
        'fogDarkenIntensity: ${self.fogDarkenIntensity}, '
        'ambDarkenIntensity: ${self.ambDarkenIntensity}, '
        'dirDarkenIntensity: ${self.dirDarkenIntensity}, '
        'lightId: ${self.lightId}, '
        'particleScale: ${self.particleScale}, '
        'particleMovement: ${self.particleMovement}, '
        'particleTexSlots: ${self.particleTexSlots}, '
        'materialId: ${self.materialId}, '
        'texture0: ${self.texture0}, '
        'texture1: ${self.texture1}, '
        'texture2: ${self.texture2}, '
        'texture3: ${self.texture3}, '
        'texture4: ${self.texture4}, '
        'texture5: ${self.texture5}, '
        'color0: ${self.color0}, '
        'color1: ${self.color1}, '
        'float0: ${self.float0}, '
        'float1: ${self.float1}, '
        'float2: ${self.float2}, '
        'float3: ${self.float3}, '
        'float4: ${self.float4}, '
        'float5: ${self.float5}, '
        'float6: ${self.float6}, '
        'float7: ${self.float7}, '
        'float8: ${self.float8}, '
        'float9: ${self.float9}, '
        'float10: ${self.float10}, '
        'float11: ${self.float11}, '
        'float12: ${self.float12}, '
        'float13: ${self.float13}, '
        'float14: ${self.float14}, '
        'float15: ${self.float15}, '
        'float16: ${self.float16}, '
        'float17: ${self.float17}, '
        'int0: ${self.int0}, '
        'int1: ${self.int1}, '
        'int2: ${self.int2}, '
        'int3: ${self.int3}'
        ')';
  }
}

final class BriefLiquidTypeEntity {
  final int id;
  final String name;
  final int flags;
  final int soundBank;
  final int spellId;

  const BriefLiquidTypeEntity({
    this.id = 0,
    this.name = '',
    this.flags = 0,
    this.soundBank = 0,
    this.spellId = 0,
  });

  factory BriefLiquidTypeEntity.fromJson(Map<String, dynamic> json) {
    return BriefLiquidTypeEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      name: json['Name']?.toString() ?? '',
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      soundBank: (json['SoundBank'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellID'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
