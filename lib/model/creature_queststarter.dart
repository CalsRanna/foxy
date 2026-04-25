/// creature_queststarter 模型
/// 复合主键 (id, quest)

class CreatureQueststarter {
  int id = 0;
  int quest = 0;

  CreatureQueststarter();

  CreatureQueststarter.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    quest = json['quest'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

/// Brief 版本（LEFT JOIN creature_template + locale 获取名称）
class BriefCreatureQueststarter {
  int id = 0;
  int quest = 0;
  String name = '';
  String localeName = '';

  BriefCreatureQueststarter();

  BriefCreatureQueststarter.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    quest = json['quest'] ?? 0;
    name = json['name']?.toString() ?? '';
    localeName = json['Name']?.toString() ?? '';
  }

  String get displayName =>
      localeName.isNotEmpty ? localeName : name;
}