class BriefLiquidTypeEntity {
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

  factory BriefLiquidTypeEntity.fromJson(Map<String, dynamic> json) =>
      BriefLiquidTypeEntity(
        id: json['ID'] ?? 0,
        name: json['Name'] ?? '',
        flags: json['Flags'] ?? 0,
        soundBank: json['SoundBank'] ?? 0,
        spellId: json['SpellID'] ?? 0,
      );
}

class LiquidTypeEntity {
  final int id;
  final String name;
  final int flags;
  final int soundBank;
  final int soundId;
  final int spellId;
  final double maxDarkenDepth;
  final double fogDarkenIntensity;
  final double ambDarkenIntensity;
  final double dirDarkenIntensity;
  final int lightId;
  final double particleScale;
  final int particleMovement;
  final int particleTexSlots;
  final int materialId;
  final String texture0;
  final String texture1;
  final String texture2;
  final String texture3;
  final String texture4;
  final String texture5;
  final int color0;
  final int color1;
  final double float0;
  final double float1;
  final double float2;
  final double float3;
  final double float4;
  final double float5;
  final double float6;
  final double float7;
  final double float8;
  final double float9;
  final double float10;
  final double float11;
  final double float12;
  final double float13;
  final double float14;
  final double float15;
  final double float16;
  final double float17;
  final int int0;
  final int int1;
  final int int2;
  final int int3;

  const LiquidTypeEntity({
    this.id = 0,
    this.name = '',
    this.flags = 0,
    this.soundBank = 0,
    this.soundId = 0,
    this.spellId = 0,
    this.maxDarkenDepth = 0.0,
    this.fogDarkenIntensity = 0.0,
    this.ambDarkenIntensity = 0.0,
    this.dirDarkenIntensity = 0.0,
    this.lightId = 0,
    this.particleScale = 0.0,
    this.particleMovement = 0,
    this.particleTexSlots = 0,
    this.materialId = 0,
    this.texture0 = '',
    this.texture1 = '',
    this.texture2 = '',
    this.texture3 = '',
    this.texture4 = '',
    this.texture5 = '',
    this.color0 = 0,
    this.color1 = 0,
    this.float0 = 0.0,
    this.float1 = 0.0,
    this.float2 = 0.0,
    this.float3 = 0.0,
    this.float4 = 0.0,
    this.float5 = 0.0,
    this.float6 = 0.0,
    this.float7 = 0.0,
    this.float8 = 0.0,
    this.float9 = 0.0,
    this.float10 = 0.0,
    this.float11 = 0.0,
    this.float12 = 0.0,
    this.float13 = 0.0,
    this.float14 = 0.0,
    this.float15 = 0.0,
    this.float16 = 0.0,
    this.float17 = 0.0,
    this.int0 = 0,
    this.int1 = 0,
    this.int2 = 0,
    this.int3 = 0,
  });

  factory LiquidTypeEntity.fromJson(
    Map<String, dynamic> json,
  ) => LiquidTypeEntity(
    id: json['ID'] ?? 0,
    name: json['Name'] ?? '',
    flags: json['Flags'] ?? 0,
    soundBank: json['SoundBank'] ?? 0,
    soundId: json['SoundID'] ?? 0,
    spellId: json['SpellID'] ?? 0,
    maxDarkenDepth: (json['MaxDarkenDepth'] as num?)?.toDouble() ?? 0.0,
    fogDarkenIntensity: (json['FogDarkenIntensity'] as num?)?.toDouble() ?? 0.0,
    ambDarkenIntensity: (json['AmbDarkenIntensity'] as num?)?.toDouble() ?? 0.0,
    dirDarkenIntensity: (json['DirDarkenIntensity'] as num?)?.toDouble() ?? 0.0,
    lightId: json['LightID'] ?? 0,
    particleScale: (json['ParticleScale'] as num?)?.toDouble() ?? 0.0,
    particleMovement: json['ParticleMovement'] ?? 0,
    particleTexSlots: json['ParticleTexSlots'] ?? 0,
    materialId: json['MaterialID'] ?? 0,
    texture0: json['Texture0'] ?? '',
    texture1: json['Texture1'] ?? '',
    texture2: json['Texture2'] ?? '',
    texture3: json['Texture3'] ?? '',
    texture4: json['Texture4'] ?? '',
    texture5: json['Texture5'] ?? '',
    color0: json['Color0'] ?? 0,
    color1: json['Color1'] ?? 0,
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
    int0: json['Int0'] ?? 0,
    int1: json['Int1'] ?? 0,
    int2: json['Int2'] ?? 0,
    int3: json['Int3'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
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
