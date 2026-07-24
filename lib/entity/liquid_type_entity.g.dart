// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquid_type_entity.dart';

mixin _LiquidTypeEntityMixin {
  int get id;
  String get name;
  int get flags;
  int get soundBank;
  int get soundId;
  int get spellId;
  double get maxDarkenDepth;
  double get fogDarkenIntensity;
  double get ambDarkenIntensity;
  double get dirDarkenIntensity;
  int get lightId;
  double get particleScale;
  int get particleMovement;
  int get particleTexSlots;
  int get materialId;
  String get texture0;
  String get texture1;
  String get texture2;
  String get texture3;
  String get texture4;
  String get texture5;
  int get color0;
  int get color1;
  double get float0;
  double get float1;
  double get float2;
  double get float3;
  double get float4;
  double get float5;
  double get float6;
  double get float7;
  double get float8;
  double get float9;
  double get float10;
  double get float11;
  double get float12;
  double get float13;
  double get float14;
  double get float15;
  double get float16;
  double get float17;
  int get int0;
  int get int1;
  int get int2;
  int get int3;

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
    return LiquidTypeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      flags: flags ?? this.flags,
      soundBank: soundBank ?? this.soundBank,
      soundId: soundId ?? this.soundId,
      spellId: spellId ?? this.spellId,
      maxDarkenDepth: maxDarkenDepth ?? this.maxDarkenDepth,
      fogDarkenIntensity: fogDarkenIntensity ?? this.fogDarkenIntensity,
      ambDarkenIntensity: ambDarkenIntensity ?? this.ambDarkenIntensity,
      dirDarkenIntensity: dirDarkenIntensity ?? this.dirDarkenIntensity,
      lightId: lightId ?? this.lightId,
      particleScale: particleScale ?? this.particleScale,
      particleMovement: particleMovement ?? this.particleMovement,
      particleTexSlots: particleTexSlots ?? this.particleTexSlots,
      materialId: materialId ?? this.materialId,
      texture0: texture0 ?? this.texture0,
      texture1: texture1 ?? this.texture1,
      texture2: texture2 ?? this.texture2,
      texture3: texture3 ?? this.texture3,
      texture4: texture4 ?? this.texture4,
      texture5: texture5 ?? this.texture5,
      color0: color0 ?? this.color0,
      color1: color1 ?? this.color1,
      float0: float0 ?? this.float0,
      float1: float1 ?? this.float1,
      float2: float2 ?? this.float2,
      float3: float3 ?? this.float3,
      float4: float4 ?? this.float4,
      float5: float5 ?? this.float5,
      float6: float6 ?? this.float6,
      float7: float7 ?? this.float7,
      float8: float8 ?? this.float8,
      float9: float9 ?? this.float9,
      float10: float10 ?? this.float10,
      float11: float11 ?? this.float11,
      float12: float12 ?? this.float12,
      float13: float13 ?? this.float13,
      float14: float14 ?? this.float14,
      float15: float15 ?? this.float15,
      float16: float16 ?? this.float16,
      float17: float17 ?? this.float17,
      int0: int0 ?? this.int0,
      int1: int1 ?? this.int1,
      int2: int2 ?? this.int2,
      int3: int3 ?? this.int3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Flags': flags,
      'SoundBank': soundBank,
      'SoundID': soundId,
      'SpellID': spellId,
      'MaxDarkenDepth': maxDarkenDepth,
      'FogDarkenIntensity': fogDarkenIntensity,
      'AmbDarkenIntensity': ambDarkenIntensity,
      'DirDarkenIntensity': dirDarkenIntensity,
      'LightID': lightId,
      'ParticleScale': particleScale,
      'ParticleMovement': particleMovement,
      'ParticleTexSlots': particleTexSlots,
      'MaterialID': materialId,
      'Texture0': texture0,
      'Texture1': texture1,
      'Texture2': texture2,
      'Texture3': texture3,
      'Texture4': texture4,
      'Texture5': texture5,
      'Color0': color0,
      'Color1': color1,
      'Float0': float0,
      'Float1': float1,
      'Float2': float2,
      'Float3': float3,
      'Float4': float4,
      'Float5': float5,
      'Float6': float6,
      'Float7': float7,
      'Float8': float8,
      'Float9': float9,
      'Float10': float10,
      'Float11': float11,
      'Float12': float12,
      'Float13': float13,
      'Float14': float14,
      'Float15': float15,
      'Float16': float16,
      'Float17': float17,
      'Int0': int0,
      'Int1': int1,
      'Int2': int2,
      'Int3': int3,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiquidTypeEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            flags == other.flags &&
            soundBank == other.soundBank &&
            soundId == other.soundId &&
            spellId == other.spellId &&
            maxDarkenDepth == other.maxDarkenDepth &&
            fogDarkenIntensity == other.fogDarkenIntensity &&
            ambDarkenIntensity == other.ambDarkenIntensity &&
            dirDarkenIntensity == other.dirDarkenIntensity &&
            lightId == other.lightId &&
            particleScale == other.particleScale &&
            particleMovement == other.particleMovement &&
            particleTexSlots == other.particleTexSlots &&
            materialId == other.materialId &&
            texture0 == other.texture0 &&
            texture1 == other.texture1 &&
            texture2 == other.texture2 &&
            texture3 == other.texture3 &&
            texture4 == other.texture4 &&
            texture5 == other.texture5 &&
            color0 == other.color0 &&
            color1 == other.color1 &&
            float0 == other.float0 &&
            float1 == other.float1 &&
            float2 == other.float2 &&
            float3 == other.float3 &&
            float4 == other.float4 &&
            float5 == other.float5 &&
            float6 == other.float6 &&
            float7 == other.float7 &&
            float8 == other.float8 &&
            float9 == other.float9 &&
            float10 == other.float10 &&
            float11 == other.float11 &&
            float12 == other.float12 &&
            float13 == other.float13 &&
            float14 == other.float14 &&
            float15 == other.float15 &&
            float16 == other.float16 &&
            float17 == other.float17 &&
            int0 == other.int0 &&
            int1 == other.int1 &&
            int2 == other.int2 &&
            int3 == other.int3;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      name,
      flags,
      soundBank,
      soundId,
      spellId,
      maxDarkenDepth,
      fogDarkenIntensity,
      ambDarkenIntensity,
      dirDarkenIntensity,
      lightId,
      particleScale,
      particleMovement,
      particleTexSlots,
      materialId,
      texture0,
      texture1,
      texture2,
      texture3,
      texture4,
      texture5,
      color0,
      color1,
      float0,
      float1,
      float2,
      float3,
      float4,
      float5,
      float6,
      float7,
      float8,
      float9,
      float10,
      float11,
      float12,
      float13,
      float14,
      float15,
      float16,
      float17,
      int0,
      int1,
      int2,
      int3,
    ]);
  }

  @override
  String toString() {
    return 'LiquidTypeEntity('
        'id: $id, '
        'name: $name, '
        'flags: $flags, '
        'soundBank: $soundBank, '
        'soundId: $soundId, '
        'spellId: $spellId, '
        'maxDarkenDepth: $maxDarkenDepth, '
        'fogDarkenIntensity: $fogDarkenIntensity, '
        'ambDarkenIntensity: $ambDarkenIntensity, '
        'dirDarkenIntensity: $dirDarkenIntensity, '
        'lightId: $lightId, '
        'particleScale: $particleScale, '
        'particleMovement: $particleMovement, '
        'particleTexSlots: $particleTexSlots, '
        'materialId: $materialId, '
        'texture0: $texture0, '
        'texture1: $texture1, '
        'texture2: $texture2, '
        'texture3: $texture3, '
        'texture4: $texture4, '
        'texture5: $texture5, '
        'color0: $color0, '
        'color1: $color1, '
        'float0: $float0, '
        'float1: $float1, '
        'float2: $float2, '
        'float3: $float3, '
        'float4: $float4, '
        'float5: $float5, '
        'float6: $float6, '
        'float7: $float7, '
        'float8: $float8, '
        'float9: $float9, '
        'float10: $float10, '
        'float11: $float11, '
        'float12: $float12, '
        'float13: $float13, '
        'float14: $float14, '
        'float15: $float15, '
        'float16: $float16, '
        'float17: $float17, '
        'int0: $int0, '
        'int1: $int1, '
        'int2: $int2, '
        'int3: $int3'
        ')';
  }
}
