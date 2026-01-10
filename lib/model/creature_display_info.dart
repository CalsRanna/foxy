/// 生物显示信息（模型）
class CreatureDisplayInfo {
  int id = 0;
  int modelId = 0;
  int soundId = 0;
  int extendedDisplayInfoId = 0;
  double creatureModelScale = 1.0;

  CreatureDisplayInfo();

  CreatureDisplayInfo.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? json['id'] ?? 0;
    modelId = json['ModelID'] ?? json['ModelId'] ?? json['modelId'] ?? 0;
    soundId = json['SoundID'] ?? json['SoundId'] ?? json['soundId'] ?? 0;
    extendedDisplayInfoId = json['ExtendedDisplayInfoID'] ??
        json['ExtendedDisplayInfoId'] ??
        json['extendedDisplayInfoId'] ??
        0;
    creatureModelScale = (json['CreatureModelScale'] ??
            json['creatureModelScale'] ??
            1.0)
        .toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ModelID': modelId,
      'SoundID': soundId,
      'ExtendedDisplayInfoID': extendedDisplayInfoId,
      'CreatureModelScale': creatureModelScale,
    };
  }
}
