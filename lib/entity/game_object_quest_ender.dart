// gameobject_questender 模型
// 复合主键 (id, quest)

class GameObjectQuestEnder {
  final int id;
  final int quest;

  const GameObjectQuestEnder({this.id = 0, this.quest = 0});

  factory GameObjectQuestEnder.fromJson(Map<String, dynamic> json) {
    return GameObjectQuestEnder(id: json['id'] ?? 0, quest: json['quest'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

/// Brief 版本（LEFT JOIN gameobject_template 获取名称，无 locale 表）
class BriefGameObjectQuestEnder {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefGameObjectQuestEnder({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefGameObjectQuestEnder.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectQuestEnder(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
      name: json['name']?.toString() ?? '',
      localeName: json['Name']?.toString() ?? '',
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest, 'name': name, 'Name': localeName};
  }
}
