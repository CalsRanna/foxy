/// 生物显示信息 — 对应 foxy.dbc_creature_display_info 表
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
  });

  factory CreatureDisplayInfo.fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfo(
      id: json['ID'] ?? 0,
      modelId: json['ModelID'] ?? 0,
      soundId: json['SoundID'] ?? 0,
      extendedDisplayInfoId: json['ExtendedDisplayInfoID'] ?? 0,
      creatureModelScale:
          (json['CreatureModelScale'] as num?)?.toDouble() ?? 1.0,
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

/// 生物显示信息列表展示模型（含 LEFT JOIN foxy.dbc_creature_model_data 的模型名）
class BriefCreatureDisplayInfo {
  final int id;
  final int modelId;
  final double creatureModelScale;
  final int sizeClass;
  final int bloodID;
  final String modelName;

  const BriefCreatureDisplayInfo({
    this.id = 0,
    this.modelId = 0,
    this.creatureModelScale = 1.0,
    this.sizeClass = 0,
    this.bloodID = 0,
    this.modelName = '',
  });

  factory BriefCreatureDisplayInfo.fromJson(Map<String, dynamic> json) {
    return BriefCreatureDisplayInfo(
      id: json['ID'] ?? 0,
      modelId: json['ModelID'] ?? 0,
      creatureModelScale:
          (json['CreatureModelScale'] as num?)?.toDouble() ?? 1.0,
      sizeClass: json['SizeClass'] ?? 0,
      bloodID: json['BloodID'] ?? 0,
      modelName: json['ModelName'] ?? '',
    );
  }
}
