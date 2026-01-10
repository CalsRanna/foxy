/// 生物模板附加数据
class CreatureTemplateAddon {
  int entry = 0;
  int pathId = 0;
  int mount = 0;
  int emote = 0;
  int visibilityDistanceType = 0;
  String auras = '';

  CreatureTemplateAddon();

  CreatureTemplateAddon.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    pathId = json['path_id'] ?? 0;
    mount = json['mount'] ?? 0;
    emote = json['emote'] ?? 0;
    visibilityDistanceType = json['visibilityDistanceType'] ?? 0;
    auras = json['auras'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'path_id': pathId,
      'mount': mount,
      'emote': emote,
      'visibilityDistanceType': visibilityDistanceType,
      'auras': auras,
    };
  }
}
