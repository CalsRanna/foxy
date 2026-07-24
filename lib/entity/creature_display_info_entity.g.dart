// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_display_info_entity.dart';

mixin _CreatureDisplayInfoEntityMixin {
  static CreatureDisplayInfoEntity fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      modelId: (json['ModelID'] as num?)?.toInt() ?? 0,
      soundId: (json['SoundID'] as num?)?.toInt() ?? 0,
      extendedDisplayInfoId:
          (json['ExtendedDisplayInfoID'] as num?)?.toInt() ?? 0,
      creatureModelScale:
          (json['CreatureModelScale'] as num?)?.toDouble() ?? 1.0,
      creatureModelAlpha: (json['CreatureModelAlpha'] as num?)?.toInt() ?? 0,
      textureVariation0: json['TextureVariation0']?.toString() ?? '',
      textureVariation1: json['TextureVariation1']?.toString() ?? '',
      textureVariation2: json['TextureVariation2']?.toString() ?? '',
      portraitTextureName: json['PortraitTextureName']?.toString() ?? '',
      sizeClass: (json['SizeClass'] as num?)?.toInt() ?? 0,
      bloodID: (json['BloodID'] as num?)?.toInt() ?? 0,
      npcSoundID: (json['NPCSoundID'] as num?)?.toInt() ?? 0,
      particleColorID: (json['ParticleColorID'] as num?)?.toInt() ?? 0,
      creatureGeosetData: (json['CreatureGeosetData'] as num?)?.toInt() ?? 0,
      objectEffectPackageID:
          (json['ObjectEffectPackageID'] as num?)?.toInt() ?? 0,
    );
  }

  CreatureDisplayInfoEntity copyWith({
    int? id,
    int? modelId,
    int? soundId,
    int? extendedDisplayInfoId,
    double? creatureModelScale,
    int? creatureModelAlpha,
    String? textureVariation0,
    String? textureVariation1,
    String? textureVariation2,
    String? portraitTextureName,
    int? sizeClass,
    int? bloodID,
    int? npcSoundID,
    int? particleColorID,
    int? creatureGeosetData,
    int? objectEffectPackageID,
  }) {
    final self = this as CreatureDisplayInfoEntity;
    return CreatureDisplayInfoEntity(
      id: id ?? self.id,
      modelId: modelId ?? self.modelId,
      soundId: soundId ?? self.soundId,
      extendedDisplayInfoId:
          extendedDisplayInfoId ?? self.extendedDisplayInfoId,
      creatureModelScale: creatureModelScale ?? self.creatureModelScale,
      creatureModelAlpha: creatureModelAlpha ?? self.creatureModelAlpha,
      textureVariation0: textureVariation0 ?? self.textureVariation0,
      textureVariation1: textureVariation1 ?? self.textureVariation1,
      textureVariation2: textureVariation2 ?? self.textureVariation2,
      portraitTextureName: portraitTextureName ?? self.portraitTextureName,
      sizeClass: sizeClass ?? self.sizeClass,
      bloodID: bloodID ?? self.bloodID,
      npcSoundID: npcSoundID ?? self.npcSoundID,
      particleColorID: particleColorID ?? self.particleColorID,
      creatureGeosetData: creatureGeosetData ?? self.creatureGeosetData,
      objectEffectPackageID:
          objectEffectPackageID ?? self.objectEffectPackageID,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureDisplayInfoEntity;
    return {
      'ID': self.id,
      'ModelID': self.modelId,
      'SoundID': self.soundId,
      'ExtendedDisplayInfoID': self.extendedDisplayInfoId,
      'CreatureModelScale': self.creatureModelScale,
      'CreatureModelAlpha': self.creatureModelAlpha,
      'TextureVariation0': self.textureVariation0,
      'TextureVariation1': self.textureVariation1,
      'TextureVariation2': self.textureVariation2,
      'PortraitTextureName': self.portraitTextureName,
      'SizeClass': self.sizeClass,
      'BloodID': self.bloodID,
      'NPCSoundID': self.npcSoundID,
      'ParticleColorID': self.particleColorID,
      'CreatureGeosetData': self.creatureGeosetData,
      'ObjectEffectPackageID': self.objectEffectPackageID,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureDisplayInfoEntity;
    return identical(self, other) ||
        other is CreatureDisplayInfoEntity &&
            self.runtimeType == other.runtimeType &&
            self.id == other.id &&
            self.modelId == other.modelId &&
            self.soundId == other.soundId &&
            self.extendedDisplayInfoId == other.extendedDisplayInfoId &&
            self.creatureModelScale == other.creatureModelScale &&
            self.creatureModelAlpha == other.creatureModelAlpha &&
            self.textureVariation0 == other.textureVariation0 &&
            self.textureVariation1 == other.textureVariation1 &&
            self.textureVariation2 == other.textureVariation2 &&
            self.portraitTextureName == other.portraitTextureName &&
            self.sizeClass == other.sizeClass &&
            self.bloodID == other.bloodID &&
            self.npcSoundID == other.npcSoundID &&
            self.particleColorID == other.particleColorID &&
            self.creatureGeosetData == other.creatureGeosetData &&
            self.objectEffectPackageID == other.objectEffectPackageID;
  }

  @override
  int get hashCode {
    final self = this as CreatureDisplayInfoEntity;
    return Object.hashAll([
      self.runtimeType,
      self.id,
      self.modelId,
      self.soundId,
      self.extendedDisplayInfoId,
      self.creatureModelScale,
      self.creatureModelAlpha,
      self.textureVariation0,
      self.textureVariation1,
      self.textureVariation2,
      self.portraitTextureName,
      self.sizeClass,
      self.bloodID,
      self.npcSoundID,
      self.particleColorID,
      self.creatureGeosetData,
      self.objectEffectPackageID,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureDisplayInfoEntity;
    return 'CreatureDisplayInfoEntity('
        'id: ${self.id}, '
        'modelId: ${self.modelId}, '
        'soundId: ${self.soundId}, '
        'extendedDisplayInfoId: ${self.extendedDisplayInfoId}, '
        'creatureModelScale: ${self.creatureModelScale}, '
        'creatureModelAlpha: ${self.creatureModelAlpha}, '
        'textureVariation0: ${self.textureVariation0}, '
        'textureVariation1: ${self.textureVariation1}, '
        'textureVariation2: ${self.textureVariation2}, '
        'portraitTextureName: ${self.portraitTextureName}, '
        'sizeClass: ${self.sizeClass}, '
        'bloodID: ${self.bloodID}, '
        'npcSoundID: ${self.npcSoundID}, '
        'particleColorID: ${self.particleColorID}, '
        'creatureGeosetData: ${self.creatureGeosetData}, '
        'objectEffectPackageID: ${self.objectEffectPackageID}'
        ')';
  }
}

final class BriefCreatureDisplayInfoEntity {
  final int id;
  final int modelId;
  final double creatureModelScale;
  final int sizeClass;
  final int bloodID;
  final String modelName;

  const BriefCreatureDisplayInfoEntity({
    this.id = 0,
    this.modelId = 0,
    this.creatureModelScale = 1.0,
    this.sizeClass = 0,
    this.bloodID = 0,
    this.modelName = '',
  });

  factory BriefCreatureDisplayInfoEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureDisplayInfoEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      modelId: (json['ModelID'] as num?)?.toInt() ?? 0,
      creatureModelScale:
          (json['CreatureModelScale'] as num?)?.toDouble() ?? 1.0,
      sizeClass: (json['SizeClass'] as num?)?.toInt() ?? 0,
      bloodID: (json['BloodID'] as num?)?.toInt() ?? 0,
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  int get key => id;
}
