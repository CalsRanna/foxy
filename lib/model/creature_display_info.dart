/// 生物显示信息（模型）
class CreatureDisplayInfo {
  int id = 0;
  int modelId = 0;
  int soundId = 0;
  int extendedDisplayInfoId = 0;
  double creatureModelScale = 1.0;
  int creatureModelAlpha = 0;
  String textureVariation0 = '';
  String textureVariation1 = '';
  String textureVariation2 = '';
  String portraitTextureName = '';
  int sizeClass = 0;
  int bloodID = 0;
  int npcSoundID = 0;
  int particleColorID = 0;
  int creatureGeosetData = 0;
  int objectEffectPackageID = 0;

  /// 来自 dbc_creature_model_data 的模型路径
  String modelName = '';

  CreatureDisplayInfo();

  factory CreatureDisplayInfo.fromJson(Map<String, dynamic> json) {
    return CreatureDisplayInfo()
      ..id = json['ID'] ?? json['id'] ?? 0
      ..modelId = json['ModelID'] ?? json['ModelId'] ?? json['modelId'] ?? 0
      ..soundId = json['SoundID'] ?? json['SoundId'] ?? json['soundId'] ?? 0
      ..extendedDisplayInfoId =
          json['ExtendedDisplayInfoID'] ??
          json['ExtendedDisplayInfoId'] ??
          json['extendedDisplayInfoId'] ??
          0
      ..creatureModelScale =
          (json['CreatureModelScale'] ?? json['creatureModelScale'] ?? 1.0)
              .toDouble()
      ..creatureModelAlpha = json['CreatureModelAlpha'] ?? 0
      ..textureVariation0 = json['TextureVariation0'] ?? ''
      ..textureVariation1 = json['TextureVariation1'] ?? ''
      ..textureVariation2 = json['TextureVariation2'] ?? ''
      ..portraitTextureName = json['PortraitTextureName'] ?? ''
      ..sizeClass = json['SizeClass'] ?? 0
      ..bloodID = json['BloodID'] ?? 0
      ..npcSoundID = json['NPCSoundID'] ?? 0
      ..particleColorID = json['ParticleColorID'] ?? 0
      ..creatureGeosetData = json['CreatureGeosetData'] ?? 0
      ..objectEffectPackageID = json['ObjectEffectPackageID'] ?? 0
      ..modelName = json['ModelName'] ?? json['modelName'] ?? '';
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
