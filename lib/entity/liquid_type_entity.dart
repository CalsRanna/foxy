// ignore_for_file: annotate_overrides

import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'liquid_type_entity.g.dart';

@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_liquid_type')
class LiquidTypeEntity with _LiquidTypeEntityMixin {
  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('Name')
  final String name;

  @FoxyBriefField()
  @FoxyFullField('Flags')
  final int flags;

  @FoxyBriefField()
  @FoxyFullField('SoundBank')
  final int soundBank;

  @FoxyFullField('SoundID')
  final int soundId;

  @FoxyBriefField()
  @FoxyFullField('SpellID')
  final int spellId;

  @FoxyFullField('MaxDarkenDepth')
  final double maxDarkenDepth;

  @FoxyFullField('FogDarkenIntensity')
  final double fogDarkenIntensity;

  @FoxyFullField('AmbDarkenIntensity')
  final double ambDarkenIntensity;

  @FoxyFullField('DirDarkenIntensity')
  final double dirDarkenIntensity;

  @FoxyFullField('LightID')
  final int lightId;

  @FoxyFullField('ParticleScale')
  final double particleScale;

  @FoxyFullField('ParticleMovement')
  final int particleMovement;

  @FoxyFullField('ParticleTexSlots')
  final int particleTexSlots;

  @FoxyFullField('MaterialID')
  final int materialId;

  @FoxyFullField('Texture0')
  final String texture0;

  @FoxyFullField('Texture1')
  final String texture1;

  @FoxyFullField('Texture2')
  final String texture2;

  @FoxyFullField('Texture3')
  final String texture3;

  @FoxyFullField('Texture4')
  final String texture4;

  @FoxyFullField('Texture5')
  final String texture5;

  @FoxyFullField('Color0')
  final int color0;

  @FoxyFullField('Color1')
  final int color1;

  @FoxyFullField('Float0')
  final double float0;

  @FoxyFullField('Float1')
  final double float1;

  @FoxyFullField('Float2')
  final double float2;

  @FoxyFullField('Float3')
  final double float3;

  @FoxyFullField('Float4')
  final double float4;

  @FoxyFullField('Float5')
  final double float5;

  @FoxyFullField('Float6')
  final double float6;

  @FoxyFullField('Float7')
  final double float7;

  @FoxyFullField('Float8')
  final double float8;

  @FoxyFullField('Float9')
  final double float9;

  @FoxyFullField('Float10')
  final double float10;

  @FoxyFullField('Float11')
  final double float11;

  @FoxyFullField('Float12')
  final double float12;

  @FoxyFullField('Float13')
  final double float13;

  @FoxyFullField('Float14')
  final double float14;

  @FoxyFullField('Float15')
  final double float15;

  @FoxyFullField('Float16')
  final double float16;

  @FoxyFullField('Float17')
  final double float17;

  @FoxyFullField('Int0')
  final int int0;

  @FoxyFullField('Int1')
  final int int1;

  @FoxyFullField('Int2')
  final int int2;

  @FoxyFullField('Int3')
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

  factory LiquidTypeEntity.fromJson(Map<String, dynamic> json) =>
      _LiquidTypeEntityMixin.fromJson(json);
}
