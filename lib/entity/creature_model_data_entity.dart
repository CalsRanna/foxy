class BriefCreatureModelDataEntity {
  final int id;
  final String modelName;
  final int sizeClass;
  final double modelScale;

  const BriefCreatureModelDataEntity({
    this.id = 0,
    this.modelName = '',
    this.sizeClass = 0,
    this.modelScale = 0,
  });

  factory BriefCreatureModelDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureModelDataEntity(
      id: json['ID'] ?? 0,
      modelName: json['ModelName'] ?? '',
      sizeClass: json['SizeClass'] ?? 0,
      modelScale: (json['ModelScale'] as num?)?.toDouble() ?? 0,
    );
  }
}

/// DBC 生物模型数据 — 对应 foxy.dbc_creature_model_data 表。
class CreatureModelDataEntity {
  final int id;
  final int flags;
  final String modelName;
  final int sizeClass;
  final double modelScale;
  final int bloodId;
  final int footprintTextureId;
  final double footprintTextureLength;
  final double footprintTextureWidth;
  final double footprintParticleScale;
  final int foleyMaterialId;
  final int footstepShakeSize;
  final int deathThudShakeSize;
  final int soundId;
  final double collisionWidth;
  final double collisionHeight;
  final double mountHeight;
  final double geoBoxMinX;
  final double geoBoxMinY;
  final double geoBoxMinZ;
  final double geoBoxMaxX;
  final double geoBoxMaxY;
  final double geoBoxMaxZ;
  final double worldEffectScale;
  final double attachedEffectScale;
  final double missileCollisionRadius;
  final double missileCollisionPush;
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

