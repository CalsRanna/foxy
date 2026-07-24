// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_display_info_entity.dart';

mixin _CreatureDisplayInfoEntityMixin {
  int get id;
  int get modelId;
  int get soundId;
  int get extendedDisplayInfoId;
  double get creatureModelScale;
  int get creatureModelAlpha;
  String get textureVariation0;
  String get textureVariation1;
  String get textureVariation2;
  String get portraitTextureName;
  int get sizeClass;
  int get bloodID;
  int get npcSoundID;
  int get particleColorID;
  int get creatureGeosetData;
  int get objectEffectPackageID;

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
    return CreatureDisplayInfoEntity(
      id: id ?? this.id,
      modelId: modelId ?? this.modelId,
      soundId: soundId ?? this.soundId,
      extendedDisplayInfoId:
          extendedDisplayInfoId ?? this.extendedDisplayInfoId,
      creatureModelScale: creatureModelScale ?? this.creatureModelScale,
      creatureModelAlpha: creatureModelAlpha ?? this.creatureModelAlpha,
      textureVariation0: textureVariation0 ?? this.textureVariation0,
      textureVariation1: textureVariation1 ?? this.textureVariation1,
      textureVariation2: textureVariation2 ?? this.textureVariation2,
      portraitTextureName: portraitTextureName ?? this.portraitTextureName,
      sizeClass: sizeClass ?? this.sizeClass,
      bloodID: bloodID ?? this.bloodID,
      npcSoundID: npcSoundID ?? this.npcSoundID,
      particleColorID: particleColorID ?? this.particleColorID,
      creatureGeosetData: creatureGeosetData ?? this.creatureGeosetData,
      objectEffectPackageID:
          objectEffectPackageID ?? this.objectEffectPackageID,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ModelID': modelId,
      'SoundID': soundId,
      'ExtendedDisplayInfoID': extendedDisplayInfoId,
      'CreatureModelScale': creatureModelScale,
      'CreatureModelAlpha': creatureModelAlpha,
      'TextureVariation0': textureVariation0,
      'TextureVariation1': textureVariation1,
      'TextureVariation2': textureVariation2,
      'PortraitTextureName': portraitTextureName,
      'SizeClass': sizeClass,
      'BloodID': bloodID,
      'NPCSoundID': npcSoundID,
      'ParticleColorID': particleColorID,
      'CreatureGeosetData': creatureGeosetData,
      'ObjectEffectPackageID': objectEffectPackageID,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CreatureDisplayInfoEntity &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            modelId == other.modelId &&
            soundId == other.soundId &&
            extendedDisplayInfoId == other.extendedDisplayInfoId &&
            creatureModelScale == other.creatureModelScale &&
            creatureModelAlpha == other.creatureModelAlpha &&
            textureVariation0 == other.textureVariation0 &&
            textureVariation1 == other.textureVariation1 &&
            textureVariation2 == other.textureVariation2 &&
            portraitTextureName == other.portraitTextureName &&
            sizeClass == other.sizeClass &&
            bloodID == other.bloodID &&
            npcSoundID == other.npcSoundID &&
            particleColorID == other.particleColorID &&
            creatureGeosetData == other.creatureGeosetData &&
            objectEffectPackageID == other.objectEffectPackageID;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType,
      id,
      modelId,
      soundId,
      extendedDisplayInfoId,
      creatureModelScale,
      creatureModelAlpha,
      textureVariation0,
      textureVariation1,
      textureVariation2,
      portraitTextureName,
      sizeClass,
      bloodID,
      npcSoundID,
      particleColorID,
      creatureGeosetData,
      objectEffectPackageID,
    ]);
  }

  @override
  String toString() {
    return 'CreatureDisplayInfoEntity('
        'id: $id, '
        'modelId: $modelId, '
        'soundId: $soundId, '
        'extendedDisplayInfoId: $extendedDisplayInfoId, '
        'creatureModelScale: $creatureModelScale, '
        'creatureModelAlpha: $creatureModelAlpha, '
        'textureVariation0: $textureVariation0, '
        'textureVariation1: $textureVariation1, '
        'textureVariation2: $textureVariation2, '
        'portraitTextureName: $portraitTextureName, '
        'sizeClass: $sizeClass, '
        'bloodID: $bloodID, '
        'npcSoundID: $npcSoundID, '
        'particleColorID: $particleColorID, '
        'creatureGeosetData: $creatureGeosetData, '
        'objectEffectPackageID: $objectEffectPackageID'
        ')';
  }
}
