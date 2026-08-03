// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_display_info_entity.dart';

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
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      modelId: json['ModelID'] == true
          ? 1
          : json['ModelID'] == false
          ? 0
          : (json['ModelID'] as num?)?.toInt() ?? 0,
      creatureModelScale:
          (json['CreatureModelScale'] as num?)?.toDouble() ?? 1.0,
      sizeClass: json['SizeClass'] == true
          ? 1
          : json['SizeClass'] == false
          ? 0
          : (json['SizeClass'] as num?)?.toInt() ?? 0,
      bloodID: json['BloodID'] == true
          ? 1
          : json['BloodID'] == false
          ? 0
          : (json['BloodID'] as num?)?.toInt() ?? 0,
      modelName: json['modelName']?.toString() ?? '',
    );
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    modelId,
    creatureModelScale,
    sizeClass,
    bloodID,
    modelName,
  ]);

  int get key => id;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BriefCreatureDisplayInfoEntity &&
            id == other.id &&
            modelId == other.modelId &&
            creatureModelScale == other.creatureModelScale &&
            sizeClass == other.sizeClass &&
            bloodID == other.bloodID &&
            modelName == other.modelName;
  }

  @override
  String toString() {
    return 'BriefCreatureDisplayInfoEntity('
        'id: $id, '
        'modelId: $modelId, '
        'creatureModelScale: $creatureModelScale, '
        'sizeClass: $sizeClass, '
        'bloodID: $bloodID, '
        'modelName: $modelName'
        ')';
  }
}

mixin _CreatureDisplayInfoEntityMixin {
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

  static CreatureDisplayInfoEntity fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfoEntity(
      id: json['ID'] == true
          ? 1
          : json['ID'] == false
          ? 0
          : (json['ID'] as num?)?.toInt() ?? 0,
      modelId: json['ModelID'] == true
          ? 1
          : json['ModelID'] == false
          ? 0
          : (json['ModelID'] as num?)?.toInt() ?? 0,
      soundId: json['SoundID'] == true
          ? 1
          : json['SoundID'] == false
          ? 0
          : (json['SoundID'] as num?)?.toInt() ?? 0,
      extendedDisplayInfoId: json['ExtendedDisplayInfoID'] == true
          ? 1
          : json['ExtendedDisplayInfoID'] == false
          ? 0
          : (json['ExtendedDisplayInfoID'] as num?)?.toInt() ?? 0,
      creatureModelScale:
          (json['CreatureModelScale'] as num?)?.toDouble() ?? 1.0,
      creatureModelAlpha: json['CreatureModelAlpha'] == true
          ? 1
          : json['CreatureModelAlpha'] == false
          ? 0
          : (json['CreatureModelAlpha'] as num?)?.toInt() ?? 0,
      textureVariation0: json['TextureVariation0']?.toString() ?? '',
      textureVariation1: json['TextureVariation1']?.toString() ?? '',
      textureVariation2: json['TextureVariation2']?.toString() ?? '',
      portraitTextureName: json['PortraitTextureName']?.toString() ?? '',
      sizeClass: json['SizeClass'] == true
          ? 1
          : json['SizeClass'] == false
          ? 0
          : (json['SizeClass'] as num?)?.toInt() ?? 0,
      bloodID: json['BloodID'] == true
          ? 1
          : json['BloodID'] == false
          ? 0
          : (json['BloodID'] as num?)?.toInt() ?? 0,
      npcSoundID: json['NPCSoundID'] == true
          ? 1
          : json['NPCSoundID'] == false
          ? 0
          : (json['NPCSoundID'] as num?)?.toInt() ?? 0,
      particleColorID: json['ParticleColorID'] == true
          ? 1
          : json['ParticleColorID'] == false
          ? 0
          : (json['ParticleColorID'] as num?)?.toInt() ?? 0,
      creatureGeosetData: json['CreatureGeosetData'] == true
          ? 1
          : json['CreatureGeosetData'] == false
          ? 0
          : (json['CreatureGeosetData'] as num?)?.toInt() ?? 0,
      objectEffectPackageID: json['ObjectEffectPackageID'] == true
          ? 1
          : json['ObjectEffectPackageID'] == false
          ? 0
          : (json['ObjectEffectPackageID'] as num?)?.toInt() ?? 0,
    );
  }
}