  factory CreatureModelDataEntity.fromJson(Map<String, dynamic> json) {
    double number(String key) => (json[key] as num?)?.toDouble() ?? 0;

    return CreatureModelDataEntity(
      id: json['ID'] ?? 0,
      flags: json['Flags'] ?? 0,
      modelName: json['ModelName'] ?? '',
      sizeClass: json['SizeClass'] ?? 0,
      modelScale: number('ModelScale'),
      bloodId: json['BloodID'] ?? 0,
      footprintTextureId: json['FootprintTextureID'] ?? 0,
      footprintTextureLength: number('FootprintTextureLength'),
      footprintTextureWidth: number('FootprintTextureWidth'),
      footprintParticleScale: number('FootprintParticleScale'),
      foleyMaterialId: json['FoleyMaterialID'] ?? 0,
      footstepShakeSize: json['FootstepShakeSize'] ?? 0,
      deathThudShakeSize: json['DeathThudShakeSize'] ?? 0,
      soundId: json['SoundID'] ?? 0,
      collisionWidth: number('CollisionWidth'),
      collisionHeight: number('CollisionHeight'),
      mountHeight: number('MountHeight'),
      geoBoxMinX: number('GeoBoxMinX'),
      geoBoxMinY: number('GeoBoxMinY'),
      geoBoxMinZ: number('GeoBoxMinZ'),
      geoBoxMaxX: number('GeoBoxMaxX'),
      geoBoxMaxY: number('GeoBoxMaxY'),
      geoBoxMaxZ: number('GeoBoxMaxZ'),
      worldEffectScale: number('WorldEffectScale'),
      attachedEffectScale: number('AttachedEffectScale'),
      missileCollisionRadius: number('MissileCollisionRadius'),
      missileCollisionPush: number('MissileCollisionPush'),
      missileCollisionRaise: number('MissileCollisionRaise'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Flags': flags,
      'ModelName': modelName,
      'SizeClass': sizeClass,
      'ModelScale': modelScale,
      'BloodID': bloodId,
      'FootprintTextureID': footprintTextureId,
      'FootprintTextureLength': footprintTextureLength,
      'FootprintTextureWidth': footprintTextureWidth,
      'FootprintParticleScale': footprintParticleScale,
      'FoleyMaterialID': foleyMaterialId,
      'FootstepShakeSize': footstepShakeSize,
      'DeathThudShakeSize': deathThudShakeSize,
      'SoundID': soundId,
      'CollisionWidth': collisionWidth,
      'CollisionHeight': collisionHeight,
      'MountHeight': mountHeight,
      'GeoBoxMinX': geoBoxMinX,
      'GeoBoxMinY': geoBoxMinY,
      'GeoBoxMinZ': geoBoxMinZ,
      'GeoBoxMaxX': geoBoxMaxX,
      'GeoBoxMaxY': geoBoxMaxY,
      'GeoBoxMaxZ': geoBoxMaxZ,
      'WorldEffectScale': worldEffectScale,
      'AttachedEffectScale': attachedEffectScale,
      'MissileCollisionRadius': missileCollisionRadius,
      'MissileCollisionPush': missileCollisionPush,
      'MissileCollisionRaise': missileCollisionRaise,
    };
  }

  CreatureModelDataEntity copyWith({
    int? id,
    int? flags,
    String? modelName,
    int? sizeClass,
    double? modelScale,
    int? bloodId,
    int? footprintTextureId,
    double? footprintTextureLength,
    double? footprintTextureWidth,
    double? footprintParticleScale,
    int? foleyMaterialId,
    int? footstepShakeSize,
    int? deathThudShakeSize,
    int? soundId,
    double? collisionWidth,
    double? collisionHeight,
    double? mountHeight,
    double? geoBoxMinX,
    double? geoBoxMinY,
    double? geoBoxMinZ,
    double? geoBoxMaxX,
    double? geoBoxMaxY,
    double? geoBoxMaxZ,
    double? worldEffectScale,
    double? attachedEffectScale,
    double? missileCollisionRadius,
    double? missileCollisionPush,
    double? missileCollisionRaise,
  }) {
    return CreatureModelDataEntity(
      id: id ?? this.id,
      flags: flags ?? this.flags,
      modelName: modelName ?? this.modelName,
      sizeClass: sizeClass ?? this.sizeClass,
      modelScale: modelScale ?? this.modelScale,
      bloodId: bloodId ?? this.bloodId,
      footprintTextureId: footprintTextureId ?? this.footprintTextureId,
      footprintTextureLength:
          footprintTextureLength ?? this.footprintTextureLength,
      footprintTextureWidth:
          footprintTextureWidth ?? this.footprintTextureWidth,
      footprintParticleScale:
          footprintParticleScale ?? this.footprintParticleScale,
      foleyMaterialId: foleyMaterialId ?? this.foleyMaterialId,
      footstepShakeSize: footstepShakeSize ?? this.footstepShakeSize,
      deathThudShakeSize: deathThudShakeSize ?? this.deathThudShakeSize,
      soundId: soundId ?? this.soundId,
      collisionWidth: collisionWidth ?? this.collisionWidth,
      collisionHeight: collisionHeight ?? this.collisionHeight,
      mountHeight: mountHeight ?? this.mountHeight,
      geoBoxMinX: geoBoxMinX ?? this.geoBoxMinX,
      geoBoxMinY: geoBoxMinY ?? this.geoBoxMinY,
      geoBoxMinZ: geoBoxMinZ ?? this.geoBoxMinZ,
      geoBoxMaxX: geoBoxMaxX ?? this.geoBoxMaxX,
      geoBoxMaxY: geoBoxMaxY ?? this.geoBoxMaxY,
      geoBoxMaxZ: geoBoxMaxZ ?? this.geoBoxMaxZ,
      worldEffectScale: worldEffectScale ?? this.worldEffectScale,
      attachedEffectScale: attachedEffectScale ?? this.attachedEffectScale,
      missileCollisionRadius:
          missileCollisionRadius ?? this.missileCollisionRadius,
      missileCollisionPush: missileCollisionPush ?? this.missileCollisionPush,
      missileCollisionRaise:
          missileCollisionRaise ?? this.missileCollisionRaise,
    );
  }
}
