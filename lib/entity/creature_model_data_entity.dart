import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_model_data_entity.g.dart';

/// DBC 生物模型数据 — 对应 foxy.dbc_creature_model_data 表。

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_creature_model_data')
class CreatureModelDataEntity with _CreatureModelDataEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Flags')
  final int flags;

  @FoxyBriefField()
  @FoxyFullField('ModelName')
  final String modelName;

  @FoxyBriefField()
  @FoxyFullField('SizeClass')
  final int sizeClass;

  @FoxyBriefField()
  @FoxyFullField('ModelScale')
  final double modelScale;

  @FoxyFullField('BloodID')
  final int bloodId;

  @FoxyFullField('FootprintTextureID')
  final int footprintTextureId;

  @FoxyFullField('FootprintTextureLength')
  final double footprintTextureLength;

  @FoxyFullField('FootprintTextureWidth')
  final double footprintTextureWidth;

  @FoxyFullField('FootprintParticleScale')
  final double footprintParticleScale;

  @FoxyFullField('FoleyMaterialID')
  final int foleyMaterialId;

  @FoxyFullField('FootstepShakeSize')
  final int footstepShakeSize;

  @FoxyFullField('DeathThudShakeSize')
  final int deathThudShakeSize;

  @FoxyFullField('SoundID')
  final int soundId;

  @FoxyFullField('CollisionWidth')
  final double collisionWidth;

  @FoxyFullField('CollisionHeight')
  final double collisionHeight;

  @FoxyFullField('MountHeight')
  final double mountHeight;

  @FoxyFullField('GeoBoxMinX')
  final double geoBoxMinX;

  @FoxyFullField('GeoBoxMinY')
  final double geoBoxMinY;

  @FoxyFullField('GeoBoxMinZ')
  final double geoBoxMinZ;

  @FoxyFullField('GeoBoxMaxX')
  final double geoBoxMaxX;

  @FoxyFullField('GeoBoxMaxY')
  final double geoBoxMaxY;

  @FoxyFullField('GeoBoxMaxZ')
  final double geoBoxMaxZ;

  @FoxyFullField('WorldEffectScale')
  final double worldEffectScale;

  @FoxyFullField('AttachedEffectScale')
  final double attachedEffectScale;

  @FoxyFullField('MissileCollisionRadius')
  final double missileCollisionRadius;

  @FoxyFullField('MissileCollisionPush')
  final double missileCollisionPush;

  @FoxyFullField('MissileCollisionRaise')
  final double missileCollisionRaise;

  const CreatureModelDataEntity({
    this.id = 0,
    this.flags = 0,
    this.modelName = '',
    this.sizeClass = 0,
    this.modelScale = 0,
    this.bloodId = 0,
    this.footprintTextureId = 0,
    this.footprintTextureLength = 0,
    this.footprintTextureWidth = 0,
    this.footprintParticleScale = 0,
    this.foleyMaterialId = 0,
    this.footstepShakeSize = 0,
    this.deathThudShakeSize = 0,
    this.soundId = 0,
    this.collisionWidth = 0,
    this.collisionHeight = 0,
    this.mountHeight = 0,
    this.geoBoxMinX = 0,
    this.geoBoxMinY = 0,
    this.geoBoxMinZ = 0,
    this.geoBoxMaxX = 0,
    this.geoBoxMaxY = 0,
    this.geoBoxMaxZ = 0,
    this.worldEffectScale = 0,
    this.attachedEffectScale = 0,
    this.missileCollisionRadius = 0,
    this.missileCollisionPush = 0,
    this.missileCollisionRaise = 0,
  });

  factory CreatureModelDataEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureModelDataEntityMixin.fromJson(json);
}
