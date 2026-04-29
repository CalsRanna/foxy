// gameobject_questender 模型
// 复合主键 (id, quest)

class GameobjectQuestender {
  int id = 0;
  int quest = 0;

  GameobjectQuestender();

  factory GameobjectQuestender.fromJson(Map<String, dynamic> json) {
    return GameobjectQuestender()
      ..id = json['id'] ?? 0
      ..quest = json['quest'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

/// Brief 版本（LEFT JOIN gameobject_template 获取名称，无 locale 表）
class BriefGameobjectQuestender {
  int id = 0;
  int quest = 0;
  String name = '';
  String localeName = '';

  BriefGameobjectQuestender();

  factory BriefGameobjectQuestender.fromJson(Map<String, dynamic> json) {
    return BriefGameobjectQuestender()
      ..id = json['id'] ?? 0
      ..quest = json['quest'] ?? 0
      ..name = json['name']?.toString() ?? ''
      ..localeName = json['Name']?.toString() ?? '';
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;
}
