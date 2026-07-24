import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_display_info_entity.g.dart';

/// 生物显示信息 — 对应 foxy.dbc_creature_display_info 表

@FoxyBriefEntity()
@FoxyBriefField.text('modelName')
@FoxyFullEntity(table: 'foxy.dbc_creature_display_info')
class CreatureDisplayInfoEntity with _CreatureDisplayInfoEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('ModelID')
  final int modelId;

  @FoxyFullField('SoundID')
  final int soundId;

  @FoxyFullField('ExtendedDisplayInfoID')
  final int extendedDisplayInfoId;

  @FoxyBriefField()
  @FoxyFullField('CreatureModelScale')
  final double creatureModelScale;

  @FoxyFullField('CreatureModelAlpha')
  final int creatureModelAlpha;

  @FoxyFullField('TextureVariation0')
  final String textureVariation0;

  @FoxyFullField('TextureVariation1')
  final String textureVariation1;

  @FoxyFullField('TextureVariation2')
  final String textureVariation2;

  @FoxyFullField('PortraitTextureName')
  final String portraitTextureName;

  @FoxyBriefField()
  @FoxyFullField('SizeClass')
  final int sizeClass;

  @FoxyBriefField()
  @FoxyFullField('BloodID')
  final int bloodID;

  @FoxyFullField('NPCSoundID')
  final int npcSoundID;

  @FoxyFullField('ParticleColorID')
  final int particleColorID;

  @FoxyFullField('CreatureGeosetData')
  final int creatureGeosetData;

  @FoxyFullField('ObjectEffectPackageID')
  final int objectEffectPackageID;

  const CreatureDisplayInfoEntity({
    this.id = 0,
    this.modelId = 0,
    this.soundId = 0,
    this.extendedDisplayInfoId = 0,
    this.creatureModelScale = 1.0,
    this.creatureModelAlpha = 0,
    this.textureVariation0 = '',
    this.textureVariation1 = '',
    this.textureVariation2 = '',
    this.portraitTextureName = '',
    this.sizeClass = 0,
    this.bloodID = 0,
    this.npcSoundID = 0,
    this.particleColorID = 0,
    this.creatureGeosetData = 0,
    this.objectEffectPackageID = 0,
  });

  factory CreatureDisplayInfoEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureDisplayInfoEntityMixin.fromJson(json);
}
