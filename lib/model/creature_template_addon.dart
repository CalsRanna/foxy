/// 生物模板附加数据
class CreatureTemplateAddon {
  int entry = 0;
  int pathId = 0;
  int mount = 0;
  int emote = 0;
  int bytes1 = 0;
  int bytes2 = 0;
  String auras = '';
  int isLarge = 0;

  CreatureTemplateAddon();

  CreatureTemplateAddon.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? 0;
    pathId = json['path_id'] ?? 0;
    mount = json['mount'] ?? 0;
    emote = json['emote'] ?? 0;
    bytes1 = json['bytes1'] ?? 0;
    bytes2 = json['bytes2'] ?? 0;
    auras = json['auras'] ?? '';
    isLarge = json['isLarge'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'path_id': pathId,
      'mount': mount,
      'emote': emote,
      'bytes1': bytes1,
      'bytes2': bytes2,
      'auras': auras,
      'isLarge': isLarge,
    };
  }
}
