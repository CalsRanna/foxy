// gameobject_questender 模型
// 复合主键 (id, quest)

class GameObjectQuestEnderEntity {
  final int id;
  final int quest;

  const GameObjectQuestEnderEntity({this.id = 0, this.quest = 0});

  factory GameObjectQuestEnderEntity.fromJson(Map<String, dynamic> json) {
    return GameObjectQuestEnderEntity(
      id: json['id'] ?? 0,
      quest: json['quest'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'quest': quest};
  }
}

/// Brief 版本（LEFT JOIN gameobject_template 获取名称，无 locale 表）
class BriefGameObjectQuestEnderEntity {
  final int id;
  final int quest;
  final String name;
  final String localeName;

  const BriefGameObjectQuestEnderEntity({
    this.id = 0,
    this.quest = 0,
    this.name = '',
    this.localeName = '',
  });

  factory BriefGameObjectQuestEnderEntity.fromJson(Map<String, dynamic> json) {
    return BriefGameObjectQuestEnderEntity(
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
