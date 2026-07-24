// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_model_data_entity.dart';

mixin _CreatureModelDataEntityMixin {
  static CreatureModelDataEntity fromJson(Map<String, dynamic> json) {
    return CreatureModelDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      flags: (json['Flags'] as num?)?.toInt() ?? 0,
      modelName: json['ModelName']?.toString() ?? '',
      sizeClass: (json['SizeClass'] as num?)?.toInt() ?? 0,
      modelScale: (json['ModelScale'] as num?)?.toDouble() ?? 0.0,
      bloodId: (json['BloodID'] as num?)?.toInt() ?? 0,
      footprintTextureId: (json['FootprintTextureID'] as num?)?.toInt() ?? 0,
      footprintTextureLength:
          (json['FootprintTextureLength'] as num?)?.toDouble() ?? 0.0,
      footprintTextureWidth:
          (json['FootprintTextureWidth'] as num?)?.toDouble() ?? 0.0,
      footprintParticleScale:
          (json['FootprintParticleScale'] as num?)?.toDouble() ?? 0.0,
      foleyMaterialId: (json['FoleyMaterialID'] as num?)?.toInt() ?? 0,
      footstepShakeSize: (json['FootstepShakeSize'] as num?)?.toInt() ?? 0,
      deathThudShakeSize: (json['DeathThudShakeSize'] as num?)?.toInt() ?? 0,
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      collisionWidth: (json['CollisionWidth'] as num?)?.toDouble() ?? 0.0,
      collisionHeight: (json['CollisionHeight'] as num?)?.toDouble() ?? 0.0,
      mountHeight: (json['MountHeight'] as num?)?.toDouble() ?? 0.0,
      geoBoxMinX: (json['GeoBoxMinX'] as num?)?.toDouble() ?? 0.0,
      geoBoxMinY: (json['GeoBoxMinY'] as num?)?.toDouble() ?? 0.0,
      geoBoxMinZ: (json['GeoBoxMinZ'] as num?)?.toDouble() ?? 0.0,
      geoBoxMaxX: (json['GeoBoxMaxX'] as num?)?.toDouble() ?? 0.0,
      geoBoxMaxY: (json['GeoBoxMaxY'] as num?)?.toDouble() ?? 0.0,
      geoBoxMaxZ: (json['GeoBoxMaxZ'] as num?)?.toDouble() ?? 0.0,
      worldEffectScale: (json['WorldEffectScale'] as num?)?.toDouble() ?? 0.0,
      attachedEffectScale:
          (json['AttachedEffectScale'] as num?)?.toDouble() ?? 0.0,
      missileCollisionRadius:
          (json['MissileCollisionRadius'] as num?)?.toDouble() ?? 0.0,
      missileCollisionPush:
          (json['MissileCollisionPush'] as num?)?.toDouble() ?? 0.0,
      missileCollisionRaise:
          (json['MissileCollisionRaise'] as num?)?.toDouble() ?? 0.0,
    );
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
    final self = this as CreatureModelDataEntity;
    return CreatureModelDataEntity(
      id: id ?? self.id,
      flags: flags ?? self.flags,
      modelName: modelName ?? self.modelName,
      sizeClass: sizeClass ?? self.sizeClass,
      modelScale: modelScale ?? self.modelScale,
      bloodId: bloodId ?? self.bloodId,
      footprintTextureId: footprintTextureId ?? self.footprintTextureId,
      footprintTextureLength:
          footprintTextureLength ?? self.footprintTextureLength,
      footprintTextureWidth:
          footprintTextureWidth ?? self.footprintTextureWidth,
      footprintParticleScale:
          footprintParticleScale ?? self.footprintParticleScale,
      foleyMaterialId: foleyMaterialId ?? self.foleyMaterialId,
      footstepShakeSize: footstepShakeSize ?? self.footstepShakeSize,
      deathThudShakeSize: deathThudShakeSize ?? self.deathThudShakeSize,
      soundId: soundId ?? self.soundId,
      collisionWidth: collisionWidth ?? self.collisionWidth,
      collisionHeight: collisionHeight ?? self.collisionHeight,
      mountHeight: mountHeight ?? self.mountHeight,
      geoBoxMinX: geoBoxMinX ?? self.geoBoxMinX,
      geoBoxMinY: geoBoxMinY ?? self.geoBoxMinY,
      geoBoxMinZ: geoBoxMinZ ?? self.geoBoxMinZ,
      geoBoxMaxX: geoBoxMaxX ?? self.geoBoxMaxX,
      geoBoxMaxY: geoBoxMaxY ?? self.geoBoxMaxY,
      geoBoxMaxZ: geoBoxMaxZ ?? self.geoBoxMaxZ,
      worldEffectScale: worldEffectScale ?? self.worldEffectScale,
      attachedEffectScale: attachedEffectScale ?? self.attachedEffectScale,
      missileCollisionRadius:
          missileCollisionRadius ?? self.missileCollisionRadius,
      missileCollisionPush: missileCollisionPush ?? self.missileCollisionPush,
      missileCollisionRaise:
          missileCollisionRaise ?? self.missileCollisionRaise,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureModelDataEntity;
    return {
      'ID': self.id,
      'Flags': self.flags,
      'ModelName': self.modelName,
      'SizeClass': self.sizeClass,
      'ModelScale': self.modelScale,
      'BloodID': self.bloodId,
      'FootprintTextureID': self.footprintTextureId,
      'FootprintTextureLength': self.footprintTextureLength,
      'FootprintTextureWidth': self.footprintTextureWidth,
      'FootprintParticleScale': self.footprintParticleScale,
      'FoleyMaterialID': self.foleyMaterialId,
      'FootstepShakeSize': self.footstepShakeSize,
      'DeathThudShakeSize': self.deathThudShakeSize,
      'SoundID': self.soundId,
      'CollisionWidth': self.collisionWidth,
      'CollisionHeight': self.collisionHeight,
      'MountHeight': self.mountHeight,
      'GeoBoxMinX': self.geoBoxMinX,
      'GeoBoxMinY': self.geoBoxMinY,
      'GeoBoxMinZ': self.geoBoxMinZ,
      'GeoBoxMaxX': self.geoBoxMaxX,
      'GeoBoxMaxY': self.geoBoxMaxY,
      'GeoBoxMaxZ': self.geoBoxMaxZ,
      'WorldEffectScale': self.worldEffectScale,
      'AttachedEffectScale': self.attachedEffectScale,
      'MissileCollisionRadius': self.missileCollisionRadius,
      'MissileCollisionPush': self.missileCollisionPush,
      'MissileCollisionRaise': self.missileCollisionRaise,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureModelDataEntity;
    return identical(self, other) ||
        other is CreatureModelDataEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.flags == other.flags &&
            self.modelName == other.modelName &&
            self.sizeClass == other.sizeClass &&
            self.modelScale == other.modelScale &&
            self.bloodId == other.bloodId &&
            self.footprintTextureId == other.footprintTextureId &&
            self.footprintTextureLength == other.footprintTextureLength &&
            self.footprintTextureWidth == other.footprintTextureWidth &&
            self.footprintParticleScale == other.footprintParticleScale &&
            self.foleyMaterialId == other.foleyMaterialId &&
            self.footstepShakeSize == other.footstepShakeSize &&
            self.deathThudShakeSize == other.deathThudShakeSize &&
            self.soundId == other.soundId &&
            self.collisionWidth == other.collisionWidth &&
            self.collisionHeight == other.collisionHeight &&
            self.mountHeight == other.mountHeight &&
            self.geoBoxMinX == other.geoBoxMinX &&
            self.geoBoxMinY == other.geoBoxMinY &&
            self.geoBoxMinZ == other.geoBoxMinZ &&
            self.geoBoxMaxX == other.geoBoxMaxX &&
            self.geoBoxMaxY == other.geoBoxMaxY &&
            self.geoBoxMaxZ == other.geoBoxMaxZ &&
            self.worldEffectScale == other.worldEffectScale &&
            self.attachedEffectScale == other.attachedEffectScale &&
            self.missileCollisionRadius == other.missileCollisionRadius &&
            self.missileCollisionPush == other.missileCollisionPush &&
            self.missileCollisionRaise == other.missileCollisionRaise;
  }

  @override
  int get hashCode {
    final self = this as CreatureModelDataEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.flags,
      self.modelName,
      self.sizeClass,
      self.modelScale,
      self.bloodId,
      self.footprintTextureId,
      self.footprintTextureLength,
      self.footprintTextureWidth,
      self.footprintParticleScale,
      self.foleyMaterialId,
      self.footstepShakeSize,
      self.deathThudShakeSize,
      self.soundId,
      self.collisionWidth,
      self.collisionHeight,
      self.mountHeight,
      self.geoBoxMinX,
      self.geoBoxMinY,
      self.geoBoxMinZ,
      self.geoBoxMaxX,
      self.geoBoxMaxY,
      self.geoBoxMaxZ,
      self.worldEffectScale,
      self.attachedEffectScale,
      self.missileCollisionRadius,
      self.missileCollisionPush,
      self.missileCollisionRaise,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureModelDataEntity;
    return 'CreatureModelDataEntity('
        'id: ${self.id}, '
        'flags: ${self.flags}, '
        'modelName: ${self.modelName}, '
        'sizeClass: ${self.sizeClass}, '
        'modelScale: ${self.modelScale}, '
        'bloodId: ${self.bloodId}, '
        'footprintTextureId: ${self.footprintTextureId}, '
        'footprintTextureLength: ${self.footprintTextureLength}, '
        'footprintTextureWidth: ${self.footprintTextureWidth}, '
        'footprintParticleScale: ${self.footprintParticleScale}, '
        'foleyMaterialId: ${self.foleyMaterialId}, '
        'footstepShakeSize: ${self.footstepShakeSize}, '
        'deathThudShakeSize: ${self.deathThudShakeSize}, '
        'soundId: ${self.soundId}, '
        'collisionWidth: ${self.collisionWidth}, '
        'collisionHeight: ${self.collisionHeight}, '
        'mountHeight: ${self.mountHeight}, '
        'geoBoxMinX: ${self.geoBoxMinX}, '
        'geoBoxMinY: ${self.geoBoxMinY}, '
        'geoBoxMinZ: ${self.geoBoxMinZ}, '
        'geoBoxMaxX: ${self.geoBoxMaxX}, '
        'geoBoxMaxY: ${self.geoBoxMaxY}, '
        'geoBoxMaxZ: ${self.geoBoxMaxZ}, '
        'worldEffectScale: ${self.worldEffectScale}, '
        'attachedEffectScale: ${self.attachedEffectScale}, '
        'missileCollisionRadius: ${self.missileCollisionRadius}, '
        'missileCollisionPush: ${self.missileCollisionPush}, '
        'missileCollisionRaise: ${self.missileCollisionRaise}'
        ')';
  }
}

final class BriefCreatureModelDataEntity {
  final int id;
  final String modelName;
  final int sizeClass;
  final double modelScale;

  const BriefCreatureModelDataEntity({
    this.id = 0,
    this.modelName = '',
    this.sizeClass = 0,
    this.modelScale = 0.0,
  });

  factory BriefCreatureModelDataEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureModelDataEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      modelName: json['ModelName']?.toString() ?? '',
      sizeClass: (json['SizeClass'] as num?)?.toInt() ?? 0,
      modelScale: (json['ModelScale'] as num?)?.toDouble() ?? 0.0,
    );
  }

  int get key => id;
}
