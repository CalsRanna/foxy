class CreatureDisplayInfo {
  final int id;
  final int modelId;
  final int soundId;
  final int extendedDisplayInfoId;
  final double creatureModelScale;
  final int creatureModelAlpha;
  final String textureVariation0;
  final String textureVariation1;
  final String textureVariation2;
  final String portraitTextureName;
  final int sizeClass;
  final int bloodID;
  final int npcSoundID;
  final int particleColorID;
  final int creatureGeosetData;
  final int objectEffectPackageID;
  final String modelName;

  const CreatureDisplayInfo({
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
    this.modelName = '',
  });

  factory CreatureDisplayInfo.fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfo(
      id: json['ID'] ?? json['id'] ?? 0,
      modelId: json['ModelID'] ?? json['ModelId'] ?? json['modelId'] ?? 0,
      soundId: json['SoundID'] ?? json['SoundId'] ?? json['soundId'] ?? 0,
      extendedDisplayInfoId: json['ExtendedDisplayInfoID'] ??
          json['ExtendedDisplayInfoId'] ??
          json['extendedDisplayInfoId'] ??
          0,
      creatureModelScale:
          (json['CreatureModelScale'] ?? json['creatureModelScale'] ?? 1.0)
              .toDouble(),
      creatureModelAlpha: json['CreatureModelAlpha'] ?? 0,
      textureVariation0: json['TextureVariation0'] ?? '',
      textureVariation1: json['TextureVariation1'] ?? '',
      textureVariation2: json['TextureVariation2'] ?? '',
      portraitTextureName: json['PortraitTextureName'] ?? '',
      sizeClass: json['SizeClass'] ?? 0,
      bloodID: json['BloodID'] ?? 0,
      npcSoundID: json['NPCSoundID'] ?? 0,
      particleColorID: json['ParticleColorID'] ?? 0,
      creatureGeosetData: json['CreatureGeosetData'] ?? 0,
      objectEffectPackageID: json['ObjectEffectPackageID'] ?? 0,
      modelName: json['ModelName'] ?? json['modelName'] ?? '',
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
}
